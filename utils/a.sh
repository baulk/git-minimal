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

echo "BUILD_TARGET: $BUILD_TARGET BUILD_STATIC: $BUILD_STATIC"