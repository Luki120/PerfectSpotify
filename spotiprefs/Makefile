include $(THEOS)/makefiles/common.mk


BUNDLE_NAME = PerfectSpotify



PerfectSpotify_FILES = SPTRootListController.m MiscellaneousRootListController.m ContributorsRootListController.m KRTableCell.m KRLinkCell.m KRTwitterCell.m
PerfectSpotify_FRAMEWORKS = UIKit
PerfectSpotify_PRIVATE_FRAMEWORKS = Preferences
PerfectSpotify_EXTRA_FRAMEWORKS += Cephei CepheiPrefs
PerfectSpotify_INSTALL_PATH = /Library/PreferenceBundles
PerfectSpotify_CFLAGS = -fobjc-arc -Wdeprecated-declarations -Wno-deprecated-declarations
PerfectSpotify_LIBRARIES += sparkcolourpicker Kitten

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/PerfectSpotify.plist$(ECHO_END)
