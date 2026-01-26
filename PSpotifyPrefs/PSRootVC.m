#import "PSRootVC.h"


@implementation PSRootVC {

	UIImageView *iconView;
	UIButton *killButton;
	UIButton *changelogButton;
	UIView *headerView;
	UIImageView *headerImageView;
	OBWelcomeController *changelogController;

}

- (NSArray *)specifiers {

	if(!_specifiers) _specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	return _specifiers;

}

- (id)init {

	self = [super init];
	if(self) [self setupUI];
	return self;

}

- (void)setupUI {

	UIImage *iconImage = [UIImage imageWithContentsOfFile:rootlessPathNS(@"/Library/PreferenceBundles/PSpotifyPrefs.bundle/Assets/PSIcon@2x.png")];
	UIImage *bannerImage = [UIImage imageWithContentsOfFile:rootlessPathNS(@"/Library/PreferenceBundles/PSpotifyPrefs.bundle/Assets/PSBanner.png")];

	changelogButton =  [UIButton new];
	changelogButton.tintColor = kPSpotifyTintColor;
	[changelogButton setImage:[UIImage systemImageNamed:@"atom"] forState:UIControlStateNormal];
	[changelogButton addTarget:self action:@selector(showWtfChangedInThisVersion) forControlEvents:UIControlEventTouchUpInside];

	UIBarButtonItem *changelogButtonItem = [[UIBarButtonItem alloc] initWithCustomView: changelogButton];

	killButton = [UIButton new];
	killButton.tintColor = kPSpotifyTintColor;
	[killButton setImage:[UIImage systemImageNamed:@"checkmark.circle"] forState:UIControlStateNormal];
	[killButton addTarget:self action:@selector(killSpotify) forControlEvents:UIControlEventTouchUpInside];

	UIBarButtonItem *killButtonItem = [[UIBarButtonItem alloc] initWithCustomView: killButton];

	NSArray *rightButtons;
	rightButtons = @[killButtonItem, changelogButtonItem];
	self.navigationItem.rightBarButtonItems = rightButtons;

	self.navigationItem.titleView = [UIView new];
	iconView = [UIImageView new];
	iconView.image = iconImage;
	iconView.contentMode = UIViewContentModeScaleAspectFit;
	iconView.translatesAutoresizingMaskIntoConstraints = NO;
	[self.navigationItem.titleView addSubview:iconView];

	if(!headerView) headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0,200,200)];

	if(!headerImageView) {
		headerImageView = [UIImageView new];
		headerImageView.image = bannerImage;
		headerImageView.contentMode = UIViewContentModeScaleAspectFill;
		headerImageView.translatesAutoresizingMaskIntoConstraints = NO;
		[headerView addSubview: headerImageView];		
	}

	long currentYear = [[NSCalendar currentCalendar] component:NSCalendarUnitYear fromDate: [NSDate date]];

	PSSpecifier *footerSpecifier = [PSSpecifier preferenceSpecifierNamed:nil target:self set:nil get:nil detail:nil cell:PSGroupCell edit:nil];
	[footerSpecifier setProperty:@1 forKey:@"footerAlignment"];
	[footerSpecifier setProperty:@YES forKey:@"isStaticText"];
	[footerSpecifier setProperty:[NSString stringWithFormat:@"© 2020-%ld Luki120", currentYear] forKey:@"footerText"];

	[self insertSpecifier:footerSpecifier afterSpecifierID: @"FooterText"];
	[self layoutUI];

}

- (void)layoutUI {

	[iconView.topAnchor constraintEqualToAnchor: self.navigationItem.titleView.topAnchor].active = YES;
	[iconView.bottomAnchor constraintEqualToAnchor: self.navigationItem.titleView.bottomAnchor].active = YES;
	[iconView.leadingAnchor constraintEqualToAnchor: self.navigationItem.titleView.leadingAnchor].active = YES;
	[iconView.trailingAnchor constraintEqualToAnchor: self.navigationItem.titleView.trailingAnchor].active = YES;

	[headerImageView.topAnchor constraintEqualToAnchor: headerView.topAnchor].active = YES;
	[headerImageView.bottomAnchor constraintEqualToAnchor: headerView.bottomAnchor].active = YES;
	[headerImageView.leadingAnchor constraintEqualToAnchor: headerView.leadingAnchor].active = YES;
	[headerImageView.trailingAnchor constraintEqualToAnchor: headerView.trailingAnchor].active = YES;

}

