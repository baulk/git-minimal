#!/usr/bin/env bash

while [[ "$#" -gt 0 ]]; do
	case "$1" in
	--target)
		if [[ -n "$2" && ! "$2" =~ ^-- ]]; then
			BUILD_TARGET="$2"
			shift 2
		else
			echo "fatal: --target need arg" >&2
			exit 1
		fi
		;;
	--static)
		if [[ -n "$2" && ! "$2" =~ ^-- ]]; then
			BUILD_STATIC="$2"
			shift 2
		else
			echo "fatal: --static need true/false" >&2
			exit 1
		fi
		;;
	*)
		echo "fatal: --target need arg" >&2
		exit 1
		;;
	esac
done

SCRIPT_ROOT=$(dirname "$0")
SOURCE_DIR=$(
	cd "${SCRIPT_ROOT}" || exit
	pwd
)

BUILD_TOOLS_DIR="$SOURCE_DIR/tools"
BUILD_TOOLS_TEMP="$BUILD_TOOLS_DIR/temp"
mkdir -p "$BUILD_TOOLS_TEMP" || exit
cd "$BUILD_TOOLS_TEMP" || exit
curl -o nfpm_2.44.1_Linux_x86_64.tar.gz -L https://github.com/goreleaser/nfpm/releases/download/v2.44.1/nfpm_2.44.1_Linux_x86_64.tar.gz || exit
tar -xvf nfpm_2.44.1_Linux_x86_64.tar.gz || exit
sudo mv -f nfpm /usr/local/bin || exit
cd "$SOURCE_DIR" || exit

MUSL_CROSS_VERSION="20250929"
MOLD_VERSION="2.40.4"
case $BUILD_TARGET in
x86_64-linux-musl)
	curl -o x86_64-unknown-linux-musl.tar.xz -L "https://github.com/cross-tools/musl-cross/releases/download/$MUSL_CROSS_VERSION/x86_64-unknown-linux-musl.tar.xz" || exit
	tar -xf x86_64-unknown-linux-musl.tar.xz || exit
	sudo mv x86_64-unknown-linux-musl "$BUILD_TOOLS_DIR" || exit
	export PATH="$BUILD_TOOLS_DIR/x86_64-unknown-linux-musl/bin:$PATH"
	export CC="x86_64-unknown-linux-musl-gcc"
	export CXX="x86_64-unknown-linux-musl-g++"
	export AR="x86_64-unknown-linux-musl-gcc-ar"
	export RANLIB="x86_64-unknown-linux-musl-gcc-ranlib"
	;;
aarch64-linux-musl)
	curl -o aarch64-unknown-linux-musl.tar.xz -L "https://github.com/cross-tools/musl-cross/releases/download/$MUSL_CROSS_VERSION/aarch64-unknown-linux-musl.tar.xz" || exit
	tar -xf aarch64-unknown-linux-musl.tar.xz || exit
	sudo mv aarch64-unknown-linux-musl "$BUILD_TOOLS_DIR" || exit
	# TODO: It seems that the git Makefile does not recognize the STRIP environment variable, so we need to override strip.
	sudo ln -sf aarch64-unknown-linux-musl-strip "$BUILD_TOOLS_DIR/aarch64-unknown-linux-musl/bin/strip"
	export PATH="$BUILD_TOOLS_DIR/aarch64-unknown-linux-musl/bin:$PATH"
	export CC="aarch64-unknown-linux-musl-gcc"
	export CXX="aarch64-unknown-linux-musl-g++"
	export AR="aarch64-unknown-linux-musl-gcc-ar"
	export RANLIB="aarch64-unknown-linux-musl-gcc-ranlib"
	;;
loongarch64-linux-musl)
	curl -o loongarch64-unknown-linux-musl.tar.xz -L "https://github.com/cross-tools/musl-cross/releases/download/$MUSL_CROSS_VERSION/loongarch64-unknown-linux-musl.tar.xz" || exit
	tar -xf loongarch64-unknown-linux-musl.tar.xz || exit
	sudo mv loongarch64-unknown-linux-musl "$BUILD_TOOLS_DIR" || exit
	sudo ln -sf loongarch64-unknown-linux-musl-strip "$BUILD_TOOLS_DIR/loongarch64-unknown-linux-musl/bin/strip"
	export PATH="$BUILD_TOOLS_DIR/loongarch64-unknown-linux-musl/bin:$PATH"
	export CC="loongarch64-unknown-linux-musl-gcc"
	export CXX="loongarch64-unknown-linux-musl-g++"
	export AR="loongarch64-unknown-linux-musl-gcc-ar"
	export RANLIB="loongarch64-unknown-linux-musl-gcc-ranlib"
	;;
*)
	wget -O- --timeout=10 --waitretry=3 --retry-connrefused --progress=dot:mega https://github.com/rui314/mold/releases/download/v${MOLD_VERSION}/mold-${MOLD_VERSION}-x86_64-linux.tar.gz | sudo tar -C /usr/local --strip-components=1 --no-overwrite-dir -xzf -
	export CC="gcc"
	export CXX="g++"
	export AR="gcc-ar"
	export RANLIB="gcc-ranlib"
	;;
esac
# https://github.com/cross-tools/musl-cross/releases/download/20250929/x86_64-unknown-linux-musl.tar.xz
# https://github.com/cross-tools/musl-cross/releases/download/20250929/aarch64-unknown-linux-musl.tar.xz
rm -rf "$BUILD_TOOLS_TEMP" || exit

BUILD_RELEASE="1"
if [ "$GITHUB_RUN_NUMBER" != "" ]; then
	BUILD_RELEASE="$GITHUB_RUN_NUMBER"
fi
export BUILD_RELEASE

if [ "$BUILD_STATIC" == "true" ]; then
	nu "$SOURCE_DIR/build.nu" --target "$BUILD_TARGET" --static
else
	nu "$SOURCE_DIR/build.nu" --target "$BUILD_TARGET"
fi
