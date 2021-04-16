include $(THEOS)/makefiles/common.mk


BUNDLE_NAME = PerfectSpotify



PerfectSpotify_FILES = SPTRootListController.m MiscellaneousRootListController.m ContributorsRootListController.m KRTableCell.m KRLinkCell.m KRTwitterCell.m
PerfectSpotify_FRAMEWORKS = UIKit
PerfectSpotify_PRIVATE_FRAMEWORKS = Preferences
PerfectSpotify_EXTRA_FRAMEWORKS += Cephei CepheiPrefs
PerfectSpotify_INSTALL_PATH = /Library/PreferenceBundles
PerfectSpotify_CFLAGS = -fobjc-arc -Wdeprecated-declarations -Wno-deprecated-declarations
PerfectSpotify_LIBRARIES += gcuniversal Kitten

include $(THEOS_MAKE_PATH)/bundle.mk
