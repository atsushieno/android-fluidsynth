LOCAL_PATH := $(call my-dir)
TARGET_PLATFORM := android-21

include $(CLEAR_VARS)

LOCAL_MODULE := fluidsynth

TARGET_ARCH_DIR = android_$(TARGET_ARCH)
DIST = build/dist/$(TARGET_ARCH_DIR)
FL_SRC = ../build/sources/$(TARGET_ARCH_DIR)/fluidsynth-1.1.6/fluidsynth/src
FL_INC = build/sources/$(TARGET_ARCH_DIR)/fluidsynth-1.1.6/fluidsynth/src

LOCAL_CFLAGS := \
	-DOPENSLES_SUPPORT \
	-DDEFAULT_SOUNDFONT=NULL \
	-DHAVE_CONFIG_H

LOCAL_C_INCLUDES := \
	$(FL_INC) \
	$(FL_INC)/utils \
	$(FL_INC)/midi \
	$(FL_INC)/rvoice \
	$(FL_INC)/sfloader \
	$(FL_INC)/bindings \
	$(FL_INC)/synth \
	$(FL_INC)/drivers \
	$(DIST)/include/glib-2.0 \
	$(DIST)/lib/glib-2.0/include \
	$(DIST)/include

LOCAL_SRC_FILES := \
	$(FL_SRC)/synth/fluid_gen.c \
	$(FL_SRC)/synth/fluid_tuning.c \
	$(FL_SRC)/synth/fluid_mod.c \
	$(FL_SRC)/synth/fluid_synth.c \
	$(FL_SRC)/synth/fluid_event.c \
	$(FL_SRC)/synth/fluid_voice.c \
	$(FL_SRC)/synth/fluid_chan.c \
	$(FL_SRC)/rvoice/fluid_rev.c \
	$(FL_SRC)/rvoice/fluid_lfo.c \
	$(FL_SRC)/rvoice/fluid_rvoice.c \
	$(FL_SRC)/rvoice/fluid_rvoice_mixer.c \
	$(FL_SRC)/rvoice/fluid_adsr_env.c \
	$(FL_SRC)/rvoice/fluid_rvoice_event.c \
	$(FL_SRC)/rvoice/fluid_chorus.c \
	$(FL_SRC)/rvoice/fluid_iir_filter.c \
	$(FL_SRC)/rvoice/fluid_rvoice_dsp.c \
	$(FL_SRC)/sfloader/fluid_ramsfont.c \
	$(FL_SRC)/sfloader/fluid_defsfont.c \
	$(FL_SRC)/drivers/fluid_mdriver.c \
	$(FL_SRC)/drivers/fluid_opensles.c \
	$(FL_SRC)/drivers/fluid_adriver.c \
	$(FL_SRC)/drivers/fluid_aufile.c \
	$(FL_SRC)/drivers/fluid_oss.c \
	$(FL_SRC)/drivers/fluid_sndmgr.c \
	$(FL_SRC)/fluidsynth.c \
	$(FL_SRC)/utils/fluid_ringbuffer.c \
	$(FL_SRC)/utils/fluid_conv.c \
	$(FL_SRC)/utils/fluid_hash.c \
	$(FL_SRC)/utils/fluid_sys.c \
	$(FL_SRC)/utils/fluid_settings.c \
	$(FL_SRC)/utils/fluid_list.c \
	$(FL_SRC)/fluid_dll.c \
	$(FL_SRC)/bindings/fluid_cmd.c \
	$(FL_SRC)/bindings/fluid_filerenderer.c \
	$(FL_SRC)/bindings/fluid_rtkit.c \
	$(FL_SRC)/midi/fluid_midi_router.c \
	$(FL_SRC)/midi/fluid_seq.c \
	$(FL_SRC)/midi/fluid_seqbind.c \
	$(FL_SRC)/midi/fluid_midi.c

LOCAL_LDLIBS := -lc -lOpenSLES -ldl -llog -landroid -L$(DIST)/lib/ -lglib-2.0

include $(BUILD_SHARED_LIBRARY)

