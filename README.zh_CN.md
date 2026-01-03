# git-minimal

Git on Linux 极简构建

## 风格

|包名|libc|可运行的系统|
|---|---|---|
|`git-minimal`|glibc|Linux，x86_64，glibc >= 2.39|
|`git-minimal-static`|glibc（静态链接）|Linux，x86_64|
|`git-minimal-musl`|musl（静态链接）|Linux，x86_64/aarch64|

静态链接 glibc：尽管人们都不建议静态链接 glibc，但在这里我们静态链接 glibc 可能并没有多大的影响，git clone/push/fetch 都是正常的，`cURL` 使用 `c-ares` 作为异步 DNS 实现，这使得 Git Over HTTP(s) 不依赖 libc 的 DNS 行为，尽管 `git://` 协议并没有太多的平台支持，但经过验证也是可以访问的。