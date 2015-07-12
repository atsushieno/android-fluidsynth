
CENV=CERBERO_LOCAL_CONFIG=../../custom.cbc

all: build

.PHONY: prepare
prepare: external/cerbero
	cd external/cerbero && $(CENV) ./cerbero-uninstalled -c config/cross-android-armv7.cbc bootstrap

external/cerbero:
	git submodule init
	git submodule update --recursive

.PHONY: build
build: prepare-copy
	cd libs/armeabi-v7a && ../../rewrite-binary.sh
	cd libs/x86 && ../../rewrite-binary.sh

prepare-copy: build-cerbero
	mkdir -p libs/armeabi-v7a
	mkdir -p libs/x86
	cp build/dist/android_armv7/lib/*.so libs/armeabi-v7a
	cp build/dist/android_x86/lib/*.so libs/x86

build-cerbero:
	cd external/cerbero && $(CENV) ./cerbero-uninstalled -c config/cross-android-armv7.cbc build fluidsynth
	cd external/cerbero && $(CENV) ./cerbero-uninstalled -c config/cross-android-x86.cbc build fluidsynth

clean:
	cd external/cerbero && $(CENV) ./cerbero-uninstalled -c config/cross-android-armv7.cbc cleanone fluidsynth
	cd external/cerbero && $(CENV) ./cerbero-uninstalled -c config/cross-android-x86.cbc cleanone fluidsynth
	rm -rf libs

distclean:
	cd external/cerbero && $(CENV) ./cerbero-uninstalled -c config/cross-android-armv7.cbc wipe --build-tools
	cd external/cerbero && $(CENV) ./cerbero-uninstalled -c config/cross-android-x86.cbc wipe --build-tools
