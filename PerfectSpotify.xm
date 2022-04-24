#import "PerfectSpotify.h"


/*************/
// ! | Colors |
/*************/

%group PerfectSpotify


%hook MPNowPlayingInfoCenterArtworkContext


- (void)setArtworkData:(NSData *)data {

	%orig;
	[NSNotificationCenter.defaultCenter postNotificationName:@"kleiUpdateColors" object:nil];

}


%end


%hook SPTNowPlayingBackgroundViewController


%new

- (void)setColors { // get artwork colors

	loadPrefs();

	MRMediaRemoteGetNowPlayingInfo(dispatch_get_main_queue(), ^(CFDictionaryRef information) {

		NSDictionary *dict = (__bridge NSDictionary *)information;

		if(dict) {
            
			CATransition *transition = [CATransition animation];
			transition.type = kCATransitionFade;
			transition.duration = 1.0f;
			transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

			[gradient addAnimation:transition forKey:nil];
			[headUnitView.rewindButton.layer addAnimation:transition forKey:nil];
			[headUnitView.playPauseButton.layer addAnimation:transition forKey:nil];
			[headUnitView.skipButton.layer addAnimation:transition forKey:nil];

			NSData *artworkData = [dict objectForKey:(__bridge NSString *)kMRMediaRemoteNowPlayingInfoArtworkData];

			if(artworkData != nil) {

				UIImage *artwork = [UIImage imageWithData: artworkData];
				BOOL dont = NO;

				if(artworkData.length == 0x282e && artwork.size.width == 0x258) {

					if(!cachedPrimaryColors) cachedPrimaryColors = [libKitten primaryColor:artwork];
					if(!cachedSecondaryColors) cachedSecondaryColors = [libKitten secondaryColor:artwork];
					if(!cachedBackgroundColors) cachedBackgroundColors = [libKitten backgroundColor:artwork];

					dont = YES;

				}

				UIColor *primaryColor = dont ? cachedPrimaryColors : [libKitten primaryColor:artwork];
				UIColor *secondaryColor = dont ? cachedSecondaryColors : [libKitten secondaryColor:artwork];
				UIColor *backgroundColor = dont ? cachedBackgroundColors : [libKitten backgroundColor:artwork];

				gradient.colors = @[(id)backgroundColor.CGColor, (id)primaryColor.CGColor];

				if(enableArtworkBasedColors) {
					headUnitView.rewindButton.tintColor = secondaryColor;
					headUnitView.playPauseButton.tintColor = secondaryColor;
					headUnitView.skipButton.tintColor = secondaryColor;
				}

			}

		} else {

			cachedPrimaryColors = nil;
			cachedSecondaryColors = nil;
			cachedBackgroundColors = nil;

			gradient.colors = nil;
			headUnitView.rewindButton.tintColor = UIColor.whiteColor;
			headUnitView.playPauseButton.tintColor = UIColor.whiteColor;
			headUnitView.skipButton.tintColor = UIColor.whiteColor;

		}

	});

}


- (void)viewDidLoad { // add gradient, Litten's Klei gradients, thank you

	%orig;
	if(!enableKleiColors) return;

	NSArray *gradientColors = @[(id)UIColor.clearColor.CGColor, (id)UIColor.clearColor.CGColor];

	if(gradient) return;

	gradient = [CAGradientLayer layer];
	gradient.frame = self.view.bounds;
	gradient.colors = gradientColors;
	gradient.locations = @[@(-0.5), @(1.5)];
	gradient.startPoint = CGPointMake(0.0, 0.5);
	gradient.endPoint = CGPointMake(0.5, 1.0);
	[self.view.layer insertSublayer:gradient atIndex:0];

	[self setColors];

	// add notification observer to dynamically change artwork
	[NSNotificationCenter.defaultCenter removeObserver:self name:@"kleiUpdateColors" object:nil];
	[NSNotificationCenter.defaultCenter addObserver:self selector:@selector(setColors) name:@"kleiUpdateColors" object:nil];

}


%end


%hook SPTNowPlayingBackgroundViewController


- (UIColor *)color { // OLED view to now playing UI or custom colors

	if(!enableNowPlayingUIBGColor) return %orig;
	return [GcColorPickerUtils colorWithHex: nowPlayingUIBGColor];

}    


%end


/*****************************/
// ! | Miscellaneous Settings |
/*****************************/


