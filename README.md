# git-minimal

Git on Linux build script

## Flavor

|Package|Libc|Runnable System|
|---|---|---|
|`git-minimal`|glibc|Linux, x86_64, glibc >= 2.39|
|`git-minimal-static`|glibc (static link)|Linux, x86_64|
|`git-minimal-musl`|musl (static link)|Linux, x86_64/aarch64|

## Issues

### Static linking of glibc

Static linking to glibc may not have much impact. `cURL` uses `c-ares` as an asynchronous DNS implementation, which makes Git over HTTP(s) independent of libc's DNS behavior, and `git://` has been verified to be accessible.

### RUNTIME_PREFIX

If you don't have a package manager (just download the `tar.xz` file and extract it) to install git-minimal-static/git-minimal-musl to the specified `prefix` (such as `/usr/local`), you should use the launcher `cmd/git` to run the git command. This launcher will correctly set the corresponding environment variables to configure the correct paths.

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