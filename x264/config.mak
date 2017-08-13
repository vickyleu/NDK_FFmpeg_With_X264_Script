SRCPATH=.
prefix=./libs/x86_64
exec_prefix=${prefix}
bindir=${exec_prefix}/bin
libdir=${exec_prefix}/lib
includedir=${prefix}/include
SYS_ARCH=X86_64
SYS=LINUX
CC=/opt/ndk/toolchains/x86_64-4.9/prebuilt/linux-x86_64/bin/x86_64-linux-android-gcc
CFLAGS=-Wno-maybe-uninitialized -Wshadow -O3 -ffast-math -m64  -Wall -I. -I$(SRCPATH) --sysroot=/opt/ndk/platforms/android-21/arch-x86_64/ -std=gnu99 -D_GNU_SOURCE -mpreferred-stack-boundary=6 -fPIC -fomit-frame-pointer -fno-tree-vectorize
COMPILER=GNU
COMPILER_STYLE=GNU
DEPMM=-MM -g0
DEPMT=-MT
LD=/opt/ndk/toolchains/x86_64-4.9/prebuilt/linux-x86_64/bin/x86_64-linux-android-gcc -o 
LDFLAGS=-m64  --sysroot=/opt/ndk/platforms/android-21/arch-x86_64/ -lm  -ldl
LIBX264=libx264.a
AR=/opt/ndk/toolchains/x86_64-4.9/prebuilt/linux-x86_64/bin/x86_64-linux-android-gcc-ar rc 
RANLIB=/opt/ndk/toolchains/x86_64-4.9/prebuilt/linux-x86_64/bin/x86_64-linux-android-gcc-ranlib
STRIP=/opt/ndk/toolchains/x86_64-4.9/prebuilt/linux-x86_64/bin/x86_64-linux-android-strip
INSTALL=install
AS=nasm
ASFLAGS= -I. -I$(SRCPATH) -DARCH_X86_64=1 -I$(SRCPATH)/common/x86/ -f elf64 -DSTACK_ALIGNMENT=64 -DPIC -DHIGH_BIT_DEPTH=0 -DBIT_DEPTH=8
RC=
RCFLAGS=
EXE=
HAVE_GETOPT_LONG=1
DEVNULL=/dev/null
PROF_GEN_CC=-fprofile-generate
PROF_GEN_LD=-fprofile-generate
PROF_USE_CC=-fprofile-use
PROF_USE_LD=-fprofile-use
HAVE_OPENCL=yes
default: cli
install: install-cli
default: lib-static
install: install-lib-static
LDFLAGSCLI = -ldl 
CLI_LIBX264 = $(LIBX264)
