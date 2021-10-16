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


@implementation ExtraFeaturesVC


- (NSArray *)specifiers {

	if(!_specifiers) {

		_specifiers = [self loadSpecifiersFromPlistName:@"++ Features" target:self];

		NSArray *chosenIDs = @[@"ModernButtonsSwitch", @"ArtworkBasedColorsSwitch", @"GroupCell1", @"HapticsSwitch", @"GroupCell2", @"HapticsOptionsCell", @"GroupCell3", @"CanvasOptionsCell"];
		self.savedSpecifiers = (self.savedSpecifiers) ?: [NSMutableDictionary new];

		for(PSSpecifier *specifier in _specifiers)

			if([chosenIDs containsObject:[specifier propertyForKey:@"id"]])

				[self.savedSpecifiers setObject:specifier forKey:[specifier propertyForKey:@"id"]];

	}

	return _specifiers;

}



- (void)reloadSpecifiers {

	[super reloadSpecifiers];

	if(![[self readPreferenceValue:[self specifierForID:@"SpotifyUISwitch"]] boolValue])

		[self removeContiguousSpecifiers:@[self.savedSpecifiers[@"ModernButtonsSwitch"], self.savedSpecifiers[@"ArtworkBasedColorsSwitch"], self.savedSpecifiers[@"GroupCell1"], self.savedSpecifiers[@"HapticsSwitch"], self.savedSpecifiers[@"GroupCell2"], self.savedSpecifiers[@"HapticsOptionsCell"]] animated:NO];


	else if(![self containsSpecifier:self.savedSpecifiers[@"ModernButtonsSwitch"]])

		[self insertContiguousSpecifiers:@[self.savedSpecifiers[@"ModernButtonsSwitch"], self.savedSpecifiers[@"ArtworkBasedColorsSwitch"], self.savedSpecifiers[@"GroupCell1"], self.savedSpecifiers[@"HapticsSwitch"], self.savedSpecifiers[@"GroupCell2"], self.savedSpecifiers[@"HapticsOptionsCell"]] afterSpecifierID:@"SpotifyUISwitch" animated:NO];


	if(![[self readPreferenceValue:[self specifierForID:@"SaveCanvasSwitch"]] boolValue]) {

		[self removeSpecifier:self.savedSpecifiers[@"GroupCell3"] animated:NO];
		[self removeSpecifier:self.savedSpecifiers[@"CanvasOptionsCell"] animated:NO];

	}

	else if(![self containsSpecifier:self.savedSpecifiers[@"CanvasOptionsCell"]]) {

		[self insertSpecifier:self.savedSpecifiers[@"GroupCell3"] afterSpecifierID:@"SaveCanvasSwitch" animated:NO];
		[self insertSpecifier:self.savedSpecifiers[@"CanvasOptionsCell"] afterSpecifierID:@"GroupCell3" animated:NO];

	}

}

- (void)viewDidLoad {

	[super viewDidLoad];
	[self reloadSpecifiers];

}


- (id)readPreferenceValue:(PSSpecifier*)specifier {

	NSMutableDictionary *settings = [NSMutableDictionary dictionary];
	[settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefsKeys]];
	return (settings[specifier.properties[@"key"]]) ?: specifier.properties[@"default"];

}


- (void)setPreferenceValue:(id)value specifier:(PSSpecifier*)specifier {

	NSMutableDictionary *settings = [NSMutableDictionary dictionary];
	[settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:prefsKeys]];
	[settings setObject:value forKey:specifier.properties[@"key"]];
	[settings writeToFile:prefsKeys atomically:YES];

	NSString *key = [specifier propertyForKey:@"key"];


	if([key isEqualToString:@"enableSpotifyUI"]) {

	if(![[self readPreferenceValue:[self specifierForID:@"SpotifyUISwitch"]] boolValue])

		[self removeContiguousSpecifiers:@[self.savedSpecifiers[@"ModernButtonsSwitch"], self.savedSpecifiers[@"ArtworkBasedColorsSwitch"], self.savedSpecifiers[@"GroupCell1"], self.savedSpecifiers[@"HapticsSwitch"], self.savedSpecifiers[@"GroupCell2"], self.savedSpecifiers[@"HapticsOptionsCell"]] animated:YES];


	else if(![self containsSpecifier:self.savedSpecifiers[@"ModernButtonsSwitch"]])

		[self insertContiguousSpecifiers:@[self.savedSpecifiers[@"ModernButtonsSwitch"], self.savedSpecifiers[@"ArtworkBasedColorsSwitch"], self.savedSpecifiers[@"GroupCell1"], self.savedSpecifiers[@"HapticsSwitch"], self.savedSpecifiers[@"GroupCell2"], self.savedSpecifiers[@"HapticsOptionsCell"]] afterSpecifierID:@"SpotifyUISwitch" animated:YES];
	
	}


	if([key isEqualToString:@"saveCanvas"]) {

		if(![value boolValue]) {

			[self removeSpecifier:self.savedSpecifiers[@"GroupCell3"] animated:YES];
			[self removeSpecifier:self.savedSpecifiers[@"CanvasOptionsCell"] animated:YES];

		}

		else if(![self containsSpecifier:self.savedSpecifiers[@"CanvasOptionsCell"]]) {

			[self insertSpecifier:self.savedSpecifiers[@"GroupCell3"] afterSpecifierID:@"SaveCanvasSwitch" animated:YES];
			[self insertSpecifier:self.savedSpecifiers[@"CanvasOptionsCell"] afterSpecifierID:@"GroupCell3" animated:YES];

		}

	}

}

@end
