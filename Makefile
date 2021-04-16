export ARCHS = arm64 arm64e
export TARGET := iphone:clang:latest:latest

DEBUG = 0
FINALPACKAGE = 1

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = PerfectSpotify

PerfectSpotify_FILES = PerfectSpotify.xm
PerfectSpotify_CFLAGS = -fobjc-arc
PerfectSpotify_FRAMEWORKS = UIKit
PerfectSpotify_PRIVATE_FRAMEWORKS = MediaRemote
PerfectSpotify_EXTRA_FRAMEWORKS += Cephei # Add Cephei to extra frameworks and ws.hbang.common (>= 1.14) to control file
PerfectSpotify_LIBRARIES += gcuniversal Kitten

include $(THEOS_MAKE_PATH)/tweak.mk

SUBPROJECTS += spotiprefs

include $(THEOS_MAKE_PATH)/aggregate.mk

after-install::
	install.exec "sbreload"