export ARCHS = arm64 arm64e
export TARGET := iphone:clang:latest:latest
DEBUG = 0
FINALPACKAGE = 1

THEOS_DEVICE_IP = 192.168.0.7
#THEOS_DEVICE_IP = 192.168.0.15

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = PerfectSpotify

PerfectSpotify_FILES = Tweak.xm
PerfectSpotify_CFLAGS = -fobjc-arc
PerfectSpotify_FRAMEWORKS = UIKit
PerfectSpotify_PRIVATE_FRAMEWORKS = MediaRemote
PerfectSpotify_EXTRA_FRAMEWORKS += Cephei # Add Cephei to extra frameworks and ws.hbang.common (>= 1.14) to control file
PerfectSpotify_LIBRARIES += sparkcolourpicker Kitten

include $(THEOS_MAKE_PATH)/tweak.mk

SUBPROJECTS += spotiprefs

include $(THEOS_MAKE_PATH)/aggregate.mk

after-install::
	install.exec "sbreload"
