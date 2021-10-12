#include "PSRootVC.h"


@implementation PSRootVC


- (NSArray *)specifiers {

	if(!_specifiers) _specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];

	return _specifiers;

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

}


- (instancetype)init {

	self = [super init];

	UIImage *icon = [UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/PSpotifyPrefs.bundle/Assets/PSIcon@2x.png"];;
	UIImage *banner = [UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/PSpotifyPrefs.bundle/Assets/PSBanner.png"];

	if(self) {

		self.killButton = [UIButton buttonWithType:UIButtonTypeCustom];
		self.killButton.tintColor = [UIColor colorWithRed: 0.11 green: 0.73 blue: 0.33 alpha: 1.00];
		[self.killButton setImage : [UIImage systemImageNamed:@"checkmark.circle"] forState:UIControlStateNormal];
		[self.killButton addTarget : self action:@selector(killSpotify) forControlEvents:UIControlEventTouchUpInside];

		UIBarButtonItem *killButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.killButton];		
		self.navigationItem.rightBarButtonItem = killButtonItem;

		self.navigationItem.titleView = [UIView new];
		self.iconView = [UIImageView new];
		self.iconView.image = icon;
		self.iconView.contentMode = UIViewContentModeScaleAspectFit;
		self.iconView.translatesAutoresizingMaskIntoConstraints = NO;
		[self.navigationItem.titleView addSubview:self.iconView];

		self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0,200,200)];
		self.headerImageView = [UIImageView new];
		self.headerImageView.image = banner;
		self.headerImageView.contentMode = UIViewContentModeScaleAspectFill;
		self.headerImageView.translatesAutoresizingMaskIntoConstraints = NO;
		[self.headerView addSubview:self.headerImageView];

		[self.iconView.topAnchor constraintEqualToAnchor : self.navigationItem.titleView.topAnchor].active = YES;
		[self.iconView.leadingAnchor constraintEqualToAnchor : self.navigationItem.titleView.leadingAnchor].active = YES;
		[self.iconView.trailingAnchor constraintEqualToAnchor : self.navigationItem.titleView.trailingAnchor].active = YES;
		[self.iconView.bottomAnchor constraintEqualToAnchor : self.navigationItem.titleView.bottomAnchor].active = YES;
		[self.headerImageView.topAnchor constraintEqualToAnchor : self.headerView.topAnchor].active = YES;
		[self.headerImageView.leadingAnchor constraintEqualToAnchor : self.headerView.leadingAnchor].active = YES;
		[self.headerImageView.trailingAnchor constraintEqualToAnchor :self.headerView.trailingAnchor].active = YES;
		[self.headerImageView.bottomAnchor constraintEqualToAnchor :self.headerView.bottomAnchor].active = YES;

	}

	return self;

}


- (void)viewDidLoad {

	[super viewDidLoad];

	_table.tableHeaderView = self.headerView;
	_table.separatorStyle = UITableViewCellSeparatorStyleNone;

}


- (void)viewWillAppear:(BOOL)animated {

	[super viewWillAppear:animated];

	CGRect frame = self.table.bounds;
	frame.origin.y = -frame.size.height;

}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

	CGFloat offsetY = scrollView.contentOffset.y;

	if(offsetY > 0) offsetY = 0;
	self.headerImageView.frame = CGRectMake(0, offsetY, self.headerView.frame.size.width, 150 - offsetY);

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	tableView.tableHeaderView = self.headerView;
	return [super tableView:tableView cellForRowAtIndexPath:indexPath];

}


- (void)resetAlert {

	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"PerfectSpotify" message:@"Do You Really Want To Reset Your Preferences?" preferredStyle:UIAlertControllerStyleAlert];

	UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"Shoot" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {

		[self resetPreferences];

	}];

	UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Maybe not" style:UIAlertActionStyleCancel handler:nil];

	[alertController addAction:confirmAction];
	[alertController addAction:cancelAction];

	[self presentViewController:alertController animated:YES completion:nil];

}

- (void)resetPreferences {

	NSFileManager *fileM = [NSFileManager defaultManager];

	BOOL success = [fileM removeItemAtPath:@"var/mobile/Library/Preferences/me.luki.perfectspotifyprefs.plist" error:nil];

	if(success) [self blurEffect];

}


- (void)blurEffect {

	UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleRegular];
	UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:blur];
	blurView.alpha = 0;
	blurView.frame = self.view.bounds;
	[self.view addSubview:blurView];

	[UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{

		blurView.alpha = 1;

	} completion:^(BOOL finished) {

		[self respring];

	}];

}


- (void)respring {

	pid_t pid;
	const char* args[] = {"killall", "backboardd", NULL};
	posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char *const *)args, NULL);

}


- (void)killSpotify {

	AudioServicesPlaySystemSound(1521);

	pid_t pid;
	const char* args[] = {"killall", "Spotify", NULL};
	posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)args, NULL);

	UIAlertController *decisiveAlert = [UIAlertController alertControllerWithTitle:@"PerfectSpotify" message:@"Spotify was succesfully destroyed and shattered into pieces, shall we rebuild it by launching it again?" preferredStyle:UIAlertControllerStyleAlert];

	UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"Shoot" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {

		[self launchSpotify];

	}];

	UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Maybe later" style:UIAlertActionStyleCancel handler:nil];

	[decisiveAlert addAction:confirmAction];
	[decisiveAlert addAction:cancelAction];

	[self presentViewController:decisiveAlert animated:YES completion:nil];

}


- (void)launchSpotify {

	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.05 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{

		[UIApplication.sharedApplication launchApplicationWithIdentifier:@"com.spotify.client" suspended:0];

	});

}


@end


@implementation PSContributorsVC


- (NSArray *)specifiers {

	if(!_specifiers) _specifiers = [self loadSpecifiersFromPlistName:@"PSContributors" target:self];

	return _specifiers;

}


@end


@implementation PSLinksVC


- (NSArray *)specifiers {

	if(!_specifiers) _specifiers = [self loadSpecifiersFromPlistName:@"PSLinks" target:self];

	return _specifiers;

}


- (void)lyrics {

	[UIApplication.sharedApplication openURL:[NSURL URLWithString: @"https://techcrunch.com/2020/06/29/in-a-significant-expansion-spotify-to-launch-real-time-lyrics-in-26-markets/"] options:@{} completionHandler:nil];

}


- (void)paypal {

	[UIApplication.sharedApplication openURL:[NSURL URLWithString: @"https://paypal.me/Luki120"] options:@{} completionHandler:nil];

}


- (void)github {

	[UIApplication.sharedApplication openURL:[NSURL URLWithString: @"https://github.com/Luki120/PerfectSpotify"] options:@{} completionHandler:nil];

}


- (void)amelija {

	[UIApplication.sharedApplication openURL:[NSURL URLWithString: @"https://repo.twickd.com/get/me.luki.amelija"] options:@{} completionHandler:nil];

}


- (void)april {

	[UIApplication.sharedApplication openURL:[NSURL URLWithString: @"https://repo.twickd.com/get/com.twickd.luki120.april"] options:@{} completionHandler:nil];

}


@end


@implementation PSpotifyTableCell


- (void)tintColorDidChange {

	[super tintColorDidChange];

	self.textLabel.textColor = tint;
	self.textLabel.highlightedTextColor = tint;

}


- (void)refreshCellContentsWithSpecifier:(PSSpecifier *)specifier {

	[super refreshCellContentsWithSpecifier:specifier];

	if([self respondsToSelector:@selector(tintColor)]) {

		self.textLabel.textColor = tint;
		self.textLabel.highlightedTextColor = tint;

	}

}


@end
