#include <algorithm>
#include <cstdlib>
#include <cstring>
#include <filesystem>
#include <optional>
#include <ranges>
#include <string>
#include <utility>
#include <vector>
#include <unistd.h>
#if defined(__APPLE__)
#include <mach-o/dyld.h>
extern char **environ;
#endif

constexpr const char Separator = ':';
constexpr const std::string_view Separators = ":";

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

constexpr bool string_casecmp(std::string_view piece1, std::string_view piece2) noexcept {
  return (piece1.size() == piece2.size() && memcasecmp(piece1.data(), piece2.data(), piece1.size()) == 0);
}

std::string resolve_executable() noexcept {
#if defined(__APPLE__) // macOS
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
  return std::nullopt;
}

std::filesystem::path search_root() {
  auto self = resolve_executable();
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

bool is_drop_env(std::string_view e) {
  constexpr std::string_view dropEnv[] = {"PATH", "GIT_SSL_CAINFO", "GIT_EXEC_PATH", "GIT_TEMPLATE_DIR"};
  for (const auto d : dropEnv) {
    if (string_casecmp(e, d)) {
      return true;
    }
  }
  return false;
}

template <typename... Args> char *string_cat(const Args &...args) {
  const std::string_view sv[] = {args...};
  size_t sz = 0;
  for (const auto s : sv) {
    sz += s.size();
  }
  char *newPtr = (char *)std::malloc(sz + 1);
  if (newPtr == nullptr) {
    perror("malloc");
    exit(1);
  }
  auto p = newPtr;
  for (const auto s : sv) {
    memcpy(p, s.data(), s.size());
    p += s.size();
  }
  newPtr[sz] = 0; // Ensure null-termination
  return newPtr;
}

// $prefix/cmd/git
// $prefix/cmd/git-upload-pack
// $prefix/cmd/git-receive-pack
int main(int argc, const char *argv[]) {
  if (argc <= 0) {
    fprintf(stderr, "git-minimal launcher fatal: missing args\n");
    return 1;
  }
  auto self = resolve_executable();
  auto prefix = std::filesystem::path(self).parent_path().parent_path();
  auto command = search_command(prefix, argv[0]);
  if (!command) {
    auto filename = std::filesystem::path(argv[0]).filename().string();
    fprintf(stderr, "git-minimal launcher fatal: command '$prefix/bin/%s' not found\n", argv[0]);
    return 1;
  }
  if (std::filesystem::equivalent(self, *command)) {
    fprintf(stderr, "git-minimal launcher fatal: self equivalent command\n");
    return 1;
  }
  auto basename = std::filesystem::path(argv[0]).filename().string();
  auto execPath = prefix / "libexec" / "git-core";
  auto templatePath = prefix / "share" / "git-core" / "templates";

  std::vector<char *> newArgs;
  std::vector<char *> newEnviron;
  auto closer = bela::Final([&] {
    for (auto a : newArgs) {
      if (a != nullptr) {
        std::free(a);
      }
    }
    for (auto e : newEnviron) {
      if (e != nullptr) {
        std::free(e);
      }
    }
  });
  // build args
  newArgs.push_back(string_cat(basename));
  for (int i = 1; i < argc; i++) {
    newArgs.push_back(string_cat(argv[i]));
  }
  newArgs.push_back(nullptr);
  // build environ
  newEnviron.push_back(string_cat("GIT_EXEC_PATH=", execPath.string()));        // GIT_EXEC_PATH
  newEnviron.push_back(string_cat("GIT_TEMPLATE_DIR=", templatePath.string())); // GIT_TEMPLATE_DIR
  // https://en.cppreference.com/w/cpp/filesystem/path/formatter std::format
  // support std::filesystem::path starts C++26
  const char *rawPath = getenv("PATH");
  if (rawPath == nullptr) {
    rawPath = "/usr/local/bin:/usr/bin";
  }
  auto bindir = command->parent_path();
  newEnviron.push_back(string_cat("PATH=", bindir.string(), Separators, rawPath));
  // https://git-scm.com/docs/git-config GIT_SSL_CAINFO
  std::string caBundle;
  if (auto bundle = search_bundle(prefix); bundle) {
    newEnviron.push_back(string_cat("GIT_SSL_CAINFO=", *bundle));
  }
  for (auto p = environ; p != nullptr; p++) {
    auto e = *p;
    if (e == nullptr) {
      break;
    }
    std::string_view es(e);
    auto pos = es.find('=');
    if (pos == std::string_view::npos) {
      continue;
    }
    auto K = es.substr(0, pos);
    if (is_drop_env(K)) {
      continue;
    }
    newEnviron.push_back(string_cat(e));
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
