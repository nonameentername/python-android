#!/usr/bin/env sh

export NDK="$HOME/source/android-ndk"

export ROOTDIR=`pwd`
export HOSTPYTHON=$ROOTDIR/hostpython
export HOSTPGEN=$ROOTDIR/hostpgen

export ANDROID_NDK=$NDK
export PATH="$ANDROID_NDK/toolchains/arm-linux-androideabi-4.4.3/prebuilt/linux-x86/bin/:$ANDROID_NDK:$ANDROID_NDK/tools:/usr/local/bin:/usr/bin:/bin"
export ARCH="armeabi"
export CFLAGS="-DANDROID -mandroid -fomit-frame-pointer --sysroot $ANDROID_NDK/platforms/android-5/arch-arm"
export CXXFLAGS="$CFLAGS"
export CC="arm-linux-androideabi-gcc $CFLAGS"
export CXX="arm-linux-androideabi-g++ $CXXFLAGS"
export AR="arm-linux-androideabi-ar"
export RANLIB="arm-linux-androideabi-ranlib"
export STRIP="arm-linux-androideabi-strip --strip-unneeded"

export PYTHONHOME="$ROOTDIR/build"

cd $ROOTDIR/Python
./configure LDFLAGS="-Wl,--allow-shlib-undefined" CFLAGS="-mandroid -fomit-frame-pointer --sysroot $ANDROID_NDK/platforms/android-5/arch-arm" HOSTPYTHON=$HOSTPYTHON HOSTPGEN=$HOSTPGEN --host=arm-eabi --build=i686-pc-linux-gnu --enable-shared --prefix="$ROOTDIR/build"

sed -i "s|^INSTSONAME=\(.*.so\).*|INSTSONAME=\\1|g" Makefile

#BLDSHARED="arm-linux-androideabi-gcc -shared" 
make -j4 HOSTPYTHON=$HOSTPYTHON HOSTPGEN=$HOSTPGEN CROSS_COMPILE=arm-eabi- CROSS_COMPILE_TARGET=yes
make install -j4 HOSTPYTHON=$HOSTPYTHON HOSTPGEN=$HOSTPGEN CROSS_COMPILE=arm-eabi- CROSS_COMPILE_TARGET=yes prefix=$ROOTDIR/build