%hook RootSettingsViewController


- (BOOL)isPlayingRemotely {

	if(!spoofIsPlayingRemotely) return %orig;
	return NO;

}


%end

%hook GLUEGradientView


- (void)didMoveToWindow { // OLED Spotify

	%orig;
	if(oledSpotify) self.alpha = 0;

}


%end


%hook SPTHomeView


- (void)didMoveToWindow {

	%orig;
	if(oledSpotify) self.backgroundColor = UIColor.blackColor;

}


%end


%hook SPTHomeGradientBackgroundView


- (void)didMoveToWindow {

	%orig;
	if(oledSpotify) self.backgroundColor = UIColor.blackColor;

}


%end


%hook ShortcutPlaylistButton


- (void)didMoveToWindow {

	%orig;
	if(!oledSpotify) return;

	for(UIView *shorcutView in [self subviews])

		if([shorcutView isKindOfClass:UIView.class]) shorcutView.backgroundColor = UIColor.blackColor;

}


%end


%hook SPTNowPlayingBarViewController


- (void)viewDidLoad { // OLED mini now playing bar

	%orig;
	if(!oledSpotify) return;

	self.contentView.backgroundColor = UIColor.blackColor;

}


%end


%hook SPTBarGradientView


- (void)didMoveToWindow {

	%orig;
	if(oledSpotify) self.hidden = YES;

}


%end


%hook UITabBar


- (void)didMoveToWindow {

	%orig;
	if(!oledSpotify) return;

	UITabBarAppearance *tabBar = [UITabBarAppearance new];
	tabBar.backgroundColor = UIColor.blackColor;
	self.standardAppearance = tabBar;

}


%end


%hook GLUEEmptyStateView


- (void)didMoveToWindow { // OLED Search page (when you tap on search)

	%orig;
	if(oledSpotify) self.backgroundColor = UIColor.blackColor;

}


%end


%hook SPTSearch2ViewController


- (void)viewDidLoad { // OLED Search page (with history)

	%orig;
	if(oledSpotify) self.view.backgroundColor = UIColor.blackColor;

}


%end


%hook SPTUIBlurView


- (void)didMoveToWindow {

	%orig;
	if(!oledSpotify) return;

	self.backgroundColor = UIColor.blackColor;
	for(UIVisualEffectView *effectView in self.subviews) [effectView removeFromSuperview];

}


%end


%hook UITabBarButtonLabel


- (void)setText:(NSString *)text { // Hide Tab Bar button's labels

	if(!hideTabBarLabels) return %orig;

}


%end


%hook ConnectButton


- (void)didMoveToWindow { // Connect Button in main page

	%orig;
	if(hideConnectButton) [self setHidden: YES];

}


%end


%hook SPTSearchUISearchControls


- (void)didMoveToWindow { // Hide Cancel Button in search page

	%orig;
	if(hideCancelButton) MSHookIvar<UIButton *>(self, "_cancelButton").hidden = YES;

}


%end


%hook PlayWhatYouLoveText


- (void)didMoveToWindow { // Hide "Play what you love text" string

	%orig;
	if(hidePlayWhatYouLoveText) [self setHidden: YES];

}


%end


%hook ClearRecentSearchesButton


- (void)didMoveToWindow { // Hide Clear Recent Searches Button

	%orig;
	if(hideClearRecentSearchesButton) [self setHidden: YES];

}


%end


%hook PlaylistsController


- (void)freeTierPlaylistModel:(id)arg1 playlistModelEntityDidChange:(id)arg2 { // save an instance of PlaylistsController

	%orig;
	playlistController = self;

}


%end


%hook SPTEncoreLabel


- (void)setText:(NSString *)text { // smh, hooking the source of this didn't work for some reason, so the view it is :deadAf:

	%orig;
	if(!showSongCount) return;

	UIViewController *ancestor = [self _viewControllerForAncestor];
	if(![ancestor isKindOfClass:%c(SPTFreeTierPlaylistEncoreHeaderViewController)]) return;

	NSUInteger totalCount = [playlistController numberOfItems];

	if(([self.text containsString:@"h"]
		|| [self.text containsString:@"m"])
		&& ![self.text containsString:@"Enhance"])

		%orig([NSString stringWithFormat:@"%@, %lu songs", text, totalCount]);

}


%end


