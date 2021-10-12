#import <spawn.h>
#import <Preferences/PSSpecifier.h>
#import <AudioToolbox/AudioServices.h>
#import <Preferences/PSListController.h>


static NSString *prefsKeys = @"/var/mobile/Library/Preferences/me.luki.perfectspotifyprefs.plist";

#define tint [UIColor colorWithRed: 0.11 green: 0.73 blue: 0.33 alpha: 1.00]

@interface PSRootVC : PSListController {

    UITableView * _table;

}

@property (nonatomic, strong) UIButton *killButton;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UIImageView *headerImageView;
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