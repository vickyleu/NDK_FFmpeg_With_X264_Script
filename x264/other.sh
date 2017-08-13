#!/bin/sh 
NDK=/opt/ndk
PLATFORM=$NDK/platforms/android-9/arch-arm  
PREBUILT=$NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64  
CPU=armv7-a  
PREFIX=./libs/                                                                                                                                                     
ADDITIONAL_CONFIGURE_FLAG="-march=armv7-a -mtune=cortex-a8 -mfloat-abi=softfp -mfpu=vfp -D__ARM_ARCH_7__ -D__ARM_ARCH_7A__"  
  
./configure --host=arm-linux   --prefix=$PREFIX   --sysroot=$PLATFORM   --cross-prefix=$PREBUILT/bin/arm-linux-androideabi-     --enable-pic   --enable-strip  --enable-debug --enable-static  --extra-cflags=$ADDITIONAL_CONFIGURE_FLAG  
  
make uninstall  
make clean  
make -j8  
make install  