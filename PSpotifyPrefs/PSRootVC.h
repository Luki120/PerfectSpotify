@import AudioToolbox.AudioServices;
@import Preferences.PSSpecifier;
@import Preferences.PSListController;
#import <spawn.h>
#import "Common/Common.h"


#define kPSpotifyTintColor [UIColor colorWithRed: 0.11 green: 0.73 blue: 0.33 alpha: 1.0]


@interface OBWelcomeController : UIViewController;
- (id)initWithTitle:(id)arg1 detailText:(id)arg2 icon:(id)arg3;
- (void)addBulletedListItemWithTitle:(id)arg1 description:(id)arg2 image:(id)arg3;
@end


@interface _UIBackdropViewSettings : NSObject
+ (id)settingsForStyle:(NSInteger)arg1;
@end


@interface _UIBackdropView : UIView
@property (assign, nonatomic) BOOL blurRadiusSetOnce;
@property (assign, nonatomic) double _blurRadius;
@property (copy, nonatomic) NSString *_blurQuality;
- (id)initWithSettings:(id)arg1;
- (id)initWithFrame:(CGRect)arg1 autosizesToFitSuperview:(BOOL)arg2 settings:(id)arg3;
@end


@interface PSRootVC : PSListController
@end


@interface PSContributorsVC : PSListController
@end


@interface PSLinksVC : PSListController
@end


@interface PSTableCell ()
- (void)setTitle:(NSString *)title;
@end


@interface PSpotifyTableCell : PSTableCell
@end


@interface UIApplication (PSpotify)
- (BOOL)launchApplicationWithIdentifier:(id)arg1 suspended:(BOOL)arg2;
@end
