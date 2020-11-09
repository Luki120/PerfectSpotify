#include "MiscellaneousRootListController.h"

@implementation MiscellaneousRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Miscellaneous" target:self];
	}

	return _specifiers;
}

@end


@implementation NowPlayingUIRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Now Playing UI" target:self];
	}

	return _specifiers;
}

@end