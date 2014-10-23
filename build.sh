#!/bin/sh

printenv NDK > /dev/null || { echo please export NDK=root_dir_of_your_android_ndk; exit 1; }


TOOL_CHAIN_DIR=`ls -d $NDK/toolchains/arm-linux-androideabi-4.*/prebuilt/* | tail -n 1` || exit 1
LIBGCC_DIR=`ls -d $TOOL_CHAIN_DIR/lib/gcc/arm-linux-androideabi/4.* | tail -n 1` || exit 1
LIBEXEC_DIR=`ls -d $TOOL_CHAIN_DIR/libexec/gcc/arm-linux-androideabi/4.* | tail -n 1` || exit 1
SYS_ROOT="$NDK/platforms/android-8/arch-arm"
CPP_ROOT=`ls -d $NDK/sources/cxx-stl/gnu-libstdc++/4.* | tail -n 1` || exit 1
MAKE_DIR=`ls -d $NDK/prebuilt/*/bin | tail -n 1` || exit 1
export  CFLAGS="-O3 --sysroot=$SYS_ROOT -I$SYS_ROOT/usr/include -I$LIBGCC_DIR/include -I$CPP_ROOT/include -lm"
export LDFLAGS="-B$SYS_ROOT/usr/lib -B$LIBGCC_DIR -B$TOOL_CHAIN_DIR/arm-linux-androideabi/bin -B$LIBEXEC_DIR -B$CPP_ROOT/libs/armeabi -lm"
export PATH="$TOOL_CHAIN_DIR/arm-linux-androideabi/bin:$LIBEXEC_DIR:$MAKE_DIR:$PATH"

echo ---------------make hack2048-image--------------------

gcc -x c -std=c99 $CFLAGS $LDFLAGS ./src/2048ai.cpp      -o ./bin/2048ai   -Xlinker -rpath=/system/lib || exit 1

g++ $CFLAGS $LDFLAGS ./src/fake_libgui.cpp                      -o libgui.so                          -fPIC -shared || exit 1
g++ $CFLAGS $LDFLAGS ./src/fake_libbinder.cpp                   -o libbinder.so                       -fPIC -shared || exit 1
g++ $CFLAGS $LDFLAGS ./src/2048ai.cpp -lsupc++ libgui.so libbinder.so -o ./bin/2048ai-jb -Xlinker -rpath=/system/lib -DTARGET_JB || exit 1
g++ $CFLAGS $LDFLAGS ./src/2048ai.cpp -lsupc++ libgui.so libbinder.so -o ./bin/2048ai-ics     -Xlinker -rpath=/system/lib -DTARGET_ICS || exit 1

rm libgui.so libbinder.so

echo ""; echo ok; echo ""
