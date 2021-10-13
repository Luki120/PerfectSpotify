#import <spawn.h>
#import <Preferences/PSSpecifier.h>
#import <AudioToolbox/AudioServices.h>
#import <Preferences/PSListController.h>


static NSString *prefsKeys = @"/var/mobile/Library/Preferences/me.luki.perfectspotifyprefs.plist";

#define tint [UIColor colorWithRed: 0.11 green: 0.73 blue: 0.33 alpha: 1.00]


@interface OBButtonTray : UIView
@property (nonatomic, strong) UIVisualEffectView *effectView;
- (void)addButton:(id)arg1;
- (void)addCaptionText:(id)arg1;
@end


@interface OBBoldTrayButton : UIButton
+ (id)buttonWithType:(long long)arg1;
- (void)setTitle:(id)arg1 forState:(unsigned long long)arg2;
@end


@interface OBWelcomeController : UIViewController
@property (nonatomic, strong) UIView *viewIfLoaded;
@property (nonatomic, strong) UIColor *backgroundColor;
@property (assign, nonatomic) BOOL _shouldInlineButtontray;
- (OBButtonTray *)buttonTray;
- (id)initWithTitle:(id)arg1 detailText:(id)arg2 icon:(id)arg3;
- (void)addBulletedListItemWithTitle:(id)arg1 description:(id)arg2 image:(id)arg3;
@end


@interface _UIBackdropViewSettings : NSObject
+ (id)settingsForStyle:(long long)arg1;
@end


@interface _UIBackdropView : UIView
- (id)initWithFrame:(CGRect)arg1 autosizesToFitSuperview:(BOOL)arg2 settings:(id)arg3;
- (id)initWithSettings:(id)arg1;
@property (assign, nonatomic) BOOL blurRadiusSetOnce;
@property (assign, nonatomic) double _blurRadius;
@property (copy, nonatomic) NSString *_blurQuality;
@end


@interface PSRootVC : PSListController {

    UITableView * _table;

}

@property (nonatomic, strong) UIButton *changelogButton;
@property (nonatomic, strong) UIButton *killButton;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) OBWelcomeController *changelogController;
- (void)resetAlert;
- (void)resetPreferences;
- (void)respring;
@end


@interface PSContributorsVC : PSListController
@end


@interface PSLinksVC : PSListController
@end


@interface PSpotifyTableCell : PSTableCell
@end


@interface UIApplication (PSpotify)
- (BOOL)launchApplicationWithIdentifier:(id)arg1 suspended:(BOOL)arg2;
@end
