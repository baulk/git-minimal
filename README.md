# git-minimal

Git on Linux build script

## Flavor

|Package|Libc|Runnable System|
|---|---|---|
|`git-minimal`|glibc|Linux, x86_64, glibc >= 2.39|
|`git-minimal-static`|glibc (static link)|Linux, x86_64|
|`git-minimal-musl`|musl (static link)|Linux, x86_64/aarch64|

Static linking of glibc: Although static linking of glibc is generally discouraged, it may not have much impact here. git clone/push/fetch will still work normally. `cURL` uses `c-ares` as its asynchronous DNS implementation, which makes Git over HTTP(s) independent of libc's DNS behavior. Although the `git://` protocol does not have much platform support, it has been verified to be accessible.