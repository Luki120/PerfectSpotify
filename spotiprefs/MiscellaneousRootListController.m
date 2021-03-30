#include "MiscellaneousRootListController.h"

@implementation MiscellaneousRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Miscellaneous" target:self];
	}

	return _specifiers;
}

@end


@implementation ColorsRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Colors" target:self];
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


@implementation CarModeUIRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Car Mode UI" target:self];
	}

	return _specifiers;
}

@end


@implementation SearchPageRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Search Page" target:self];
	}

	return _specifiers;
}

@end


@implementation PodcastsUIRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Podcasts UI" target:self];
	}

	return _specifiers;
}

@end