%hook SPTFreeTierPlaylistEncoreHeaderControllerImplementation


- (BOOL)isEnhanceable { // Hide Enhance Button

	if(!hideEnhanceButton) return %orig;
	return NO;

}


%end


%hook SPTFreeTierPlaylistAdditionalCallToActionAddSongsImplementation


- (BOOL)enabled { // Hide "Add Songs" button in playlist

	if(!hideAddSongsButton) return %orig;
	return NO;

}


%end


%hook SPTProgressView


+ (void)showGaiaContextMenuProgressViewWithTitle:(id)arg1 { // No Pop-Up when queuing

	if(!hideQueuePopUp) return %orig;

}


%end


%hook SPTSnackbarView


- (id)initWithContentView:(id)arg1 { // No Pop-Up when liking songs

	if(!noPopUp) return %orig;
	return nil;

}


%end


%hook SPTSignupParameterShufflerImplementation


- (id)createShuffledKeyListFromParameters:(id)arg1 { // True Shuffle (experimental)

	if(!trueShuffle) return %orig;
	return nil;

}


%end


%hook SPTSignupParameterShufflerImplementation


- (id)shuffleEntriesFromQueryParameters:(id)arg1 {

	if(!trueShuffle) return %orig;
	return nil;

}


%end


%hook SPTSignupParameterShufflerImplementation


- (id)createHashFromParameterValues:(id)arg1 {

	if(!trueShuffle) return %orig;
	return nil;

}


%end


%hook SPTSignupParameterShufflerImplementation


- (id)md5FromString:(id)arg1 {

	if(!trueShuffle) return %orig;
	return nil;

}


%end


%hook SPTSignupParameterShufflerEntry


- (id)initWithKey:(id)arg1 value:(id)arg2 {

	if(!trueShuffle) return %orig;
	return nil;

}


- (void)updateIndex:(NSInteger)arg1 andSecret:(id)arg2 {

	if(!trueShuffle) return %orig;

}


- (NSInteger)compareKey:(id)arg1 {

	if(!trueShuffle) return %orig;
	return -100;

}


- (NSInteger)compareUsingSecretAndThenIndex:(id)arg1 {

	if(!trueShuffle) return %orig;
	return -100;

}


- (id)key {

	if(!trueShuffle) return %orig;
	return nil;

}


- (void)setKey:(id)arg1 {

	if(!trueShuffle) return %orig;

}


- (id)value {

	if(!trueShuffle) return %orig;
	return nil;

}


- (void)setValue:(id)arg1 {

	if(!trueShuffle) return %orig;

}


- (id)secret {

	if(!trueShuffle) return %orig;
	return nil;

}



- (void)setSecret:(id)arg1 {

	if(!trueShuffle) return %orig;

}


- (NSInteger)index {

	if(!trueShuffle) return %orig;
	return 0;

}


- (void)setIndex:(NSInteger)arg1 {

	if(!trueShuffle) return %orig;

}


%end


%hook SPTStatusBarManager


- (void)setStatusBarHiddenImmediate:(BOOL)arg1 withAnimation:(NSInteger)arg2 { // Show Status Bar

	if(!showStatusBar) return %orig;
	%orig(NO, arg2);

}


%end


%hook SPTStorylinesEnabledManager


- (BOOL)storylinesEnabledForTrack:(id)arg1 { // Disable Storylines

	if(!disableStorylines) return %orig;
	return NO;

}


%end


%hook SPTLyricsV2TestManagerImplementation


- (BOOL)isFeatureEnabled { // Lyrics for all tracks

	if(!enableLyricsForAllTracks) return %orig;
	return YES;

}


%end


%hook SPTLyricsV2Service


- (BOOL)lyricsAvailableForTrack:(id)arg1 {

	if(!enableLyricsForAllTracks) return %orig;
	return YES;

}


%end


%hook SPTGeniusService


- (BOOL)isTrackGeniusEnabled:(id)arg1 { // Disable Genius Lyrics

	if(!disableGeniusLyrics) return %orig;
	return NO;

}


%end


/*********************/
// ! | Now Playing UI |
/*********************/

%hook SPTNowPlayingTitleButton


- (void)didMoveToWindow { // Hide Close Button

	%orig;
	if(hideCloseButton) self.hidden = YES;

}


%end


%hook SPTNowPlayingNavigationBarViewV2


