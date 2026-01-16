#!/usr/bin/env nu

const MIMALLOC_VERSION = "2.2.7"
const MIMALLOC_HASH = "8e0ed89907a681276bff2e49e9a048b47ba51254ab60daf6b3c220acac456a95"

const ZLIBNG_VERSION = "2.3.2"
const ZLIBNG_HASH = "6a0561b50b8f5f6434a6a9e667a67026f2b2064a1ffa959c6b2dae320161c2a8"

const BROTLI_VERSION = "1.2.0"
const BROTLI_HASH = "816c96e8e8f193b40151dad7e8ff37b1221d019dbcb9c35cd3fadbfe6477dfec"

const ZSTD_VERSION = "1.5.7"
const ZSTD_HASH = "eb33e51f49a15e023950cd7825ca74a4a2b43db8354825ac24fc1b7ee09e6fa3"

const AWSLC_VERSION = "1.66.1"
const AWSLC_HASH = "44436ec404511e822c039acd903d4932e07d2a0a94a4f0cea4c545859fa2d922"

const LIBRESSL_VERSION = "4.2.1"
const LIBRESSL_HASH = "6d5c2f58583588ea791f4c8645004071d00dfa554a5bf788a006ca1eb5abd70b"

const OPENSSL_VERSION = "3.6.0"
const OPENSSL_HASH = "b6a5f44b7eb69e3fa35dbf15524405b44837a481d43d81daddde3ff21fcbb8e9"

const CARES_VERSION = "1.34.6"
const CARES_HASH = "912dd7cc3b3e8a79c52fd7fb9c0f4ecf0aaa73e45efda880266a2d6e26b84ef5"

# nghttp3-${NGHTTP3_VERSION}.tar.xz
const NGHTTP3_VERSION = "1.14.0"
const NGHTTP3_HASH = "b3083dae2ff30cf00d24d5fedd432479532c7b17d993d384103527b36c1ec82d"

# nghttp2-${NGHTTP2_VERSION}.tar.xz
const NGHTTP2_VERSION = "1.68.0"
const NGHTTP2_HASH = "5511d3128850e01b5b26ec92bf39df15381c767a63441438b25ad6235def902c"

# ngtcp2-${NGTCP2_VERSION}.tar.xz
const NGTCP2_VERSION = "1.19.0"
const NGTCP2_HASH = "f11f7da5065f2298f8b5f079a11f1a6f72389271b8dedd893c8eb26aba94bce9"

# curl-${CURL_VERSION}.tar.xz
const CURL_VERSION = "8.18.0"
const CURL_HASH = "40df79166e74aa20149365e11ee4c798a46ad57c34e4f68fd13100e2c9a91946"

# https://github.com/PCRE2Project/pcre2/releases/download/pcre2-10.47/pcre2-10.47.tar.gz
const PCRE2_VERSION = "10.47"
const PCRE2_HASH = "c08ae2388ef333e8403e670ad70c0a11f1eed021fd88308d7e02f596fcd9dc16"

# https://github.com/libexpat/libexpat/releases/download/R_2_7_3/expat-2.7.3.tar.xz
const EXPAT_VERSION = "2.7.3"
const EXPAT_HASH = "71df8f40706a7bb0a80a5367079ea75d91da4f8c65c58ec59bcdfbf7decdab9f"

# https://www.kernel.org/pub/software/scm/git/git-2.52.0.tar.gz
const GIT_VERSION = "2.52.0"
const GIT_HASH = "6880cb1e737e26f81cf7db9957ab2b5bb2aa1490d87619480b860816e0c10c32"

let MIMALLOC_URL = $"https://github.com/microsoft/mimalloc/archive/refs/tags/v($MIMALLOC_VERSION).tar.gz"
let MIMALLOC_DIRNAME = $"mimalloc-($MIMALLOC_VERSION)"

let ZLIBNG_URL = $"https://github.com/zlib-ng/zlib-ng/archive/refs/tags/($ZLIBNG_VERSION).tar.gz"
let ZLIBNG_DIRNAME = $"zlib-ng-($ZLIBNG_VERSION)"

let BROTLI_URL = $"https://github.com/google/brotli/archive/v($BROTLI_VERSION).tar.gz"
let BROTLI_DIRNAME = $"brotli-($BROTLI_VERSION)"

let ZSTD_URL = $"https://github.com/facebook/zstd/releases/download/v($ZSTD_VERSION)/zstd-($ZSTD_VERSION).tar.gz"
let ZSTD_DIRNAME = $"zstd-($ZSTD_VERSION)"

# https://github.com/aws/aws-lc/archive/refs/tags/v1.66.2.tar.gz
let AWSLC_URL = $"https://github.com/aws/aws-lc/archive/refs/tags/v($AWSLC_VERSION).tar.gz"
let AWSLC_DIRNAME = $"aws-lc-($AWSLC_VERSION)"

# https://github.com/libressl/portable/releases/download/v4.2.1/libressl-4.2.1.tar.gz
let LIBRESSL_URL = $"https://github.com/libressl/portable/releases/download/v($LIBRESSL_VERSION)/libressl-($LIBRESSL_VERSION).tar.gz"
let LIBRESSL_DIRNAME = $"libressl-($LIBRESSL_VERSION)"

