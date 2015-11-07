#export ANDROID_NDK_PATH=~/android-ndk-r10e
export BUILD_OS=linux-x86_64
export ANDROID_VER=21 # 3 4 5 8 9 14 21
#export ARCH=arm-linux-androideabi # arm-linux-androideabi or mipsel-linux or x86
#export ARCH2=arm-linux-androideabi # arm-linux-androideabi or mipsel-linux-android or i686-linux-android
#export ARCH3=armv7 # armv7 or mipsel or x86
#export ARCH4=arm #arm or arm64 or x86 or x86_64
export TOOLFAMILY=4.9 # 4.8 or 4.9 or clang-3.1
export SYSROOT=$ANDROID_NDK_PATH/platforms/android-$ANDROID_VER/arch-$ARCH4
export CC="$ANDROID_NDK_PATH/toolchains/$ARCH-$TOOLFAMILY/prebuilt/$BUILD_OS/bin/$ARCH2-g++ --sysroot=$SYSROOT -fno-stack-protector"
export LD="$ANDROID_NDK_PATH/toolchains/$ARCH-$TOOLFAMILY/prebuilt/$BUILD_OS/bin/$ARCH2-g++ --sysroot=$SYSROOT -Wl,-rpath-link=$SYSROOT/usr/lib/ -L$SYSROOT/usr/lib/ -lc"
export TARGET_LIBRARY=libfluidsynth

export LIB_DIR=build/dist/android_$ARCH3/lib
export LIBS="\
	$LIB_DIR/libffi.a \
	$LIB_DIR/libfluidsynth.a \
	$LIB_DIR/libgio-2.0.a \
	$LIB_DIR/libglib-2.0.a \
	$LIB_DIR/libgmodule-2.0.a \
	$LIB_DIR/libgobject-2.0.a \
	$LIB_DIR/libgthread-2.0.a \
	$LIB_DIR/libintl.a \
	$LIB_DIR/libsupc++.a \
	$LIB_DIR/libz.a"
	#$LIB_DIR/libcharset.a \
	#$LIB_DIR/libgnustl.a \
	#$LIB_DIR/libiconv.a \


#gl_cv_header_working_stdint_h=yes ./configure --host=x86 CPPFLAGS="-fpic -O0" CFLAGS="-fpic -O0"

#make

$CC dso_handle.c -c -o dso_handle.o
$LD -nostdlib -shared -s -o libfluidsynth.so -Wl,-soname,libfluidsynth.so -Wl,-whole-archive -fno-stack-protector -lc $LIBS dso_handle.o

