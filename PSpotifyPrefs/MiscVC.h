@import Preferences.PSSpecifier;
@import Preferences.PSListController;
#import "Common/Common.h"


@interface SpringBoardVC : PSListController
@end


@interface MiscVC : PSListController
@end


@interface NowPlayingUIVC : PSListController
@end


@interface ExtraFeaturesVC : PSListController
@property (nonatomic, strong) NSMutableDictionary *savedSpecifiers;
@end


@interface PSListController (Private)
- (BOOL)containsSpecifier:(PSSpecifier *)arg1;
@end