let OPENSSL_URL = $"https://github.com/openssl/openssl/releases/download/openssl-($OPENSSL_VERSION)/openssl-($OPENSSL_VERSION).tar.gz"
let OPENSSL_DIRNAME = $"openssl-($OPENSSL_VERSION)"

let CARES_URL = $"https://github.com/c-ares/c-ares/releases/download/v($CARES_VERSION)/c-ares-($CARES_VERSION).tar.gz"
let CARES_DIRNAME = $"c-ares-($CARES_VERSION)"

let NGHTTP3_URL = $"https://github.com/ngtcp2/nghttp3/releases/download/v($NGHTTP3_VERSION)/nghttp3-($NGHTTP3_VERSION).tar.xz"
let NGHTTP3_DIRNAME = $"nghttp3-($NGHTTP3_VERSION)"

let NGHTTP2_URL = $"https://github.com/nghttp2/nghttp2/releases/download/v($NGHTTP2_VERSION)/nghttp2-($NGHTTP2_VERSION).tar.xz"
let NGHTTP2_DIRNAME = $"nghttp2-($NGHTTP2_VERSION)"

let NGTCP2_URL = $"https://github.com/ngtcp2/ngtcp2/releases/download/v($NGTCP2_VERSION)/ngtcp2-($NGTCP2_VERSION).tar.xz"
let NGTCP2_DIRNAME = $"ngtcp2-($NGTCP2_VERSION)"

let PCRE2_URL = $"https://github.com/PCRE2Project/pcre2/releases/download/pcre2-($PCRE2_VERSION)/pcre2-($PCRE2_VERSION).tar.gz"
let PCRE2_DIRNAME = $"pcre2-($PCRE2_VERSION)"

let EXPAT_DIR_VERSION = $EXPAT_VERSION | str replace --all "." "_"
# https://github.com/libexpat/libexpat/releases/download/R_2_7_3/expat-2.7.3.tar.xz
let EXPAT_URL = $"https://github.com/libexpat/libexpat/releases/download/R_($EXPAT_DIR_VERSION)/expat-($EXPAT_VERSION).tar.xz"
let EXPAT_DIRNAME = $"expat-($EXPAT_VERSION)"

let CURL_URL = $"https://curl.haxx.se/download/curl-($CURL_VERSION).tar.xz"
let CURL_DIRNAME = $"curl-($CURL_VERSION)"

# curl-ca-bundle
let CA_BUNDLE_URL = "https://curl.se/ca/cacert.pem"

let GIT_URL = $"https://www.kernel.org/pub/software/scm/git/git-($GIT_VERSION).tar.gz"
let GIT_DIRNAME = $"git-($GIT_VERSION)"

def Exec [
    --cmd: string,
    --args: list<string> = [],
    --wd: path,
    --ignore-stdout
] {
    let cwd = if ( $wd | is-empty) { $env.PWD } else { $wd }
    print $"($cmd) ($args) cwd: ($cwd)"
    if $ignore_stdout {
        do {
            cd $cwd
            ^$cmd ...$args o> /dev/null
        }
        return $env.LAST_EXIT_CODE
    }
    do {
        cd $cwd
        ^$cmd ...$args
    }
    return $env.LAST_EXIT_CODE
}

# https://www.nushell.sh/commands/categories/filters.html
def WebGet [
    --url (-u): string
    --out (-o): path
    --hash (-H): string
] {
    let basename = $out | path basename
    if ($out | path exists) and ($hash | is-not-empty) {
        let actual = (open $out | hash sha256)
        if $actual == $hash {
            print -e $"found '($basename)' \(skip download)"
            return true
        }
        print -e $"file '($basename)' checksum mismatch expected ($hash) actual ($actual)"
        rm -f $out
    }
    # # see: https://github.com/nushell/nushell/pull/17092
    # try {
    #     http get $url | save --progress $out
    # } catch { |err|
    #     print -e $"WebGet error: ($err.msg)"
    #     rm -f $out
    #     return false
    # }
    ^curl -fsS --connect-timeout 15 --retry 3 -o $out -L $url
    if $env.LAST_EXIT_CODE != 0 {
        rm -f $out
        return false
    }
    if ($hash | is-empty) {
        return true
    }
    let actual = (open $out | hash sha256)
    if $actual == $hash {
        return true
    }

    print -e $"file\(download) '($basename)' checksum mismatch expected ($hash) actual ($actual)"
    return false
}

def WebUnarchive [
    --url (-u): string
    --out (-o): path
    --hash (-H): string
] {
    if not (WebGet -u $url -o $out -H $hash) {
        return false
    }
    print -e $"cmake -E tar -xf ($out)"
    ^cmake -E tar -xf $out
    if $env.LAST_EXIT_CODE != 0 {
        return false
    }
    return true
}

