#!/bin/bash

RUST_TOOLCHAIN_32='stable-i686-pc-windows-gnu'
RUST_TARGET_32='i686-pc-windows-gnu'

RUST_TOOLCHAIN_64='stable-x86_64-pc-windows-gnu'
RUST_TARGET_64='x86_64-pc-windows-gnu'

if [ ! -f "$(which apt-get)" ] && [ ! -f "$(which curl)" ];then
    echo 'Please install `curl`, `mingw` before run this script'
    exit
fi

if [ -f "$(which cargo)" ];then
    echo ' - rust already installed'
else
    echo ' - Installing rust'
    curl https://sh.rustup.rs -sSf|sh -s -- -y
    source $HOME/.cargo/env
fi

if [ "$(rustup toolchain list|grep "$RUST_TOOLCHAIN_32")" != '' ];then
    echo " - $RUST_TOOLCHAIN_32 already installed"
else
    echo " - Installing $RUST_TOOLCHAIN_32"
    rustup toolchain install "$RUST_TOOLCHAIN_32"
fi

if [ "$(rustup toolchain list|grep "$RUST_TOOLCHAIN_64")" != '' ];then
    echo " - $RUST_TOOLCHAIN_64 already installed"
else
    echo " - Installing $RUST_TOOLCHAIN_64"
    rustup toolchain install "$RUST_TOOLCHAIN_64"
fi

if [ "$(rustup target list|grep "$RUST_TARGET_32 (installed)")" != '' ];then
    echo " - $RUST_TARGET_32 already installed"
else
    echo " - Installing $RUST_TARGET_32"
    rustup target add "$RUST_TARGET_32"
fi

if [ "$(rustup target list|grep "$RUST_TARGET_64 (installed)")" != '' ];then
    echo " - $RUST_TARGET_64 already installed"
else
    echo " - Installing $RUST_TARGET_64"
    rustup target add "$RUST_TARGET_64"
fi

if [ ! -f "$(which apt-get)" ] && [ -f "$(which x86_64-w64-mingw32-ld)" ] || [ -f "$(which i686-w64-mingw32-ld)" ];then
    echo " - mingw already installed"
else
    echo " - Installing mingw"
    sudo apt-get install -y mingw-w64
fi

msg="$(cat <<'EOM'
/// # Usage
/// if you want to execute .exe, do following in shell.
/// ```
/// sudo dpkg --add-architecture i386
/// sudo apt-get update
/// sudo apt-get install -y wine32
/// ```
/// and then,
/// ```
/// wine TARGET_BINARY.exe
/// ```
EOM
)"
echo "$msg"

