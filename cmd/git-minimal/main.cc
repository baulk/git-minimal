#include <filesystem>
#include <string>
#include <ranges>
#include <format>
#include <vector>
#include <cstring>
#include <algorithm>
#include <optional>
#include <utility>
#ifdef _WIN32
#include <Windows.h>
#include <process.h>
constexpr const char Separator = ';';
constexpr const std::string_view Separators = ";";
#else
#include <unistd.h>
constexpr const char Separator = ':';
constexpr const std::string_view Separators = ":";
#endif

namespace bela {
template <class F> class final_act {
public:
  explicit final_act(F f) noexcept : f_(std::move(f)), invoke_(true) {}
  final_act(final_act &&other) noexcept : f_(std::move(other.f_)), invoke_(std::exchange(other.invoke_, false)) {}
  final_act(const final_act &) = delete;
  final_act &operator=(const final_act &) = delete;
  ~final_act() noexcept {
    if (invoke_) {
      f_();
    }
  }

private:
  F f_;
  bool invoke_{true};
};
// Final() - convenience function to generate a final_act
template <class F> inline final_act<F> Final(const F &f) noexcept { return final_act<F>(f); }
template <class F> inline final_act<F> Final(F &&f) noexcept { return final_act<F>(std::forward<F>(f)); }
} // namespace bela

constexpr size_t PathSizeMax = 4096;

constexpr int memcasecmp(const char *s1, const char *s2, size_t len) noexcept {
  for (size_t i = 0; i < len; i++) {
    const auto diff = std::tolower(s1[i]) - std::tolower(s2[i]);
    if (diff != 0) {
      return static_cast<int>(diff);
    }
  }
  return 0;
}

bool EqualsIgnoreCase(std::string_view piece1, std::string_view piece2) noexcept {
  return (piece1.size() == piece2.size() && memcasecmp(piece1.data(), piece2.data(), piece1.size()) == 0);
}

bool StartsWithIgnoreCase(std::string_view text, std::string_view prefix) noexcept {
  return (text.size() >= prefix.size()) && EqualsIgnoreCase(text.substr(0, prefix.size()), prefix);
}

std::string Executable() noexcept {
#if defined(_WIN32) // WIN32
  // std::wstring PathName;
  // PathName.resize(PathSizeMax);
  // auto size = ::GetModuleFileNameW(nullptr, PathName.data(), static_cast<DWORD>(PathName.size()));
  // if (size == 0 || static_cast<size_t>(size) == PathSizeMax) {
  //   return "";
  // }
  // PathName.resize(static_cast<size_t>(size));
  // auto FileHandle = CreateFileW(PathName.data(), 0, FILE_SHARE_READ | FILE_SHARE_WRITE | FILE_SHARE_DELETE, nullptr,
  //                               OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, nullptr);
  // // FILE_FLAG_BACKUP_SEMANTICS open directory require
  // if (FileHandle == INVALID_HANDLE_VALUE) {
  //   return encode_into_u8(PathName);
  // }
  // auto AbsPath = readlink(FileHandle);
  // ::CloseHandle(FileHandle);
  // if (AbsPath) {
  //   return encode_into_u8(*AbsPath);
  // }
  // return encode_into_u8(PathName);
#elif defined(__APPLE__) // macOS
  // On OS X the executable path is saved to the stack by dyld. Reading it
  // from there is much faster than calling dladdr, especially for large
  // binaries with symbols.
  char exePath[PATH_MAX];
  uint32_t size = sizeof(exePath);
  if (_NSGetExecutablePath(exePath, &size) == 0) {
    char linkPath[PATH_MAX];
    if (realpath(exePath, linkPath)) {
      return linkPath;
    }
  }
  return "";
#elif defined(__linux__)
  char exePath[PathSizeMax];
  constexpr const char *procSelf = "/proc/self/exe";
  ssize_t len = readlink(procSelf, exePath, sizeof(exePath));
  if (len < 0) {
    return "";
  }
  len = std::min(len, ssize_t(sizeof(exePath) - 1));
  exePath[len] = '\0';
  // On Linux, /proc/self/exe always looks through symlinks. However, on
  // GNU/Hurd, /proc/self/exe is a symlink to the path that was used to start
  // the program, and not the eventual binary file. Therefore, call realpath
  // so this behaves the same on all platforms.
#if _POSIX_VERSION >= 200112 || defined(__GLIBC__)
  if (char *absPath = realpath(exePath, nullptr)) {
    std::string result = std::string(absPath);
    free(absPath);
    return result;
  }
#else
  char absPath[PATH_MAX];
  if (realpath(exePath, absPath)) {
    return std::string(exePath);
  }
#endif
  return "";
#else
  return "";
#endif
}

