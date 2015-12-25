
CENV=CERBERO_LOCAL_CONFIG=../../custom.cbc

CERBERO=external/cerbero

all: build

.PHONY: prepare
prepare: $(CERBERO)
	cd external/cerbero && $(CENV) ./cerbero-uninstalled -c config/cross-android-armv7.cbc bootstrap
	cd external/cerbero && $(CENV) ./cerbero-uninstalled -c config/cross-android-x86.cbc bootstrap

$(CERBERO):
	git submodule init
	git submodule update --recursive

.PHONY: build
build: build-cerbero ndk-build-x86 binaryhack-arm

x86shortcut: ndk-build-x86

binaryhack-full: build-cerbero binaryhack
build-single-lib-full: build-cerbero build-single-lib
ndk-build-full: build-cerbero ndk-build


binaryhack: binaryhack-arm binaryhack-x86

binaryhack-arm:
	mkdir -p libs/armeabi-v7a
	cp build/dist/android_armv7/lib/*.so libs/armeabi-v7a
	cd libs/armeabi-v7a && ../../rewrite-binary.sh

binaryhack-x86:
	mkdir -p libs/x86
	cp build/dist/android_x86/lib/*.so libs/x86
	cd libs/x86 && ../../rewrite-binary.sh


build-single-lib: build-single-lib-arm build-single-lib-x86

build-single-lib-arm:
	ARCH=arm-linux-androideabi ARCH2=arm-linux-androideabi ARCH3=armv7 ARCH4=arm ./build-single-lib.sh
	cp libfluidsynth.so libs/armeabi-v7a

build-single-lib-x86:
	ARCH=x86 ARCH2=i686-linux-android ARCH3=x86 ARCH4=x86 ./build-single-lib.sh
	cp libfluidsynth.so libs/x86


ndk-build: ndk-build-arm ndk-build-x86

ndk-build-arm:
	~/android-ndk-r10e/ndk-build TARGET_ARCH=armv7 APP_ABI=armeabi-v7a
	cp obj/local/armeabi-v7a/libfluidsynth.so libs/x86

ndk-build-x86:
	~/android-ndk-r10e/ndk-build TARGET_ARCH=x86 APP_ABI=x86
	cp obj/local/x86/libfluidsynth.so libs/x86


build-cerbero: build-cerbero-arm build-cerbero-x86

build-cerbero-arm: $(CERBERO)
	cd external/cerbero && $(CENV) ./cerbero-uninstalled -c config/cross-android-armv7.cbc build $(BUILD_ARGS) fluidsynth

build-cerbero-x86: $(CERBERO)
	cd external/cerbero && $(CENV) ./cerbero-uninstalled -c config/cross-android-x86.cbc build $(BUILD_ARGS) fluidsynth


buildone-cerbero: buildone-cerbero-arm buildone-cerbero-x86

buildone-cerbero-arm: $(CERBERO)
	cd external/cerbero && $(CENV) ./cerbero-uninstalled -c config/cross-android-armv7.cbc buildone fluidsynth $(BUILD_ARGS)

buildone-cerbero-x86: $(CERBERO)
	cd external/cerbero && $(CENV) ./cerbero-uninstalled -c config/cross-android-x86.cbc buildone fluidsynth $(BUILD_ARGS)


clean-cerbero: $(CERBERO)
	cd external/cerbero && $(CENV) ./cerbero-uninstalled -c config/cross-android-x86.cbc clean fluidsynth
	cd external/cerbero && $(CENV) ./cerbero-uninstalled -c config/cross-android-armv7.cbc clean fluidsynth

distclean: $(CERBERO)
	cd external/cerbero && $(CENV) ./cerbero-uninstalled -c config/cross-android-x86.cbc wipe --build-tools
	cd external/cerbero && $(CENV) ./cerbero-uninstalled -c config/cross-android-armv7.cbc wipe --build-tools
