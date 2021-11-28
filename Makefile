export ARCHS = arm64 arm64e
export TARGET := iphone:clang:latest:latest

INSTALL_TARGET_PROCESSES = Spotify Preferences

TWEAK_NAME = PerfectSpotify

PerfectSpotify_FILES = PerfectSpotify.xm
PerfectSpotify_CFLAGS = -fobjc-arc
PerfectSpotify_LIBRARIES += gcuniversal Kitten
PerfectSpotify_PRIVATE_FRAMEWORKS = MediaRemote

SUBPROJECTS += PSpotifyPrefs

include $(THEOS)/makefiles/common.mk
include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS_MAKE_PATH)/aggregate.mk