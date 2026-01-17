# git-minimal

Git on Linux 极简构建

## 风格

|包名|libc|可运行的系统|
|---|---|---|
|`git-minimal`|glibc|Linux，x86_64，glibc >= 2.39|
|`git-minimal-static`|glibc（静态链接）|Linux，x86_64（实验性的）|
|`git-minimal-musl`|musl（静态链接）|Linux，x86_64/aarch64/loongarch64|

## 常见问题

### 静态链接 glibc

静态链接 glibc 可能并没有多大的影响，`cURL` 使用 `c-ares` 作为异步 DNS 实现，这使得 Git Over HTTP(s) 不依赖 libc 的 DNS 行为，而 `git://` 经过验证也是可以访问的。

### RUNTIME_PREFIX

如果没有包管理器（直接下载 `tar.xz` 解压）安装 git-minimal-static/git-minimal-musl 到指定的 `prefix`（如 `/usr/local`）,你应该使用启动器 `cmd/git` 来运行 git 命令，该启动器会正确设置对应的环境变量以正确的配置路径。

```txt
# ls -l cmd
lrwxrwxrwx 1 root root      11 Jan  3 18:11 curl -> git-minimal
lrwxrwxrwx 1 root root      11 Jan  3 18:11 git -> git-minimal
-rwxr-xr-x 1 root root 7140696 Jan  3 18:11 git-minimal
lrwxrwxrwx 1 root root      11 Jan  3 18:11 git-receive-pack -> git-minimal
lrwxrwxrwx 1 root root      11 Jan  3 18:11 git-shell -> git-minimal
lrwxrwxrwx 1 root root      11 Jan  3 18:11 git-upload-archive -> git-minimal
lrwxrwxrwx 1 root root      11 Jan  3 18:11 git-upload-pack -> git-minimal
lrwxrwxrwx 1 root root      11 Jan  3 18:11 scalar -> git-minimal
```