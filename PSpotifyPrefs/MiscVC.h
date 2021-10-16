#import <Preferences/PSSpecifier.h>
#import <Preferences/PSListController.h>


static NSString *prefsKeys = @"/var/mobile/Library/Preferences/me.luki.perfectspotifyprefs.plist";


@interface ColorsVC : PSListController
@end


@interface MiscVC : PSListController
@end


@interface PSListController (Private)
- (BOOL)containsSpecifier:(PSSpecifier *)arg1;
@end


@interface NowPlayingUIVC : PSListController
@end


@interface ExtraFeaturesVC : PSListController
@property (nonatomic, strong) NSMutableDictionary *savedSpecifiers;
@end
