#!/bin/bash -xe

[ -d core ] || git clone --depth 1 --branch release/3.7 https://github.com/OpenVPN/openvpn3.git core

export O3=`pwd`
export DEP_DIR=$O3/deps
export DL=$O3/dl

mkdir -pv ${DEP_DIR} ${DL}

patch -p1 -d core < ./core.patch

# builds for ios and osx + -dbg
# TARGET=osx 

swig -c++ -intgosize 64 -features autodoc=1 -v -go o3lib.i



for TARGET in android-a7a android-a8a android-x86 android-x86_64 linux-clang; do
    source core/vars/vars-${TARGET}
    ./core/scripts/linux/build-all
    # 2+ builds use cache
    export NO_WIPE=1
done

