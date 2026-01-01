#!/usr/bin/env nu

let SOURCE_DIR = $env.FILE_PWD | path dirname

print $"script_path: ($SOURCE_DIR)"

def main [
    --target (-T): string = "x86_64-unknown-linux-gnu" # Compile git for the given target
    --prefix (-P): string = "/usr/local" # Install Prefix
    --static (-S) # Static link libc (always true for musl)
    --verbose (-V)
] {
    let BUILD_ARCH = if ($target | str starts-with "x86_64") {
        "amd64"
    } else if ($target | str starts-with "aarch64") {
        "arm64"
    } else {
        ""
    }
    let BUILD_MARCH = match $BUILD_ARCH {
        "amd64" => "-march=x86-64-v2"
        "arm64" => "-march=armv8-a"
        _       => ""
    }
    let STATIC_LDFALGS = if ($target | str ends-with "-musl") {
        "-lmimalloc -static"
    } else if ($static) {
        "-static"
    } else {
        ""
    }
    print -e $"BUILD_MARCH: ($BUILD_MARCH) STATIC_LDFALGS: ($STATIC_LDFALGS)"
    let BUILD_PACKAGE_NAME = if ($target | str ends-with "-musl") { 
        "git-minimal-musl"
    } else if ($static) { 
        "git-minimal-static"
    } else { 
        "git-minimal"
    }
    let BUILD_ARCH = if ($target | str starts-with "x86_64") {
        "amd64"
    } else if ($target | str starts-with "aarch64") {
        "arm64"
    } else {
        ""
    }
    let BUILD_VERSION = ($env | get GITHUB_REF? | default "v1.0") | str replace --regex '^refs/heads/' '' | str replace --all "/" "_"
    print -e $"create ($BUILD_PACKAGE_NAME)-($BUILD_VERSION)-linux-($BUILD_ARCH).tar.xz"
    mut stageIndex = 0
    $stageIndex += 1
    $stageIndex | do {
        print $"stage-($in)"
    }
    if ($STATIC_LDFALGS | is-not-empty) {
        print -e "BUILD tar.xz"
    }
    mut opensslOptions = [
        $"--prefix=($prefix)"
        "--libdir=lib" # debain: lib, redhat: lib64 openssl: lib64
        "no-filenames"
        "no-legacy"
        "no-autoload-config"
        "no-apps"
        "no-engine"
        "no-module"
        "no-dso"
        "no-shared"
        "no-srp"
        "no-nextprotoneg"
        "no-bf"
        "no-rc4"
        "no-cast"
        "no-idea"
        "no-cmac"
        "no-rc2"
        "no-mdc2"
        "no-whirlpool"
        "no-dsa"
        "no-tests" 
        "no-makedepend"
    ]
    if ($target | str starts-with "aarch64") {
        $opensslOptions = $opensslOptions | append "linux-aarch64"
    }
    print -e $"($opensslOptions)"
    let gitOptions = if ($target | str starts-with "aarch64") {
        [
            $"--prefix=($prefix)"
            $"--host=($target)" # run under aarch64
            "PTHREAD_LIBS=-pthread"
        ]
    } else {
        [
            $"--prefix=($prefix)"
            "PTHREAD_LIBS=-pthread"
        ]
    }
    print -e $"gitOptions: ($gitOptions)"
}