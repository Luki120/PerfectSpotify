ARCHS = arm64 arm64e
TARGET := iphone:clang:latest:latest
DEBUG = 0
FINALPACKAGE = 1

INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = PerfectSpotify

PerfectSpotify_FILES = Tweak.xm
PerfectSpotify_CFLAGS = -fobjc-arc
PerfectSpotify_FRAMEWORKS = UIKit
PerfectSpotify_PRIVATE_FRAMEWORKS = MediaRemote
PerfectSpotify_EXTRA_FRAMEWORKS += Cephei # Add Cephei to extra frameworks and ws.hbang.common (>= 1.14) to control file

include $(THEOS_MAKE_PATH)/tweak.mk

SUBPROJECTS += spotiprefs

include $(THEOS_MAKE_PATH)/aggregate.mk