- (void)didMoveToWindow { // Hide Playlist Title

	%orig;
	if(hidePlaylistNameText) MSHookIvar<SPTNowPlayingMarqueeLabel *>(self, "_titleLabel").hidden = YES;

}


%end


%hook SPTContextMenuAccessoryButton


- (void)didMoveToWindow { // Hide Context Menu Button

	%orig;
	if(hideContextMenuButton) self.hidden = YES;

}


%end


%hook SPTNowPlayingHeartButtonViewController


- (id)initWithModel:(id)arg1 auxiliaryActionsHandler:(id)arg2 testManager:(id)arg3 { // Hide Like Button

	if(!hideLikeButton) return %orig;
	return nil;

}


%end


%hook _UISlideriOSVisualElement


- (void)setAlpha:(double)arg1 { // Hide Knob View

	if(hideSliderKnob) MSHookIvar<UIImageView *>(self, "_thumbView").alpha = 0;
	else %orig;

}


%end


%hook SPTNowPlayingSliderV2


- (void)didMoveToWindow { // Hide Time Slider

	%orig;
	if(hideTimeSlider) self.hidden = YES;

}


%end


%hook SPTNowPlayingDurationViewV2


- (void)didMoveToWindow { // Hide elapsed and remaining time labels

	if(hideElapsedTime) MSHookIvar<UILabel *>(self, "_timeTakenLabel").hidden = YES; 
	if(hideRemainingTime) MSHookIvar<UILabel *>(self, "_timeRemainingLabel").hidden = YES; 
	else %orig;

}


%end


%hook SPTNowPlayingShuffleButtonViewController


- (void)setShuffleButton:(id)arg1 { // Hide Shuffle Button

	if(!hideShuffleButton) return %orig;

}


%end


%hook PlayButton


- (void)setAlpha:(double)arg1 { // Hide Play/Pause Button

	if(hidePlayPauseButton) %orig(0);
	else %orig;

}


%end


%hook SPTNowPlayingRepeatButtonViewController


- (void)setRepeatButton:(id)arg1 { // Hide Repeat Button

	if(!hideRepeatButton) return %orig;

}


%end


%hook SPTNowPlayingConnectButtonViewController


- (id)initWithAuxiliaryActionsHandler:(id)arg1 connectIntegration:(id)arg2 theme:(id)arg3 { // Hide Devices Button

	if(!hideDevicesButton) return %orig;
	return nil;

}


%end


%hook SPTNowPlayingBanButtonViewController


- (id)initWithModel:(id)arg1
	auxiliaryActionsHandler:(id)arg2
	testManager:(id)arg3
	theme:(id)arg4 { // Hide Feedback Button

	if(!hideFeedbackButton) return %orig;
	return nil;

}


%end


%hook SPTNowPlayingShareButtonViewController


- (id)initWithAuxiliaryActionsHandler:(id)arg1 shareButtonFactory:(id)arg2 { // Hide Share Button

	if(!hideShareButton) return %orig;
	return nil;

}


%end


%hook SPTNowPlayingQueueButtonViewController


- (id)initWithAuxiliaryActionsHandler:(id)arg1 queueButtonFactory:(id)arg2 { // Hide Queue Button

	if(!hideQueueButton) return %orig;
	return nil;

}


%end


%hook SPTNowPlayingSkipPreviousButtonViewController


- (void)setPreviousButton:(id)arg1 {

	if(!hideBackButton && !hidePreviousTrackButton) return %orig;

}


%end


%hook SPTNowPlayingSkipNextButtonViewController


- (void)setNextButton:(id)arg1 {

	if(!hideForwardButton && !hideNextTrackButton) return %orig;

}


%end


%hook SPTNowPlayingSleepTimerButtonViewController


- (void)setSleepTimerButton:(id)arg1 {

	if(!hideMoonButton) return %orig;

}


%end


/******************/
// ! | ++ Features |
/******************/

%hook SPTNowPlayingHeadUnitView


%property (nonatomic, strong) UIButton *rewindButton;
%property (nonatomic, strong) UIButton *skipButton;
%property (nonatomic, strong) UIButton *playPauseButton;
%property (nonatomic, strong) UIStackView *buttonsStackView;