def RunCMake [
    --options: list<string> = []
    --wd: path
    --strip
] {
    try { 
        mkdir $wd
    } catch { |err|
        print -e $"mkdir error: ($err.msg)"
        return false
    }
    if (Exec --cmd "cmake" --args $options --wd $wd) != 0 {
        return false
    }
    if (Exec --cmd "cmake" --args ["--build","."] --wd $wd) != 0 {
        return false
    }
    if $strip {
        if (Exec --cmd "cmake" --args ["--install",".","--strip"] --wd $wd) != 0 {
            return false
        }
        return true
    }
    if (Exec --cmd "cmake" --args ["--install","."] --wd $wd) != 0 {
        return false
    }
    return true
}

def main [
    --target (-T): string = "x86_64-unknown-linux-gnu" # Compile git for the given target
    --prefix (-P): string = "/usr/local" # Install Prefix
    --static (-S) # Static link libc (always true for musl)
] {
    let Core = (sys cpu | length)
    let Brand = (sys cpu).0.brand
    print -e $"CPU: ($Brand) [($Core) cores]"

    let SOURCE_DIR = $env.FILE_PWD
    let DESTDIR = $SOURCE_DIR | path join "_out"
    let QUARANTINE_DIR = $SOURCE_DIR | path join "_quarantine"
    let QUARANTINE_PREFIX = $SOURCE_DIR | path join "_quarantine/prefix"
    let CA_BUNDLE = $"($DESTDIR)($prefix)/share/git-minimal/curl-ca-bundle.crt"
    try {
        let CA_BUNDLE_DIRNAME = $CA_BUNDLE | path dirname
        mkdir $CA_BUNDLE_DIRNAME
        mkdir $QUARANTINE_DIR
        cd $QUARANTINE_DIR
    } catch {|err|
        print -e $"mkdir error: ($err.msg)"
        exit 1
    }
    let BUILD_ARCH = if ($target | str starts-with "x86_64") {
        "amd64"
    } else if ($target | str starts-with "aarch64") {
        "arm64"
    } else if ($target | str starts-with "loongarch64") {
        "loongarch64"
    } else {
        ""
    }
    # https://github.com/loongson/la-toolchain-conventions
    # https://gcc.gnu.org/onlinedocs/gcc-15.2.0/gcc/LoongArch-Options.html
    let BUILD_MARCH = match $BUILD_ARCH {
        "amd64"       => "-march=x86-64-v2"
        "arm64"       => "-march=armv8.2-a" # ARMv8.2‑A --> 2015
        "loongarch64" => "-march=la664" # ONLY 3A6000 or later
        _             => "" # default: please configure the new architecture correctly.
    }
    let STATIC_LDFALGS = if ($target | str ends-with "-musl") {
        "-lmimalloc -static"
    } else if ($static) {
        "-static"
    } else {
        ""
    }
    print -e $"BUILD_MARCH: ($BUILD_MARCH) STATIC_LDFALGS: ($STATIC_LDFALGS)"
    # GCC support -flto=auto but clang not
    let ENV_CC = ($env | get CC? | default "")
    let LTO_FLAGS = if ($ENV_CC | str contains "gcc") { "-flto=auto" } else { "-flto" }
    let LTO_CFLAGS = $"-O2 -pipe ($BUILD_MARCH) ($LTO_FLAGS) -I($QUARANTINE_PREFIX)/include"
    let LTO_CXXFLAGS = $"-O2 -pipe ($BUILD_MARCH) ($LTO_FLAGS) -I($QUARANTINE_PREFIX)/include"
    let LTO_LDFLAGS = $"-O2 ($LTO_FLAGS) -fuse-ld=mold -Wl,-O2,--as-needed,--gc-sections -L($QUARANTINE_PREFIX)/lib"
    mut stageIndex = 0
    print $"stage-($stageIndex): download and unarchive source codes"
    $stageIndex += 1
    if ($target | str ends-with "-musl") {
        if not (WebUnarchive -u $MIMALLOC_URL -o $"($MIMALLOC_DIRNAME).tar.gz" -H $MIMALLOC_HASH) {
            exit 1
        }
    }
    # zlib-ng
    if not (WebUnarchive -u $ZLIBNG_URL -o $"($ZLIBNG_DIRNAME).tar.gz" -H $ZLIBNG_HASH) {
        exit 1
    }
    # brotli
    if not (WebUnarchive -u $BROTLI_URL -o $"($BROTLI_DIRNAME).tar.gz" -H $BROTLI_HASH) {
        exit 1
    }
    # zstd
    if not (WebUnarchive -u $ZSTD_URL -o $"($ZSTD_DIRNAME).tar.gz" -H $ZSTD_HASH) {
        exit 1
    }
    # openssl
    if not (WebUnarchive -u $OPENSSL_URL -o $"($OPENSSL_DIRNAME).tar.gz" -H $OPENSSL_HASH) {
        exit 1
    }
    # c-ares
    if not (WebUnarchive -u $CARES_URL -o $"($CARES_DIRNAME).tar.gz" -H $CARES_HASH) {
        exit 1
    }
    # nghttp3
    if not (WebUnarchive -u $NGHTTP3_URL -o $"($NGHTTP3_DIRNAME).tar.xz" -H $NGHTTP3_HASH) {
        exit 1
    }
    # nghttp2
    if not (WebUnarchive -u $NGHTTP2_URL -o $"($NGHTTP2_DIRNAME).tar.xz" -H $NGHTTP2_HASH) {
        exit 1
    }
    # pcre2
    if not (WebUnarchive -u $PCRE2_URL -o $"($PCRE2_DIRNAME).tar.gz" -H $PCRE2_HASH) {
        exit 1
    }
    # expat
    if not (WebUnarchive -u $EXPAT_URL -o $"($EXPAT_DIRNAME).tar.xz" -H $EXPAT_HASH) {
        exit 1
    }
    # curl
    if not (WebUnarchive -u $CURL_URL -o $"($CURL_DIRNAME).tar.gz" -H $CURL_HASH) {
        exit 1
    }
    # ca-bundle
    if not (WebGet -u $CA_BUNDLE_URL -o $CA_BUNDLE) {
        exit 1
    }
    # git
    if not (WebUnarchive -u $GIT_URL -o $"($GIT_DIRNAME).tar.gz" -H $GIT_HASH) {
        exit 1
    }
    if ($target | str ends-with "-musl") {
        print $"stage-($stageIndex): build mimalloc ($MIMALLOC_VERSION)"
        $stageIndex += 1
        let mimalloOptions = [
            "-G" "Unix Makefiles"
            "-DCMAKE_BUILD_TYPE=Release"
            "-DMI_BUILD_SHARED=OFF"
            "-DMI_BUILD_STATIC=ON"
            "-DMI_BUILD_TESTS=OFF"
            "-DMI_INSTALL_TOPLEVEL=ON"
            "-DCMAKE_POSITION_INDEPENDENT_CODE=ON"
            $"-DCMAKE_INSTALL_PREFIX=($QUARANTINE_PREFIX)"
            $"-DCMAKE_PREFIX_PATH=($QUARANTINE_PREFIX)"
            $"-DCMAKE_C_FLAGS=($LTO_CFLAGS)"
            $"-DCMAKE_CXX_FLAGS=($LTO_CXXFLAGS)"
            $"-DCMAKE_EXE_LINKER_FLAGS=($LTO_LDFLAGS)"
            $"-DCMAKE_SHARED_LINKER_FLAGS=($LTO_LDFLAGS)"
            ".."
        ]

        if not (RunCMake --options $mimalloOptions --wd $"($QUARANTINE_DIR)/($MIMALLOC_DIRNAME)/out") {
            exit 1
        }
    }
    print $"stage-($stageIndex): build zlib-ng ($ZLIBNG_VERSION)"
    $stageIndex += 1
    let zlibngOptions = [
        "-G" "Unix Makefiles"
        "-DCMAKE_BUILD_TYPE=Release"
        "-DBUILD_SHARED_LIBS=OFF"
        "-DBUILD_TESTING=OFF"
        "-DZLIB_COMPAT=ON"
        "-DWITH_GTEST=OFF"
        "-DCMAKE_POSITION_INDEPENDENT_CODE=ON"
        $"-DCMAKE_INSTALL_PREFIX=($QUARANTINE_PREFIX)"
        $"-DCMAKE_PREFIX_PATH=($QUARANTINE_PREFIX)"
        $"-DCMAKE_C_FLAGS=($LTO_CFLAGS)"
        $"-DCMAKE_CXX_FLAGS=($LTO_CXXFLAGS)"
        $"-DCMAKE_EXE_LINKER_FLAGS=($LTO_LDFLAGS)"
        $"-DCMAKE_SHARED_LINKER_FLAGS=($LTO_LDFLAGS)"
        ".."
    ]

    if not (RunCMake --options $zlibngOptions --wd $"($QUARANTINE_DIR)/($ZLIBNG_DIRNAME)/out") {
        exit 1
    }

    print $"stage-($stageIndex): build brotli ($BROTLI_VERSION)"
    $stageIndex += 1
    let brotliOptions = [
        "-G" "Unix Makefiles"
        "-DCMAKE_BUILD_TYPE=Release"
        "-DBUILD_SHARED_LIBS=OFF"
        "-DBROTLI_BUILD_TOOLS=OFF"
        "-DBROTLI_DISABLE_TESTS=ON"
        "-DCMAKE_POSITION_INDEPENDENT_CODE=ON"
        $"-DCMAKE_INSTALL_PREFIX=($QUARANTINE_PREFIX)"
        $"-DCMAKE_PREFIX_PATH=($QUARANTINE_PREFIX)"
        $"-DCMAKE_C_FLAGS=($LTO_CFLAGS)"
        $"-DCMAKE_CXX_FLAGS=($LTO_CXXFLAGS)"
        $"-DCMAKE_EXE_LINKER_FLAGS=($LTO_LDFLAGS)"
        $"-DCMAKE_SHARED_LINKER_FLAGS=($LTO_LDFLAGS)"
        ".."
    ]
    
    # TODO: Remove this patch after brotli releases a new version.
    # https://github.com/google/brotli/commit/e230f474b87134e8c6c85b630084c612057f253e
    Exec --cmd "patch" --args ["-Nbp1","-i",$"($SOURCE_DIR)/patch/brotli-1.2.0.patch"] --wd $"($QUARANTINE_DIR)/($BROTLI_DIRNAME)"|ignore
    if not (RunCMake --options $brotliOptions --wd $"($QUARANTINE_DIR)/($BROTLI_DIRNAME)/out") {
        exit 1
    }

    print $"stage-($stageIndex): build zstd ($ZSTD_VERSION)"
    $stageIndex += 1
    let zstdOptions = [
        "-G" "Unix Makefiles"
        "-DCMAKE_BUILD_TYPE=Release"
        "-DZSTD_BUILD_STATIC=ON"
        "-DZSTD_BUILD_SHARED=OFF"
        "-DZSTD_LEGACY_SUPPORT=OFF"
        "-DZSTD_BUILD_PROGRAMS=OFF"
        "-DBUILD_TESTING=OFF"
        "-DCMAKE_POSITION_INDEPENDENT_CODE=ON"
        $"-DCMAKE_INSTALL_PREFIX=($QUARANTINE_PREFIX)"
        $"-DCMAKE_PREFIX_PATH=($QUARANTINE_PREFIX)"
        $"-DCMAKE_C_FLAGS=($LTO_CFLAGS)"
        $"-DCMAKE_CXX_FLAGS=($LTO_CXXFLAGS)"
        $"-DCMAKE_EXE_LINKER_FLAGS=($LTO_LDFLAGS)"
        $"-DCMAKE_SHARED_LINKER_FLAGS=($LTO_LDFLAGS)"
        ".."
    ]

    if not (RunCMake --options $zstdOptions --wd $"($QUARANTINE_DIR)/($ZSTD_DIRNAME)/build/cmake/out") {
        exit 1
    }

    # openssl
    $stageIndex | do {
        print $"stage-($in): build openssl ($OPENSSL_VERSION)"
        
        $env.CFLAGS = $LTO_CFLAGS
        $env.CXXFLAGS = $LTO_CXXFLAGS
        $env.LDFLASG = $LTO_LDFLAGS
        mut opensslOptions = [
            $"--prefix=($QUARANTINE_PREFIX)"
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
        } else if ($target | str starts-with "loongarch64") {
            # loongarch64-unknown-linux-musl
            $opensslOptions = $opensslOptions | append "linux64-loongarch64"
        }
        # make/make install
        let OPENSSL_SOURCE_DIR =  $"($QUARANTINE_DIR)/($OPENSSL_DIRNAME)"
        let opensslScript = $"($OPENSSL_SOURCE_DIR)/config"
        if (Exec --cmd $opensslScript --args $opensslOptions --wd $OPENSSL_SOURCE_DIR) != 0 {
            exit 1
        }
        if (Exec --cmd "make" --args [$"-j($Core)","install_sw"] --wd $OPENSSL_SOURCE_DIR --ignore-stdout) != 0 {
            exit 1
        }
    }
    $stageIndex += 1

    print $"stage-($stageIndex): build c-ares ($CARES_VERSION)"
    $stageIndex += 1
    let caresOptions = [
        "-G" "Unix Makefiles"
        "-DCMAKE_BUILD_TYPE=Release"
        "-DCARES_SYMBOL_HIDING=ON"
        "-DCARES_STATIC=ON"
        "-DCARES_STATIC_PIC=ON"
        "-DCARES_SHARED=OFF"
        "-DCARES_BUILD_TESTS=OFF"
        "-DCARES_BUILD_CONTAINER_TESTS=OFF"
        "-DCARES_BUILD_TOOLS=OFF"
        "-DCMAKE_POSITION_INDEPENDENT_CODE=ON"
        $"-DCMAKE_INSTALL_PREFIX=($QUARANTINE_PREFIX)"
        $"-DCMAKE_PREFIX_PATH=($QUARANTINE_PREFIX)"
        $"-DCMAKE_C_FLAGS=($LTO_CFLAGS)"
        $"-DCMAKE_CXX_FLAGS=($LTO_CXXFLAGS)"
        $"-DCMAKE_EXE_LINKER_FLAGS=($LTO_LDFLAGS)"
        $"-DCMAKE_SHARED_LINKER_FLAGS=($LTO_LDFLAGS)"
        ".."
    ]

    if not (RunCMake --options $caresOptions --wd $"($QUARANTINE_DIR)/($CARES_DIRNAME)/out") {
        exit 1
    }

    print $"stage-($stageIndex): build nghttp3 ($NGHTTP3_VERSION)"
    $stageIndex += 1
    let nghttp3Options = [
        "-G" "Unix Makefiles"
        "-DCMAKE_BUILD_TYPE=Release"
        "-DENABLE_LIB_ONLY=ON"
        "-DENABLE_STATIC_LIB=ON"
        "-DENABLE_SHARED_LIB=OFF"
        "-DBUILD_TESTING=OFF"
        "-DCMAKE_POSITION_INDEPENDENT_CODE=ON"
        $"-DCMAKE_INSTALL_PREFIX=($QUARANTINE_PREFIX)"
        $"-DCMAKE_PREFIX_PATH=($QUARANTINE_PREFIX)"
        $"-DCMAKE_C_FLAGS=($LTO_CFLAGS)"
        $"-DCMAKE_CXX_FLAGS=($LTO_CXXFLAGS)"
        $"-DCMAKE_EXE_LINKER_FLAGS=($LTO_LDFLAGS)"
        $"-DCMAKE_SHARED_LINKER_FLAGS=($LTO_LDFLAGS)"
        ".."
    ]

    if not (RunCMake --options $nghttp3Options --wd $"($QUARANTINE_DIR)/($NGHTTP3_DIRNAME)/out") {
        exit 1
    }

    print $"stage-($stageIndex): build nghttp2 ($NGHTTP2_VERSION)"
    $stageIndex += 1
    let nghttp2Options = [
        "-G" "Unix Makefiles"
        "-DCMAKE_BUILD_TYPE=Release"
        "-DENABLE_LIB_ONLY=ON"
        "-DBUILD_SHARED_LIBS=OFF"
        "-DBUILD_STATIC_LIBS=ON"
        "-DBUILD_TESTING=OFF"
        "-DENABLE_DOC=OFF"
        "-DCMAKE_POSITION_INDEPENDENT_CODE=ON"
        $"-DCMAKE_INSTALL_PREFIX=($QUARANTINE_PREFIX)"
        $"-DCMAKE_PREFIX_PATH=($QUARANTINE_PREFIX)"
        $"-DCMAKE_C_FLAGS=($LTO_CFLAGS)"
        $"-DCMAKE_CXX_FLAGS=($LTO_CXXFLAGS)"
        $"-DCMAKE_EXE_LINKER_FLAGS=($LTO_LDFLAGS)"
        $"-DCMAKE_SHARED_LINKER_FLAGS=($LTO_LDFLAGS)"
        ".."
    ]

    if not (RunCMake --options $nghttp2Options --wd $"($QUARANTINE_DIR)/($NGHTTP2_DIRNAME)/out") {
        exit 1
    }

    print $"stage-($stageIndex): build pcre2 ($PCRE2_VERSION)"
    $stageIndex += 1
    let pcre2Options = [
        "-G" "Unix Makefiles"
        "-DCMAKE_BUILD_TYPE=Release"
        "-DBUILD_SHARED_LIBS=OFF"
        "-DBUILD_STATIC_LIBS=ON"
        "-DPCRE2_STATIC_PIC=ON"
        "-DPCRE2_BUILD_PCRE2GREP=OFF"
        "-DPCRE2_BUILD_TESTS=OFF"
        "-DCMAKE_POSITION_INDEPENDENT_CODE=ON"
        $"-DCMAKE_INSTALL_PREFIX=($QUARANTINE_PREFIX)"
        $"-DCMAKE_PREFIX_PATH=($QUARANTINE_PREFIX)"
        $"-DCMAKE_C_FLAGS=($LTO_CFLAGS)"
        $"-DCMAKE_CXX_FLAGS=($LTO_CXXFLAGS)"
        $"-DCMAKE_EXE_LINKER_FLAGS=($LTO_LDFLAGS)"
        $"-DCMAKE_SHARED_LINKER_FLAGS=($LTO_LDFLAGS)"
        ".."
    ]

    if not (RunCMake --options $pcre2Options --wd $"($QUARANTINE_DIR)/($PCRE2_DIRNAME)/out") {
        exit 1
    }

    print $"stage-($stageIndex): build expat ($EXPAT_VERSION)"
    $stageIndex += 1
    let expatOptions = [
        "-G" "Unix Makefiles"
        "-DCMAKE_BUILD_TYPE=Release"
        "-DBUILD_SHARED_LIBS=OFF"
        "-DBUILD_STATIC_LIBS=ON"
        "-DEXPAT_BUILD_TOOLS=OFF"
        "-DEXPAT_BUILD_EXAMPLES=OFF"
        "-DEXPAT_BUILD_TESTS=OFF"
        "-DCMAKE_POSITION_INDEPENDENT_CODE=ON"
        $"-DCMAKE_INSTALL_PREFIX=($QUARANTINE_PREFIX)"
        $"-DCMAKE_PREFIX_PATH=($QUARANTINE_PREFIX)"
        $"-DCMAKE_C_FLAGS=($LTO_CFLAGS)"
        $"-DCMAKE_CXX_FLAGS=($LTO_CXXFLAGS)"
        $"-DCMAKE_EXE_LINKER_FLAGS=($LTO_LDFLAGS)"
        $"-DCMAKE_SHARED_LINKER_FLAGS=($LTO_LDFLAGS)"
        ".."
    ]

    if not (RunCMake --options $expatOptions --wd $"($QUARANTINE_DIR)/($EXPAT_DIRNAME)/out") {
        exit 1
    }

    print $"stage-($stageIndex): build cURL ($CURL_VERSION)"
    $stageIndex += 1
    let curlOptions = [
        "-G" "Unix Makefiles"
        "-DCMAKE_BUILD_TYPE=Release"
        "-DBUILD_SHARED_LIBS=OFF"
        "-DBUILD_STATIC_LIBS=ON"
        "-DBUILD_STATIC_CURL=ON"
        "-DBUILD_LIBCURL_DOCS=OFF"
        "-DBUILD_MISC_DOCS=OFF"
        "-DBUILD_TESTING=OFF"
        "-DCURL_USE_LIBPSL=OFF"
        $"-DCURL_CA_EMBED=($CA_BUNDLE)"
        $"-DCURL_CA_BUNDLE=($prefix)/share/git-minimal/curl-ca-bundle.crt"
        "-DENABLE_ARES=ON"
        "-DCURL_BROTLI=ON"
        "-DCURL_ZSTD=ON"
        "-DCURL_DISABLE_LDAP=ON"
        "-DCURL_USE_OPENSSL=ON"
        "-DUSE_OPENSSL_QUIC=ON"
        "-DUSE_NGHTTP2=ON"
        "-DCMAKE_POSITION_INDEPENDENT_CODE=ON"
        $"-DCMAKE_INSTALL_PREFIX=($QUARANTINE_PREFIX)"
        $"-DCMAKE_PREFIX_PATH=($QUARANTINE_PREFIX)"
        $"-DCMAKE_C_FLAGS=($LTO_CFLAGS)"
        $"-DCMAKE_CXX_FLAGS=($LTO_CXXFLAGS)"
        $"-DCMAKE_EXE_LINKER_FLAGS=($LTO_LDFLAGS) ($STATIC_LDFALGS)"
        $"-DCMAKE_SHARED_LINKER_FLAGS=($LTO_LDFLAGS)"
        ".."
    ]

    if not (RunCMake --options $curlOptions --wd $"($QUARANTINE_DIR)/($CURL_DIRNAME)/out" --strip) {
        exit 1
    }

    print $"stage-($stageIndex): build Git ($GIT_VERSION)"
    $stageIndex += 1

    let GIT_SOURCE_DIR = $"($QUARANTINE_DIR)/($GIT_DIRNAME)"
    if (Exec --cmd "make" --args ["configure"] --wd $GIT_SOURCE_DIR) != 0 {
        exit 1
    }

    let CURL_LDFLAGS = ^$"($QUARANTINE_PREFIX)/bin/curl-config" "--libs"

    # We run under x86-64
    mut gitOptions = [
        $"--prefix=($prefix)"
        $"--with-openssl=($QUARANTINE_PREFIX)"
        $"--with-zlib=($QUARANTINE_PREFIX)"
        $"--with-expat=($QUARANTINE_PREFIX)"
        $"--with-curl=($QUARANTINE_PREFIX)"
        $"LIBS=($CURL_LDFLAGS)"
        "PTHREAD_LIBS=-pthread"
        $"CFLAGS=($LTO_CFLAGS)"
        $"LDFLAGS=($LTO_LDFLAGS) ($STATIC_LDFALGS)"
        "USE_LIBPCRE2=YesPlease"
    ]
    if not ($target | str starts-with $nu.os-info.arch) {
        # If git's configure is not handled properly, cross-compilation will fail, and the configure cache mechanism needs to be used to intercept it.
        # The following is the correct configuration for caching under musl libc (refer to alpine x86_64).
        let crossCompileCache = [
            "ac_cv_iconv_omits_bom='yes'"
            "ac_cv_fread_reads_directories='yes'"
            "ac_cv_snprintf_returns_bogus='no'"
        ]
        $crossCompileCache | str join (char newline) | save --append $"($GIT_SOURCE_DIR)/($target).cache"
        $gitOptions = $gitOptions | append [$"--host=($target)",$"--cache-file=($GIT_SOURCE_DIR)/($target).cache"] # FIXME: fix git check iconv check
    }

    let gitConfigure = $"($GIT_SOURCE_DIR)/configure"
    if (Exec --cmd $gitConfigure --args $gitOptions --wd $GIT_SOURCE_DIR) != 0 {
        exit 1
    }

    let additionalOptions = [
        "NO_TCLTK=YesPlease"
        "NO_GETTEXT=YesPlease"
        "NO_GITWEB=YesPlease"
        "NO_PREL=YesPlease"
        "NO_PYTHON=YesPlease"
        "NO_SVN_TESTS=YesPlease"
        $"CURL_LDFLAGS=($CURL_LDFLAGS)"
        "EXTLIBS += -lrt -lm -pthread"
        "undefine LINK_FUZZ_PROGRAMS"
        ""
    ]

    $additionalOptions | str join (char newline) | save --append $"($GIT_SOURCE_DIR)/config.mak.autogen"

    do {
        $env.DESTDIR = $DESTDIR
        # https://stackoverflow.com/questions/74329792/portable-way-to-strip-during-install-while-cross-compiling
        # TODO: It seems that the git Makefile does not recognize the STRIP environment variable, so we need to override strip.
        # We have already set up the strip in the upper-level script.
        # It seems that llvm-strip can be used in the future.
        if (Exec --cmd "make" --args ["INSTALL_SYMLINKS=1","INSTALL_STRIP=-s","install"] --wd $GIT_SOURCE_DIR) != 0 {
            exit 1
        }
        rm -f $"($DESTDIR)($prefix)/bin/git-cvsserver"
        rm -rf $"($DESTDIR)($prefix)/share/perl5" # remove perl tools
        cd $"($DESTDIR)($prefix)/libexec/git-core"
        rm -f ...[
            "git-am"
            "git-archimport"
            "git-cvsexportcommit"
            "git-cvsimport"
            "git-cvsserver"
            "git-format-patch"
            "git-imap-send"
            "git-instaweb"
            "git-mailinfo"
            "git-mailsplit"
            "git-p4"
            "git-quiltimport"
            "git-request-pull"
            "git-send-email"
            "git-svn"
        ]
    }
    cp -f $"($QUARANTINE_PREFIX)/bin/curl" $"($DESTDIR)($prefix)/bin/curl"
    let ARTIFACTS_OUTDIR = $"($SOURCE_DIR)/out"
    mkdir $ARTIFACTS_OUTDIR
    let BUILD_PACKAGE_NAME = if ($target | str ends-with "-musl") { 
        "git-minimal-musl"
    } else if ($static) { 
        "git-minimal-static"
    } else { 
        "git-minimal"
    }
    do {
        # SEE: https://wiki.debian.org/ArchitectureSpecificsMemo
        # OR: https://wiki.debian.org/Ports/loong64
        $env.BUILD_ARCH = if ($BUILD_ARCH == "loongarch64") { "loong64" } else { $BUILD_ARCH }
        if (Exec --cmd "nfpm" --args ["package","-f",$"($BUILD_PACKAGE_NAME).yml","-p","deb","-t",$ARTIFACTS_OUTDIR] --wd $SOURCE_DIR) != 0 {
            exit 1
        }
    }
    do {
        # TODO: https://github.com/goreleaser/nfpm/pull/1018
        $env.BUILD_ARCH = $BUILD_ARCH
        if (Exec --cmd "nfpm" --args ["package","-f",$"($BUILD_PACKAGE_NAME).yml","-p","rpm","-t",$ARTIFACTS_OUTDIR] --wd $SOURCE_DIR) != 0 {
            exit 1
        }
        if ($target | str ends-with "-musl") {
            if (Exec --cmd "nfpm" --args ["package","-f",$"($BUILD_PACKAGE_NAME).yml","-p","apk","-t",$ARTIFACTS_OUTDIR] --wd $SOURCE_DIR) != 0 {
                exit 1
            }
        }
    }
    if ($STATIC_LDFALGS | is-not-empty) {
        let BUILD_VERSION = ($env | get GITHUB_REF_NAME? | default "v1.0") | str replace --all "/" "_"
        let BUILD_ARCHIVE_PREFIX = $"($BUILD_PACKAGE_NAME)-($BUILD_VERSION)-linux-($BUILD_ARCH)"
        print -e $"create ($BUILD_ARCHIVE_PREFIX).tar.xz"
        mkdir $"($DESTDIR)($prefix)/cmd"
        let CXX = $env | get CXX? | default "g++"
        mut BUILD_CXXFLAGS = [
            "-std=c++23","-O2",
            "-flto",
            "-fuse-ld=mold",
            "-Wl,-O2,--as-needed,--gc-sections",
            "-static",
            $"($SOURCE_DIR)/cmd/git-minimal/main.cc",
            "-o",
            $"($DESTDIR)($prefix)/cmd/git-minimal"
        ]
        if ($BUILD_MARCH | is-not-empty) {
            $BUILD_CXXFLAGS = $BUILD_CXXFLAGS | append $BUILD_MARCH
        }
        if (Exec --cmd $CXX --args $BUILD_CXXFLAGS) == 0 {
            print -e "build git-minimal launcher success"
            Exec --cmd "ln" --args ["-sf","git-minimal",$"($DESTDIR)($prefix)/cmd/git"] | ignore
            Exec --cmd "ln" --args ["-sf","git-minimal",$"($DESTDIR)($prefix)/cmd/curl"] | ignore
            Exec --cmd "ln" --args ["-sf","git-minimal",$"($DESTDIR)($prefix)/cmd/git-receive-pack"] | ignore
            Exec --cmd "ln" --args ["-sf","git-minimal",$"($DESTDIR)($prefix)/cmd/git-shell"] | ignore
            Exec --cmd "ln" --args ["-sf","git-minimal",$"($DESTDIR)($prefix)/cmd/git-upload-archive"] | ignore
            Exec --cmd "ln" --args ["-sf","git-minimal",$"($DESTDIR)($prefix)/cmd/git-upload-pack"] | ignore
            Exec --cmd "ln" --args ["-sf","git-minimal",$"($DESTDIR)($prefix)/cmd/scalar"] | ignore
        }
        let DEST_NEWDIR = $"($DESTDIR)/($BUILD_ARCHIVE_PREFIX)"
        mv -f $"($DESTDIR)($prefix)" $DEST_NEWDIR
        # OR: cmake -E tar -cJvf file.tar.xz dir (not support -h)
        if (Exec --cmd "cmake" --args ["-E","tar","-cJvf", $"($SOURCE_DIR)/out/($BUILD_ARCHIVE_PREFIX).tar.xz",$BUILD_ARCHIVE_PREFIX] --wd $DESTDIR) != 0 {
            exit 1
        }
    }
    ls --du $ARTIFACTS_OUTDIR | print -e
}
