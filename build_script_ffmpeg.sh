#!/usr/bin/env bash
#!/bin/bash
NDK=/opt/ndk


ARM_CFLAGS="-O3 -fpic -fasm -Wno-psabi -fno-short-enums -fno-strict-aliasing -finline-limit=300 -mfloat-abi=softfp -mfpu=vfp -marm -march=armv6 "
ARM_LD="-lx264 -Wl,-rpath-link=$PLATFORM/usr/lib -L$PLATFORM/usr/lib -nostdlib -lc -lm -ldl -llog "
ARM_EXTRA="--enable-neon"


ARMV7_CFLAGS="-DANDROID -fPIC -ffunction-sections -funwind-tables -fstack-protector -march=armv7-a -mfloat-abi=softfp -mfpu=vfpv3-d16 -fomit-frame-pointer -fstrict-aliasing -funswitch-loops -finline-limit=300"
ARMV7_LD="-Wl,-rpath-link=$PLATFORM/usr/lib -L$PLATFORM/usr/lib -nostdlib -lc -lm -ldl -llog"
ARMV7_EXTRA="--enable-neon"


ARM64_CFLAGS=""
ARM64_LD="-lx264 -Wl,-rpath-link=$PLATFORM/usr/lib -L$PLATFORM/usr/lib -nostdlib -lc -lm -ldl -llog"
ARM64_EXTRA=""

MIPS_CFLAGS=""
MIPS_LD="-lx264 -Wl,-rpath-link=$PLATFORM/usr/lib -L$PLATFORM/usr/lib -nostdlib -lc -lm -ldl -llog"
MIPS_EXTRA=""


MIPS64_CFLAGS=""
MIPS64_LD="-lx264 -Wl,-rpath-link=$PLATFORM/usr/lib -L$PLATFORM/usr/lib -nostdlib -lc -lm -ldl -llog"
MIPS64_EXTRA=""


X86_CFLAGS="-O3 -DANDROID -Dipv6mr_interface=ipv6mr_ifindex -fasm -Wno-psabi -fno-short-enums -fno-strict-aliasing -fomit-frame-pointer -march=k8 -march=i686 -mtune=intel -mssse3 -mfpmath=sse -m32"
X86_LD="-lx264 -Wl,-rpath-link=$PLATFORM/usr/lib -L$PLATFORM/usr/lib -nostdlib -lc -lm -ldl -llog"
X86_EXTRA=""


X86_64_CFLAGS="-march=x86-64 -msse4.2 -mpopcnt -m64 -mtune=intel"
X86_64_LD="-lx264 -Wl,-rpath-link=$PLATFORM/usr/lib64 -L$PLATFORM/usr/lib64 -nostdlib -lc -lm -ldl -llog"
X86_64_EXTRA=""



function build_with_arg()
{

ATTEMPT=""
if [ "$9" = "CLANG" ]; then  ###################################################compile with Clang#############################################
CC=$NDK/toolchains/llvm/prebuilt/linux-x86_64/bin/clang
CROSS=$NDK/toolchains/llvm/prebuilt/linux-x86_64/bin/clang
PLATFORM=$NDK/platforms/android-$1/arch-$3/
PREBUILT=$NDK/toolchains/$2-4.9/prebuilt/linux-x86_64/bin/$4-nm
ATTEMPT="-target ${10}"
elif [ "$9" = "GCC" ]; then                        ####################################################compile with GCC##############################################
CC=$NDK/toolchains/$2-4.9/prebuilt/linux-x86_64/bin/$4-
CROSS=$NDK/toolchains/$2-4.9/prebuilt/linux-x86_64/bin/$4-gcc
PLATFORM=$NDK/platforms/android-$1/arch-$3/
PREBUILT=$NDK/toolchains/$2-4.9/prebuilt/linux-x86_64/bin/$4-nm
ATTEMPT="-arch arm"
else
 echo "$8 platform doesn't support this compiler toolchian!!!!"  
 exit -1; 
fi                          #############################################################################################################




./configure --logfile=conflog.txt --target-os=linux --prefix=./libs/${8} --arch=$3 --enable-small --enable-cross-compile --extra-libs="-lgcc" --cc=$CROSS  --cross-prefix=$CC --nm=$PREBUILT --extra-cflags="-I../x264/libs/$3/include" --extra-cflags="${5}"    --extra-ldflags="${6}"   ${7}  --extra-ldflags="-L../x264/libs/$3/lib" --sysroot=$PLATFORM --enable-shared --disable-static --enable-zlib --disable-doc --enable-gpl --enable-libx264 ${ATTEMPT}

  make clean
  make
  make install

echo Android $3 builds finished
}

#build_with_arg  "18"  "arm-linux-androideabi"   "arm"     "arm-linux-androideabi"    "$ARM_CFLAGS"      "$ARM_LD"      "$ARM_EXTRA"       "armeabi"      "CLANG"  "armv6-linux-gnueabihf"; 
build_with_arg  "18"  "arm-linux-androideabi"   "arm"     "arm-linux-androideabi"    "$ARMV7_CFLAGS"    "$ARMV7_LD"    "$ARMV7_EXTRA"     "armeabi-v7"   "CLANG"  "armv7-linux-gnueabihf"; 
#build_with_arg  "21"  "aarch64-linux-android"   "arm64"   "aarch64-linux-android"    "$ARM64_CFLAGS"    "$ARM64_LD"    "$ARM64_EXTRA"     "arm64-v8a"    "CLANG"  "arm64-linux-gnueabihf";   
#build_with_arg  "18"  "mipsel-linux-android"    "mips"    "mipsel-linux-android"     "$MIPS_CFLAGS"     "$MIPS_LD"     "$MIPS_EXTRA"      "mips"         "CLANG"  "mips-linux-gnueabihf";    
#build_with_arg  "21"  "mips64el-linux-android"  "mips64"  "mips64el-linux-android"   "$MIPS64_CFLAGS"   "$MIPS64_LD"   "$MIPS64_EXTRA"    "mips64"       "CLANG"  "mips64el-linux-gnueabihf";  
#build_with_arg  "18"  "x86"                     "x86"     "i686-linux-android"       "$X86_CFLAGS"      "$X86_LD"      "$X86_EXTRA"       "x86"          "CLANG"  "x86-linux-gnueabihf";     
#build_with_arg  "21"  "x86_64"                  "x86_64"  "x86_64-linux-android"     "$X86_64_CFLAGS"   "$X86_64_LD"   "$X86_64_EXTRA"    "x86_64"       "CLANG"  "x86-64-linux-gnueabihf"; 