std::optional<std::string> search_bundle(const std::filesystem::path &prefix) {
  auto bundle = prefix / "share/git-minimal/curl-ca-bundle.crt";
  std::error_code ec;
  if (std::filesystem::exists(bundle, ec)) {
    return std::make_optional<>(bundle.string());
  }
  bundle = prefix / "share/curl-ca-bundle.crt";
  if (std::filesystem::exists(bundle, ec)) {
    return std::make_optional<>(bundle.string());
  }
  return std::nullopt;
}

std::filesystem::path search_root() {
  auto self = Executable();
  return std::filesystem::path(self).parent_path().parent_path(); // auto move
}

std::optional<std::filesystem::path> search_command(const std::filesystem::path &prefix, const char *arg0) {
  auto command = prefix / "bin" / std::filesystem::path(arg0).filename();
  std::error_code ec;
  if (std::filesystem::exists(command)) {
    return std::make_optional<>(std::move(command));
  }
  return std::nullopt;
}

#ifdef _WIN32
int main(int argc, const char *argv[]) { return 0; }
#else
// $prefix/cmd/git
// $prefix/cmd/git-upload-pack
// $prefix/cmd/git-receive-pack
int main(int argc, const char *argv[]) {
  if (argc <= 0) {
    fprintf(stderr, "git-minimal launcher fatal: missing args\n");
    return 1;
  }
  auto self = Executable();
  auto prefix = std::filesystem::path(self).parent_path().parent_path();
  auto command = search_command(prefix, argv[0]);
  if (!command) {
    auto filename = std::filesystem::path(argv[0]).filename().string();
    fprintf(stderr, "git-minimal launcher fatal: command '$prefix/bin/%s' not found\n", filename.c_str());
    return 1;
  }
  if (std::filesystem::equivalent(self, *command)) {
    fprintf(stderr, "git-minimal launcher fatal: self equivalent command\n");
    return 1;
  }
  auto basename = std::filesystem::path(argv[0]).filename().string();
  auto execPath = prefix / "libexec" / "git-core";
  std::vector<char *> newArgs;
  newArgs.push_back(strdup(basename.data()));
  for (int i = 1; i < argc; i++) {
    newArgs.push_back(strdup(argv[i]));
  }
  newArgs.push_back(nullptr);
  auto closer = bela::Final([&] {
    for (auto a : newArgs) {
      if (a != nullptr) {
        std::free(a);
      }
    }
  });
  std::vector<char *> newEnviron;
  std::string execEnv = std::format("GIT_EXEC_PATH={0}", execPath.string()); // GIT_EXEC_PATH
  newEnviron.push_back(execEnv.data());
  // https://en.cppreference.com/w/cpp/filesystem/path/formatter std::format support std::filesystem::path starts C++26
  std::string newPath = std::format("PATH={0}{1}{2}", command->parent_path().string(), Separator, getenv("PATH"));
  newEnviron.push_back(newPath.data());
  // https://git-scm.com/docs/git-config GIT_SSL_CAINFO
  std::string caBundle;
  if (auto bundle = search_bundle(prefix); bundle) {
    caBundle = std::format("GIT_SSL_CAINFO={0}", *bundle);
    newEnviron.push_back(caBundle.data());
  }
  constexpr std::string_view PathEnv = "PATH";
  constexpr std::string_view CAINFO = "GIT_SSL_CAINFO";
  constexpr std::string_view EXEC = "GIT_EXEC_PATH";
  if (environ != nullptr) {
    for (int i = 0;; i++) {
      auto e = environ[i];
      if (e == nullptr) {
        break;
      }
      std::string_view s(e);
      auto pos = s.find('=');
      if (pos == std::string_view::npos) {
        continue;
      }
      auto envKey = s.substr(0, pos);
      if (EqualsIgnoreCase(envKey, PathEnv) || EqualsIgnoreCase(envKey, CAINFO) || EqualsIgnoreCase(envKey, EXEC)) {
        continue;
      }
      newEnviron.push_back(e);
    }
  }
  newEnviron.push_back(nullptr);
  // int execve(const char *pathname, char *const argv[], char *const envp[]);
  auto commandPath = command->string();
  auto result = execve(commandPath.data(), &newArgs[0], &newEnviron[0]);
  if (result != 0) {
    fprintf(stderr, "git-minimal launcher execve failed\n");
    exit(EXIT_FAILURE);
  }
  // Not reached if execve succeeds
  return 0;
}
#endif