- (void)killSpotify {

	AudioServicesPlaySystemSound(1521);

	pid_t pid;
	const char* args[] = {"killall", "Spotify", NULL};
	posix_spawn(&pid, rootlessPathC("/usr/bin/killall"), NULL, NULL, (char* const*)args, NULL);

	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"PerfectSpotify" message:@"Spotify was succesfully destroyed & shattered into pieces, shall we rebuild it by launching it again?" preferredStyle:UIAlertControllerStyleAlert];
	UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"Shoot" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {

		[self launchSpotify];

	}];

	UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Maybe later" style:UIAlertActionStyleDefault handler:nil];

	[alertController addAction: confirmAction];
	[alertController addAction: cancelAction];

	[self presentViewController:alertController animated:YES completion:nil];

}

- (void)launchSpotify {

	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.05 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{

		[UIApplication.sharedApplication launchApplicationWithIdentifier:@"com.spotify.client" suspended:0];

	});

}

- (void)showWtfChangedInThisVersion {

	AudioServicesPlaySystemSound(1521);

	UIImage *tweakIconImage = [UIImage imageWithContentsOfFile:rootlessPathNS(@"/Library/PreferenceBundles/PSpotifyPrefs.bundle/Assets/PSpotifyIcon.png")];
	UIImage *checkmarkImage = [UIImage systemImageNamed:@"checkmark.circle.fill"];

	if(changelogController) { [self presentViewController:changelogController animated:YES completion:nil]; return; }
	changelogController = [[OBWelcomeController alloc] initWithTitle:@"PerfectSpotify" detailText:@"2.3~EOL" icon: tweakIconImage];
	[changelogController addBulletedListItemWithTitle:@"Tweak" description:@"Please visit the source on GitHub to see the changelog." image: checkmarkImage];

	_UIBackdropViewSettings *settings = [_UIBackdropViewSettings settingsForStyle:2];

	_UIBackdropView *backdropView = [[_UIBackdropView alloc] initWithFrame:CGRectZero autosizesToFitSuperview:YES settings:settings];
	backdropView.clipsToBounds = YES;
	[changelogController.viewIfLoaded insertSubview:backdropView atIndex:0];

	changelogController.view.tintColor = kPSpotifyTintColor;
	changelogController.modalInPresentation = NO;
	changelogController.modalPresentationStyle = UIModalPresentationPageSheet;
	changelogController.viewIfLoaded.backgroundColor = UIColor.clearColor;

	[self presentViewController:changelogController animated:YES completion:nil];

}

- (void)resetPreferences {

	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"PerfectSpotify" message:@"Are you sure bozo?" preferredStyle:UIAlertControllerStyleAlert];
	UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"Shoot" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {

		[[NSFileManager defaultManager] removeItemAtPath:kPath error:nil];
		[self crossDissolveBlur];

	}];
	UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Maybe not" style:UIAlertActionStyleCancel handler:nil];

	[alertController addAction: confirmAction];
	[alertController addAction: cancelAction];

	[self presentViewController:alertController animated:YES completion:nil];

}

- (void)crossDissolveBlur {

	_UIBackdropViewSettings *settings = [_UIBackdropViewSettings settingsForStyle:2];

	_UIBackdropView *backdropView = [[_UIBackdropView alloc] initWithFrame:CGRectZero autosizesToFitSuperview:YES settings:settings];
	backdropView.alpha = 0;
	backdropView.clipsToBounds = YES;
	[self.view addSubview: backdropView];

	[UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{

		backdropView.alpha = 1;

	} completion:^(BOOL finished) { [self launchRespring]; }];

}

- (void)launchRespring {

	pid_t pid;
	const char* args[] = {"killall", "backboardd", NULL};
	posix_spawn(&pid, rootlessPathC("/usr/bin/killall"), NULL, NULL, (char *const *)args, NULL);

}

- (BOOL)shouldReloadSpecifiersOnResume {
	return NO;
}

// ! UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	tableView.tableHeaderView = headerView;
	return [super tableView:tableView cellForRowAtIndexPath:indexPath];

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

- (void)launchLyricsLink { [self launchURL: [NSURL URLWithString: @"https://techcrunch.com/2020/06/29/in-a-significant-expansion-spotify-to-launch-real-time-lyrics-in-26-markets/"]]; }
- (void)launchPayPal { [self launchURL: [NSURL URLWithString: @"https://paypal.me/Luki120"]]; }
- (void)launchGitHub { [self launchURL: [NSURL URLWithString: @"https://github.com/Luki120/PerfectSpotify"]]; }
- (void)launchAmelija { [self launchURL: [NSURL URLWithString: @"https://luki120.github.io/depictions/web/?p=me.luki.amelija"]]; }
- (void)launchApril { [self launchURL: [NSURL URLWithString: @"https://luki120.github.io/depictions/web/?p=me.luki.april"]]; }

- (void)launchURL:(NSURL *)url { [UIApplication.sharedApplication openURL:url options:@{} completionHandler:nil]; }

@end

@implementation PSpotifyTableCell

- (void)setTitle:(NSString *)title {

	[super setTitle: title];
	self.titleLabel.textColor = kPSpotifyTintColor;

}

@end
