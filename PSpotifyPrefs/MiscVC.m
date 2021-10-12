#include "MiscVC.h"


@implementation ColorsVC


- (NSArray *)specifiers {

	if(!_specifiers) _specifiers = [self loadSpecifiersFromPlistName:@"Colors" target:self];

	return _specifiers;

}


@end


@implementation MiscVC


- (NSArray *)specifiers {

	if(!_specifiers) _specifiers = [self loadSpecifiersFromPlistName:@"Miscellaneous" target:self];

	return _specifiers;

}


@end


@implementation NowPlayingUIVC


- (NSArray *)specifiers {

	if(!_specifiers) _specifiers = [self loadSpecifiersFromPlistName:@"Now Playing UI" target:self];

	return _specifiers;

}


@end
