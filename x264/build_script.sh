#!/usr/bin/env bash
#!/bin/bash
NDK=/opt/ndk
function build_with_arg()
{
GCC=$NDK/toolchains/$2-4.9/prebuilt/linux-x86_64/bin/$4-
echo "$GCC address is here"
echo  "configure --prefix=./libs/$3 --enable-static  --enable-pic  --host=$5  --cross-prefix=$GCC  --sysroot=$NDK/platforms/android-$1/arch-$3/"
./configure --prefix=./libs/$3 --enable-static  --enable-pic  --host=$5  --cross-prefix=$GCC  --sysroot=$NDK/platforms/android-$1/arch-$3/ $6
make clean
make 
make install 
echo Android $3 builds finished
}

build_with_arg  "18"  "arm-linux-androideabi"   "arm"     "arm-linux-androideabi"    "arm-linux"       ""; 
build_with_arg  "21"  "aarch64-linux-android"   "arm64"   "aarch64-linux-android"    "aarch64-linux"   "";  
build_with_arg  "18"  "mipsel-linux-android"    "mips"    "mipsel-linux-android"     "mipsel-linux"    "--disable-asm";   
build_with_arg  "21"  "mips64el-linux-android"  "mips64"  "mips64el-linux-android"   "mips64el-linux"  ""; 
build_with_arg  "18"  "x86"                     "x86"     "i686-linux-android"       "i686-linux"      "";    
build_with_arg  "21"  "x86_64"                  "x86_64"  "x86_64-linux-android"     "x86_64-linux"    "";