- (id)initWithFrame:(CGRect)frame { // get an instance of SPTNowPlayingHeadUnitView

	id orig = %orig;

	headUnitView = self;
	if(enableSpotifyUI) [self setupSpotifyUI];

	return orig;

}


%new

- (void)setupSpotifyUI {

	loadPrefs();

	UIImage *rewindButtonImage = [[UIImage systemImageNamed:@"backward.fill"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
	UIImage *skipButtonImage = [[UIImage systemImageNamed:@"forward.fill"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

	self.buttonsStackView = [UIStackView new];
	self.buttonsStackView.axis = UILayoutConstraintAxisHorizontal;
	self.buttonsStackView.spacing = 10;
	self.buttonsStackView.alignment = UIStackViewAlignmentCenter;
	self.buttonsStackView.distribution = UIStackViewDistributionFill;
	self.buttonsStackView.translatesAutoresizingMaskIntoConstraints = NO;
	[self addSubview:self.buttonsStackView];

	self.rewindButton = [self createButtonWithImage:rewindButtonImage forSelector:@selector(didTapRewindButton)];
	self.playPauseButton = [self createButtonWithImage:nil forSelector:@selector(didTapPlayPauseButton)];
	self.skipButton = [self createButtonWithImage:skipButtonImage forSelector:@selector(didTapSkipButton)];

	[self.playPauseButton setPreferredSymbolConfiguration:[UIImageSymbolConfiguration configurationWithPointSize:35] forImageInState:UIControlStateNormal];
	[self setupSpotifyUIConstraints];

}


%new

- (void)setupSpotifyUIConstraints {

	[self.buttonsStackView.centerXAnchor constraintEqualToAnchor: self.centerXAnchor].active = YES;
	[self.buttonsStackView.centerYAnchor constraintEqualToAnchor: self.centerYAnchor].active = YES;
	[self.buttonsStackView.heightAnchor constraintEqualToConstant: 100].active = YES;
	[self setupSizeConstraintsForButton: self.rewindButton];
	[self setupSizeConstraintsForButton: self.skipButton];

}


%new

- (void)didTapRewindButton {

	[self sendMRCommandAndTriggerHapticsIfRequested: kMRPreviousTrack];

}


%new

- (void)didTapPlayPauseButton {

	[self sendMRCommandAndTriggerHapticsIfRequested: kMRTogglePlayPause];

}


%new

- (void)didTapSkipButton {

	[self sendMRCommandAndTriggerHapticsIfRequested: kMRNextTrack];

}


%new

- (void)sendMRCommandAndTriggerHapticsIfRequested:(MRCommand)command {

	MRMediaRemoteSendCommand(command, nil);
	if(!enableHaptics) return;

	switch(hapticsStrength) {
		case 0: AudioServicesPlaySystemSound(1519); break;
		case 1: AudioServicesPlaySystemSound(1520); break;
		case 2: AudioServicesPlaySystemSound(1521); break;
	}

}


%new

- (UIButton *)createButtonWithImage:(UIImage *_Nullable)image forSelector:(SEL)selector {

	UIButton *button = [UIButton new];
	if(!enableArtworkBasedColors) button.tintColor = UIColor.whiteColor;
	button.adjustsImageWhenHighlighted = NO;
	button.translatesAutoresizingMaskIntoConstraints = NO;
	[button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
	[button setImage:image forState:UIControlStateNormal];
	[self.buttonsStackView addArrangedSubview: button];
	return button;

}


%new

- (void)setupSizeConstraintsForButton:(UIButton *)button {

	[button.widthAnchor constraintEqualToConstant: 100].active = YES;
	[button.heightAnchor constraintEqualToConstant: 90].active = YES;

}


%end


%hook SPTPlayerState


- (BOOL)isPaused {

	if(!enableSpotifyUI) return %orig;

	UIImage *playButtonImage = [[UIImage systemImageNamed:@"play.fill"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
	UIImage *pauseButtonImage = [[UIImage systemImageNamed:@"pause.fill"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

	BOOL value = %orig;

	dispatch_async(dispatch_get_main_queue(), ^{

		[UIView transitionWithView:headUnitView.playPauseButton duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{

			if(value) [headUnitView.playPauseButton setImage:playButtonImage forState:UIControlStateNormal];
			else [headUnitView.playPauseButton setImage:pauseButtonImage forState:UIControlStateNormal];

		} completion:nil];

	});

	return value;

}


%end


%hook SPTNowPlayingViewController


- (void)viewDidLoad { // add gesture to save canvas

	%orig;
	if(!saveCanvas) return;

	canvasContentLayerVC = self;

	UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didDoubleTapCanvas)];
	doubleTap.numberOfTapsRequired = 2;
	[self.view addGestureRecognizer:doubleTap];

}


static void setupAlertControllerWithMessageAndURLString(NSString *messageString, NSString *urlString) {

	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"PerfectSpotify" message:messageString preferredStyle:UIAlertControllerStyleAlert];
	UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {

		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.005 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
			[UIApplication.sharedApplication _openURL: [NSURL URLWithString: urlString]];
		});

	}];

	UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Not now" style:UIAlertActionStyleCancel handler:nil];

	[alertController addAction:confirmAction];
	[alertController addAction:cancelAction];

	[canvasContentLayerVC presentViewController:alertController animated:YES completion:nil];

}

static void saveToFilzaAlertController() {

	NSFileManager *fileM = [NSFileManager defaultManager];
	NSString *documentsPath = [[fileM URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject].URLByDeletingLastPathComponent.path;

	NSString *pathInFilza = [@"filza://view" stringByAppendingString: documentsPath];
	NSString *completePath = [[pathInFilza stringByAppendingString:@"/Documents/Canvas/"] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];

	setupAlertControllerWithMessageAndURLString(
		@"Canvas downloaded succesfully. Do you want to view it in Filza?",
		completePath
	);

}

static void saveToGalleryAlertController() {

	setupAlertControllerWithMessageAndURLString(
		@"Canvas downloaded succesfully. Do you want to open gallery?",
		@"photos-redirect://"
	);

}

static void getCanvas() {

	NSFileManager *fileM = [NSFileManager defaultManager];

	NSString *documentsPath = [[fileM URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject].URLByDeletingLastPathComponent.path;
	NSString *completePath = [documentsPath stringByAppendingPathComponent:@"/Library/Caches/Canvases/"];	
	NSString *newPath = [documentsPath stringByAppendingPathComponent:@"/Documents/Canvas/"];
	NSString *canvasDirectory = [documentsPath stringByAppendingPathComponent:@"/Documents/Canvas/"];

	NSError *error;
	NSError *dirError;

	NSDirectoryEnumerator *directoryEnumerator = [fileM enumeratorAtPath:completePath];
	NSDate *lastDate = [NSDate dateWithTimeIntervalSinceNow:-300]; // check for the canvas cached within the last 5 minutes

	for(NSString *path in directoryEnumerator) {

		NSDictionary *attributes = [directoryEnumerator fileAttributes];
		NSDate *lastModificationDate = [attributes objectForKey:NSFileModificationDate];

		if([lastDate earlierDate:lastModificationDate] == lastDate) {

			// NSLog(@"PSS:%@ was modified within the last 5 minutes", path);

			switch(saveCanvasDestination) {

				case 0:

					BOOL isDir;

					if(![fileM fileExistsAtPath:canvasDirectory isDirectory:&isDir])
						[fileM createDirectoryAtPath:canvasDirectory withIntermediateDirectories:NO attributes:nil error:&dirError];

					[fileM copyItemAtPath:[completePath stringByAppendingPathComponent:path] toPath:[newPath stringByAppendingPathComponent:path] error:&error];

					if(error) {
						SPTPopupDialog *notSoProudPopup = [%c(SPTPopupDialog) popupWithTitle:@"PerfectSpotify" message:@"Oops, looks like there was an errow downloading this canvas, most likely because you already downloaded it. Otherwise try retrying." dismissButtonTitle:@"Got it"];
						[[%c(SPTPopupManager) sharedManager].presentationQueue addObject:notSoProudPopup];
						[[%c(SPTPopupManager) sharedManager] presentNextQueuedPopup];
						// NSLog(@"PS:Your dumb af code caused this error %@", error);
						return;
					}

					saveToFilzaAlertController();
					break;

				case 1:

					UISaveVideoAtPathToSavedPhotosAlbum([completePath stringByAppendingPathComponent:path], canvasContentLayerVC, nil, nil);
					saveToGalleryAlertController();
					break;

			}

		}

	}

}


%new

- (void)didDoubleTapCanvas {

	getCanvas();

}


%end
%end


/******************/
// ! | SpringBoard |
/******************/

%group PSpotifySpringBoard


static void launchPSpotify() {

	NSString *urlString = kOrionExists || kShuffleExists ? @"prefs:root=Tweaks&path=PerfectSpotify" : @"prefs:root=PerfectSpotify";
	[UIApplication.sharedApplication _openURL: [NSURL URLWithString: urlString]];

}


%hook SBIconView


- (void)setApplicationShortcutItems:(NSArray *)items {

	loadPrefs();

	if(![self.icon.applicationBundleID isEqualToString:@"com.spotify.client"]) return %orig;

	NSString *editHSShortcutString = @"com.apple.springboardhome.application-shortcut-item.rearrange-icons";
	NSString *shareAppShortcutString = @"com.apple.springboardhome.application-shortcut-item.share";
	NSString *removeAppShortcutString = @"com.apple.springboardhome.application-shortcut-item.remove-app";

	NSString *sptSearchShortcutString = @"com.spotify.shortcutItem.search";
	NSString *sptRecentlyPlayedShortcutString = @"com.spotify.shortcutItem.recentlyplayed";

	NSMutableArray *shortcutsArray = [items mutableCopy];

	for(SBSApplicationShortcutItem *shortcutItem in items) {

		if(!self.icon.isApplicationIcon) return;

		if([shortcutItem.type isEqualToString:editHSShortcutString]) {

			if(removeEditHSShortcut) [shortcutsArray removeObject:shortcutItem];

		}

		else if([shortcutItem.type isEqualToString:shareAppShortcutString]) {

			if(removeShareAppShortcut) [shortcutsArray removeObject:shortcutItem];

		}

		else if([shortcutItem.type isEqualToString:removeAppShortcutString]) {

			if(removeRemoveAppShortcut) [shortcutsArray removeObject:shortcutItem];

		}

		else if([shortcutItem.type isEqualToString:sptSearchShortcutString]) {

			if(removeSpotifySearchShortcut) [shortcutsArray removeObject:shortcutItem];

		}

		else if([shortcutItem.type isEqualToString:sptRecentlyPlayedShortcutString]) {

			if(removeSpotifyRecentlyPlayedShortcut) [shortcutsArray removeObject:shortcutItem];

		}

	}

	if(addPSpotifyShortcut) {

		UIImage *image = [UIImage systemImageNamed:@"music.quarternote.3"];

		SBSApplicationShortcutItem *PSpotify = [%c(SBSApplicationShortcutItem) new];
		PSpotify.icon = [[%c(SBSApplicationShortcutCustomImageIcon) alloc] initWithImageData:UIImagePNGRepresentation(image) dataType:0 isTemplate:1];
		PSpotify.type = @"me.luki.pspotify.item";
		PSpotify.localizedTitle = [NSString stringWithFormat:@"PSpotify"];

		[shortcutsArray addObject:PSpotify];

	}

	%orig(shortcutsArray);

}


+ (void)activateShortcut:(SBSApplicationShortcutItem *)item
	withBundleIdentifier:(NSString *)bundleID
	forIconView:(id)iconView {

	if(![item.type isEqualToString:@"me.luki.pspotify.item"]) return %orig;

	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.001 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
		launchPSpotify();
	});

}


- (void)didMoveToSuperview {

	%orig;

	[NSNotificationCenter.defaultCenter removeObserver:self];
	[NSNotificationCenter.defaultCenter addObserver:self selector:@selector(setApplicationShortcutItems:) name:@"updateShortcutItems" object:nil];

}


%end
%end


%ctor {

	loadPrefs();
	%init(PSpotifySpringBoard);

	if(!kIsCurrentApp(@"com.apple.springboard"))

		%init(PerfectSpotify,
			ConnectButton=kClass(@"ConnectUIFeatureImpl.ConnectButtonView"),
			ClearRecentSearchesButton=kClass(@"SPTTing.ChipView"),
			PlayWhatYouLoveText=kClass(@"SPTTing.EmptyState"),
			PlayButton=kClass(@"EncoreConsumerMobile.PlayButtonView"),
			PlaylistsController=kClass(@"PlaylistUXPlatform_PlaylistMigrationImpl.PLItemsViewModelImplementation"),
			ShortcutPlaylistButton=kClass(@"EncoreMobile.InteractableLayoutBackingButton")
		);

}
