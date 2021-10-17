#import "PerfectSpotify.h"


// Colors


%group PerfectSpotify


%hook MPNowPlayingInfoCenterArtworkContext


- (void)setArtworkData:(NSData *)arg1 {


	%orig;

	artworkData = arg1;

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
            
			CATransition *transitionKleiView = [CATransition animation];
			transitionKleiView.type = kCATransitionFade;
			transitionKleiView.duration = 1.0f;
			transitionKleiView.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

			[gradient addAnimation:transitionKleiView forKey:nil];

			CATransition *transitionRewindButton = [CATransition animation];
			transitionRewindButton.type = kCATransitionFade;
			transitionRewindButton.duration = 1.0f;
			transitionRewindButton.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

			[headUnitView.rewindButton.layer addAnimation:transitionRewindButton forKey:nil];

			CATransition *transitionPlayPauseButton = [CATransition animation];
			transitionPlayPauseButton.type = kCATransitionFade;
			transitionPlayPauseButton.duration = 1.0f;
			transitionPlayPauseButton.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

			[headUnitView.playPauseButton.layer addAnimation:transitionPlayPauseButton forKey:nil];

			CATransition *transitionSkipButtoon = [CATransition animation];
			transitionSkipButtoon.type = kCATransitionFade;
			transitionSkipButtoon.duration = 1.0f;
			transitionSkipButtoon.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

			[headUnitView.skipButton.layer addAnimation:transitionSkipButtoon forKey:nil];

			if(dict[(__bridge NSString *)kMRMediaRemoteNowPlayingInfoArtworkData]) {

				UIImage *currentArtwork = [UIImage imageWithData:[dict objectForKey:(__bridge NSString*)kMRMediaRemoteNowPlayingInfoArtworkData]];

				if(currentArtwork != nil) {

					gradient.colors = [NSArray arrayWithObjects:(id)[libKitten backgroundColor:currentArtwork].CGColor, (id)[libKitten primaryColor:currentArtwork].CGColor, nil];

					if(enableArtworkBasedColors) {

						headUnitView.rewindButton.tintColor = [libKitten secondaryColor:currentArtwork];
						headUnitView.playPauseButton.tintColor = [libKitten secondaryColor:currentArtwork];
						headUnitView.skipButton.tintColor = [libKitten secondaryColor:currentArtwork];

					}

				}

			}

		} else {

			gradient.colors = [NSArray arrayWithObjects:(id)UIColor.clearColor.CGColor, (id)UIColor.clearColor.CGColor, nil];
			headUnitView.rewindButton.tintColor = UIColor.whiteColor;
			headUnitView.playPauseButton.tintColor = UIColor.whiteColor;
			headUnitView.skipButton.tintColor = UIColor.whiteColor;

		}

	});

}


- (void)viewDidLoad { // add gradient, Litten's Klei gradients, thank you


	%orig;

	[self setColors];

	if(gradientColors) {

		if(!gradient) {

			gradient = [CAGradientLayer layer];
			gradient.frame = self.view.bounds;
			gradient.colors = [NSArray arrayWithObjects:(id)UIColor.clearColor.CGColor, (id)UIColor.clearColor.CGColor, nil];
			gradient.locations = [NSArray arrayWithObjects:@(-0.5), @(1.5), nil];
			gradient.startPoint = CGPointMake(0.0, 0.5);
			gradient.endPoint = CGPointMake(0.5, 1.0);
			[self.view.layer insertSublayer:gradient atIndex:0];

		}

	}

	[NSNotificationCenter.defaultCenter removeObserver:self];
	[NSNotificationCenter.defaultCenter addObserver:self selector:@selector(setColors) name:@"kleiUpdateColors" object:nil]; // add notification observer to dynamically change artwork

}


%end




%hook UILabel


- (void)setTextColor:(UIColor *)arg1 { // Custom Tint Text Color


	if(enableTextColor) %orig([GcColorPickerUtils colorWithHex:tintTextColor]);

	else %orig;


}


%end




%hook GLUELabelStyle


- (void)setTextColor:(id)arg1 {


	if(enableTextColor) %orig([GcColorPickerUtils colorWithHex:tintTextColor]);

	else %orig;


}


%end




%hook SPTNowPlayingBarPageView


- (void)didMoveToWindow { // Tinted Labels on tab bar player


	%orig;

	if(enableTextColor) {

		MSHookIvar<SPTNowPlayingMarqueeLabel *>(self, "_topLabel").textColor = [GcColorPickerUtils colorWithHex:tintTextColor];
		MSHookIvar<SPTNowPlayingMarqueeLabel *>(self, "_bottomLabel").textColor = [GcColorPickerUtils colorWithHex:tintTextColor];

	}

}


%end




%hook UIImageView


- (void)didMoveToWindow {


	%orig;

	if(enableTintColor) self.tintColor = [GcColorPickerUtils colorWithHex:tintColor];


}


%end




%hook SPTIconConfiguration


- (id)iconColor { // Tint Color


	if(enableTintColor) return [GcColorPickerUtils colorWithHex:tintColor];

	return %orig;


}


%end




%hook SPTNowPlayingPlayButtonV2


- (id)fillColor {


	if(enableTintColor) return [GcColorPickerUtils colorWithHex:tintColor];

	return %orig;


}


%end




%hook SPTNowPlayingBackgroundViewController


- (id)color { // OLED view to now playing UI or custom colors


	if(enableBackgroundUIColor) return [GcColorPickerUtils colorWithHex:backgroundUIColor];

	else return %orig;


}    


%end




%hook SPTGaiaDevicesAvailableViewModel


- (void)setColor:(id)arg1 { // Tint color for the devices button


	if(enableTintColor) %orig([GcColorPickerUtils colorWithHex:tintColor]);

	else %orig;


}


%end




// Miscellaneous Settings


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




%hook HUGSCustomViewControl


- (void)didMoveToWindow {


	%orig;

	if(oledSpotify) self.contentView.backgroundColor = UIColor.blackColor;


}


%end




%hook SPTNowPlayingBarViewController


- (void)viewDidLoad { // OLED tab bar


	%orig;

	if(oledSpotify) MSHookIvar<UIView *>(self, "_contentView").backgroundColor = UIColor.blackColor;  


}


%end




%hook SPTBarGradientView


- (void)didMoveToWindow {


	%orig;

	if(oledSpotify) self.hidden = YES;


}


%end




%hook UIView


- (void)didMoveToWindow { // well fuck


	%orig;

	UIViewController *ancestor = [self _viewControllerForAncestor];

	if(oledSpotify)

		if([ancestor isKindOfClass:%c(SPTNowPlayingBarV2ViewController)])

			self.backgroundColor = UIColor.blackColor;


}


%end




%hook UITabBar


- (void)didMoveToWindow {


	%orig;

	if(oledSpotify) {

		UITabBarAppearance *tabBar = [UITabBarAppearance new];
		tabBar.backgroundColor = UIColor.blackColor;
		self.standardAppearance = tabBar;

	}

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

	if(oledSpotify) self.view.backgroundColor = [UIColor blackColor];


}


%end




%hook _UIVisualEffectSubview


- (void)didMoveToWindow { // Blackout context menu


	%orig;

	if(oledSpotify) self.backgroundColor = UIColor.blackColor;


}


%end




%hook UITabBarButtonLabel


- (void)setText:(id)arg1 { // Hide Tab Bar button's labels


	%orig;

	if(hideTabBarLabels) %orig(nil);


}


%end




%hook ConnectButton


- (void)didMoveToWindow { // Connect Button in main page


	%orig;

	if(hideConnectButton) [self setHidden:YES];


}


%end




%hook SPTNowPlayingBarPlayButton


- (void)didMoveToWindow { // Hide Play Button (Tab Bar)


	%orig;

	if(hideTabBarPlayButton) self.hidden = YES;


}


%end




%hook SPTSearchUISearchControls


- (void)didMoveToWindow { // Hide Cancel Button in search page


	%orig;

	if(hideCancelButton) MSHookIvar<UIButton *>(self, "_cancelButton").hidden = YES;

}


%end




%hook PlayWhatYouLoveText


- (void)didMoveToWindow { // Hide the "Play what you love text"


	%orig;

	if(hidePlayWhatYouLoveText) [self setHidden:YES];


}


%end




%hook ClearRecentSearchesButton


- (void)didMoveToWindow { // Hide Clear Recent Searches Button


	%orig;

	if(hideClearRecentSearchesButton) [self setHidden:YES];


}


%end




%hook PlaylistsController


- (void)freeTierPlaylistModel:(id)arg1 playlistModelEntityDidChange:(id)arg2 { // save an instance of PlaylistsController

	%orig;

	playlistController = self;

}


%end




%hook SPTEncoreLabel


- (void)setText:(id)arg1 { // oh boy, there was no other way tho, show song count :bthishowitis:

	%orig;

	if(!showSongCount) return;

	UIViewController *ancestor = [self _viewControllerForAncestor];

	NSUInteger totalCount = [playlistController numberOfItems];

	if([ancestor isKindOfClass:%c(SPTFreeTierPlaylistEncoreHeaderViewController)])

		if((![self.text containsString:@"Enhance"]) && (![self.text containsString:@"+"]))

			if(([self.text containsString:@"h"]) || ([self.text containsString:@"min"]))

				%orig([NSString stringWithFormat:@"%@, %lu songs", arg1, (long)totalCount]);

}


%end




%hook SPTFreeTierPlaylistEncoreHeaderControllerImplementation


- (BOOL)isEnhanceable { // Hide Enhance Button

	if(hideEnhanceButton) return NO;

	else return %orig;

}


%end




%hook SPTFreeTierPlaylistAdditionalCallToActionAddSongsImplementation


- (BOOL)enabled { // Hide "Add Songs" button in playlist


	if(hideAddSongsButton) return NO;

	return %orig;


}


%end




%hook SPTProgressView


+ (void)showGaiaContextMenuProgressViewWithTitle:(id)arg1 { // Hide Queue Pop Up

	if(hideQueuePopUp) {}

	else %orig;

}


%end




%hook SPTSnackbarView


- (id)initWithContentView:(id)arg1 { // No Pop-Up when liking songs

	if(noPopUp) return nil;

	else return %orig;

}


%end




%hook SPTSignupParameterShufflerImplementation


- (id)createShuffledKeyListFromParameters:(id)arg1 { // True Shuffle (experimental)


	if(trueShuffle) return nil;
	
	return %orig;


}


%end




%hook SPTSignupParameterShufflerImplementation


- (id)shuffleEntriesFromQueryParameters:(id)arg1 {


	if(trueShuffle) return nil;

	return %orig;


}


%end




%hook SPTSignupParameterShufflerImplementation


- (id)createHashFromParameterValues:(id)arg1 {


	if(trueShuffle) return nil;

	return %orig;


}


%end




%hook SPTSignupParameterShufflerImplementation


- (id)md5FromString:(id)arg1 {

	
	if(trueShuffle) return nil;

	return %orig;


}


%end




%hook SPTSignupParameterShufflerEntry


- (id)initWithKey:(id)arg1 value:(id)arg2 {


	if(trueShuffle) %orig(nil, nil);

	return %orig;


}


- (void)updateIndex:(long long)arg1 andSecret:(id)arg2 {


	if(trueShuffle) %orig(0, nil);

	else %orig;


}



- (long long)compareKey:(id)arg1 {


	if(trueShuffle) %orig(nil);

	return %orig;


}



- (long long)compareUsingSecretAndThenIndex:(id)arg1 {


	if(trueShuffle) %orig(nil);

	return %orig;


}


- (id)key {


	if(trueShuffle) return nil;

	return %orig;


}


- (void)setKey:(id)arg1 {


	if(trueShuffle) %orig(nil);


}


- (id)value {


	if(trueShuffle) return nil;

	return %orig;


}



- (void)setValue:(id)arg1 {


	if(trueShuffle) %orig(nil);


}



- (id)secret {


	if(trueShuffle) return nil;

	return %orig;


}



- (void)setSecret:(id)arg1 {


	if(trueShuffle) %orig(nil);


}


- (long long)index {


	if(trueShuffle) return 0;

	return %orig;


}


- (void)setIndex:(long long)arg1 {


	if(trueShuffle) %orig(0);


}


%end




%hook SPTStatusBarManager


- (void)setStatusBarHiddenImmediate:(BOOL)arg1 withAnimation:(long long)arg2 { // Show Status Bar


	if(showStatusBar) arg1 = NO;

	else %orig;

}


%end




%hook SPTStorylinesEnabledManager


- (BOOL)storylinesEnabledForTrack:(id)arg1 { // Disable Storylines


	if(disableStorylines) return NO;

	return %orig;


}


%end




%hook SPTLyricsV2TestManagerImplementation


- (BOOL)isFeatureEnabled { // Lyrics for all tracks


	if(enableLyricsForAllTracks) return YES;

	return %orig;


}


%end




%hook SPTLyricsV2Service


- (BOOL)lyricsAvailableForTrack:(id)arg1 {


	if(enableLyricsForAllTracks) return YES;

	return %orig;


}


%end




%hook SPTGeniusService


- (bool)isTrackGeniusEnabled:(id)arg1 { // Disable Genius Lyrics


	if(disableGeniusLyrics) return NO;

	return %orig;


}


%end




%hook SPTNowPlayingFreeTierFeedbackButton


- (void)didMoveToWindow { // Hide Remove Button (Daily Mix)


	%orig;

	if(hideRemoveButton) self.hidden = YES;


}


%end




// Now Playing UI


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




%hook SPTNowPlayingAnimatedLikeButton


- (void)didMoveToWindow { // Hide Like Button


	%orig;

	if(hideLikeButton) self.hidden = YES;


}


%end




%hook SPTNowPlayingHeartButtonViewController


- (void)setHeartButton:(id)arg1 { // Hide Like Button 8.5.60 +


	if(hideLikeButton) %orig(nil);

	else %orig;


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


	if(hideShuffleButton) {}

	else %orig;


}


%end




%hook SPTNowPlayingPreviousTrackButton


- (void)didMoveToWindow { // Hide Previous Track Button (Legacy versions)


	%orig;

	if(hidePreviousTrackButton) self.hidden = YES;


}


%end




%hook PlayButton


- (void)setAlpha:(double)arg1 { // Hide Play/Pause Button


	%orig;

	if(hidePlayPauseButton) %orig(0);


}


%end




%hook SPTNowPlayingNextTrackButton


- (void)didMoveToWindow { // Hide Next Track Button (Legacy versions)


	%orig;

	if(hideNextTrackButton) self.hidden = YES;


}


%end




%hook SPTNowPlayingRepeatButtonViewController


- (void)setRepeatButton:(id)arg1 { // Hide Repeat Button


	if(hideRepeatButton) {}

	else %orig;


}


%end




%hook SPTGaiaDevicesAvailableViewImplementation


- (void)didMoveToWindow { // Hide Devices Button


	%orig;

	if(hideDevicesButton) self.hidden = YES;


}


%end




%hook SPTNowPlayingShareButtonViewController


- (id)initWithAuxiliaryActionsHandler:(id)arg1 {

	if(hideShareButton) return nil;

	else return %orig;

}


%end




%hook SPTNowPlayingQueueButton


- (void)didMoveToWindow { // Hide Queue Button


	%orig;

	if(hideQueueButton) self.hidden = YES;

}


%end




%hook SPTNowPlayingSkipPreviousButtonViewController


- (void)setPreviousButton:(id)arg1 {


	if(hideBackButton || hidePreviousTrackButton) {}

	else %orig;


}


%end




%hook SPTNowPlayingSkipNextButtonViewController


- (void)setNextButton:(id)arg1 {


	if(hideForwardButton || hideNextTrackButton) {}

	else %orig;


}


%end




%hook SPTNowPlayingSleepTimerButtonViewController


- (void)setSleepTimerButton:(id)arg1 {

	if(hideMoonButton) {}

	else %orig;

}


%end




// ++ Features


%hook SPTNowPlayingHeadUnitView


%property (nonatomic, strong) UIButton *rewindButton;
%property (nonatomic, strong) UIButton *skipButton;
%property (nonatomic, strong) UIButton *playPauseButton;


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
	UIImage *rewindButtonModernImage = [[UIImage imageWithContentsOfFile:@"/Library/Application Support/PSpotifyMusicControls/rewind-modern.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
	UIImage *skipButtonModernImage = [[UIImage imageWithContentsOfFile:@"/Library/Application Support/PSpotifyMusicControls/skip-modern.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

	self.rewindButton = [UIButton new];
	if(!enableArtworkBasedColors) self.rewindButton.tintColor = UIColor.whiteColor;
	self.rewindButton.adjustsImageWhenHighlighted = NO;
	[self.rewindButton addTarget : self action:@selector(rewind) forControlEvents:UIControlEventTouchUpInside];
	if(!enableModernButtons) [self.rewindButton setImage : rewindButtonImage forState:UIControlStateNormal];
	else [self.rewindButton setImage : rewindButtonModernImage forState:UIControlStateNormal];
	self.rewindButton.translatesAutoresizingMaskIntoConstraints = NO;
	[self addSubview:self.rewindButton];

	self.playPauseButton = [UIButton new];
	if(!enableArtworkBasedColors) self.playPauseButton.tintColor = UIColor.whiteColor;
	self.playPauseButton.adjustsImageWhenHighlighted = NO;
	[self.playPauseButton addTarget : self action:@selector(playPause) forControlEvents:UIControlEventTouchUpInside];
	[self.playPauseButton setPreferredSymbolConfiguration:[UIImageSymbolConfiguration configurationWithPointSize:35] forImageInState:UIControlStateNormal];
	self.playPauseButton.translatesAutoresizingMaskIntoConstraints = NO;
	[self addSubview:self.playPauseButton];

	self.skipButton = [UIButton new];
	if(!enableArtworkBasedColors) self.skipButton.tintColor = UIColor.whiteColor;
	self.skipButton.adjustsImageWhenHighlighted = NO;
	[self.skipButton addTarget : self action:@selector(skip) forControlEvents:UIControlEventTouchUpInside];
	if(!enableModernButtons) [self.skipButton setImage : skipButtonImage forState:UIControlStateNormal];
	else [self.skipButton setImage : skipButtonModernImage forState:UIControlStateNormal];
	self.skipButton.translatesAutoresizingMaskIntoConstraints = NO;
	[self addSubview:self.skipButton];

	[self setupSpotifyUIConstraints];
	[self setupSpotifyUIModernButtonsConstraints];

}


%new

- (void)setupSpotifyUIConstraints {

	if(enableModernButtons) return;

	[self.rewindButton.centerYAnchor constraintEqualToAnchor : self.centerYAnchor].active = YES;
	[self.rewindButton.trailingAnchor constraintEqualToAnchor : self.playPauseButton.leadingAnchor constant : 20].active = YES;
	[self.rewindButton.widthAnchor constraintEqualToConstant : 100].active = YES;
	[self.rewindButton.heightAnchor constraintEqualToConstant : 90].active = YES;

	[self.playPauseButton.centerXAnchor constraintEqualToAnchor : self.centerXAnchor].active = YES;
	[self.playPauseButton.centerYAnchor constraintEqualToAnchor : self.centerYAnchor].active = YES;

	[self.skipButton.centerYAnchor constraintEqualToAnchor : self.centerYAnchor].active = YES;
	[self.skipButton.leadingAnchor constraintEqualToAnchor : self.playPauseButton.trailingAnchor constant : -20].active = YES;
	[self.skipButton.widthAnchor constraintEqualToConstant : 100].active = YES;
	[self.skipButton.heightAnchor constraintEqualToConstant : 90].active = YES;

}


%new

- (void)setupSpotifyUIModernButtonsConstraints {

	if(!enableModernButtons) return;

	[self.rewindButton.centerYAnchor constraintEqualToAnchor : self.centerYAnchor].active = YES;
	[self.rewindButton.trailingAnchor constraintEqualToAnchor : self.playPauseButton.leadingAnchor constant : -20].active = YES;
	[self.rewindButton.widthAnchor constraintEqualToConstant : 30].active = YES;
	[self.rewindButton.heightAnchor constraintEqualToConstant : 20].active = YES;

	[self.playPauseButton.centerXAnchor constraintEqualToAnchor : self.centerXAnchor].active = YES;
	[self.playPauseButton.centerYAnchor constraintEqualToAnchor : self.centerYAnchor].active = YES;
	[self.playPauseButton.widthAnchor constraintEqualToConstant : 35].active = YES;
	[self.playPauseButton.heightAnchor constraintEqualToConstant : 35].active = YES;

	[self.skipButton.centerYAnchor constraintEqualToAnchor : self.centerYAnchor].active = YES;
	[self.skipButton.leadingAnchor constraintEqualToAnchor : self.playPauseButton.trailingAnchor constant : 20].active = YES;
	[self.skipButton.widthAnchor constraintEqualToConstant : 30].active = YES;
	[self.skipButton.heightAnchor constraintEqualToConstant : 20].active = YES;

}


%new

- (void)rewind {

	MRMediaRemoteSendCommand(kMRPreviousTrack, nil);
	if(enableHaptics) [self triggerHaptics];

}


%new

- (void)playPause {

	MRMediaRemoteSendCommand(kMRTogglePlayPause, nil);
	if(enableHaptics) [self triggerHaptics];

}


%new

- (void)skip {

	MRMediaRemoteSendCommand(kMRNextTrack, nil);
	if(enableHaptics) [self triggerHaptics];

}


%new

- (void)triggerHaptics {

	switch(hapticsStrength) {

		case 0:

			AudioServicesPlaySystemSound(1519);
			break;

		case 1:

			AudioServicesPlaySystemSound(1520);
			break;

		case 2:

			AudioServicesPlaySystemSound(1521);
			break;

	}

}


%end




%hook SPTPlayerState


- (BOOL)isPaused {

	if(!enableSpotifyUI) return %orig;

	UIImage *playButtonImage = [[UIImage systemImageNamed:@"play.fill"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
	UIImage *pauseButtonImage = [[UIImage systemImageNamed:@"pause.fill"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
	UIImage *playButtonModernImage = [[UIImage imageWithContentsOfFile:@"/Library/Application Support/PSpotifyMusicControls/play-modern.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
	UIImage *pauseButtonModernImage = [[UIImage imageWithContentsOfFile:@"/Library/Application Support/PSpotifyMusicControls/pause-modern.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

	BOOL value = %orig;

	[UIView transitionWithView:headUnitView.playPauseButton duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{

		if(value == YES) {

			if(!enableModernButtons) [headUnitView.playPauseButton setImage : playButtonImage forState:UIControlStateNormal];
			else [headUnitView.playPauseButton setImage : playButtonModernImage forState:UIControlStateNormal];

		}

		else {

			if(!enableModernButtons) [headUnitView.playPauseButton setImage : pauseButtonImage forState:UIControlStateNormal];
			else [headUnitView.playPauseButton setImage : pauseButtonModernImage forState:UIControlStateNormal];

		}

	} completion:nil];

	return value;

}


%end




%hook SPTCanvasContentLayerViewController


- (void)viewDidLoad { // add gesture to save canvas

	%orig;

	if(!saveCanvas) return;

	canvasContentLayerVC = self;

	UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
	doubleTap.numberOfTapsRequired = 2;
	[self.view addGestureRecognizer:doubleTap];

}


void saveToFilzaAlertController() {

	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"PerfectSpotify" message:@"Canvas downloaded succesfully. Do you want to view it in Filza?" preferredStyle:UIAlertControllerStyleAlert];

	UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {

		LSApplicationProxy *applicationProxy = [%c(LSApplicationProxy) applicationProxyForIdentifier:@"com.spotify.client"];

		NSString *pathInFilza = [@"filza://view" stringByAppendingString:applicationProxy.dataContainerURL.path];
		NSString *completePath = [pathInFilza stringByAppendingString:@"/Documents/Canvas/"];

		UIApplication *app = [UIApplication sharedApplication];

		NSURL *canvasURL = [NSURL URLWithString:[completePath stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];			

		[app _openURL:canvasURL];

	}];

	UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Not now" style:UIAlertActionStyleCancel handler:nil];

	[alertController addAction:confirmAction];
	[alertController addAction:cancelAction];

	[canvasContentLayerVC presentViewController:alertController animated:YES completion:nil];

}


void saveToGalleryAlertController() {

	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"PerfectSpotify" message:@"Canvas downloaded succesfully. Do you want to open gallery?" preferredStyle:UIAlertControllerStyleAlert];

	UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {

		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.005 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{

			UIApplication *application = [UIApplication sharedApplication];
			NSURL *theURL = [NSURL URLWithString:@"photos-redirect://"];
			[application _openURL:theURL];

		});

	}];

	UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Not now" style:UIAlertActionStyleCancel handler:nil];

	[alertController addAction:confirmAction];
	[alertController addAction:cancelAction];

	[canvasContentLayerVC presentViewController:alertController animated:YES completion:nil];

}


void getCanvas() {

	NSFileManager *fileM = [NSFileManager defaultManager];

	NSString *documentsPath = [[fileM URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject].URLByDeletingLastPathComponent.path;
	NSString *completePath = [documentsPath stringByAppendingPathComponent:@"/Library/Caches/com.spotify.service.network/"];	
	NSString *newPath = [documentsPath stringByAppendingPathComponent:@"/Documents/Canvas/"];
	NSString *canvasDirectory = [documentsPath stringByAppendingPathComponent:@"/Documents/Canvas/"];

	NSError *error;

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

						[fileM createDirectoryAtPath:canvasDirectory withIntermediateDirectories:NO attributes:nil error:&error];

					[fileM copyItemAtPath:[completePath stringByAppendingPathComponent:path] toPath:[newPath stringByAppendingPathComponent:path] error:&error];

					if(!error) saveToFilzaAlertController();

					else {

						SPTPopupDialog *notSoProudPopup = [%c(SPTPopupDialog) popupWithTitle:@"PerfectSpotify" message:@"Oops, looks like there was an errow downloading this canvas, most likely because you already downloaded it. Otherwise try retrying." dismissButtonTitle:@"Got it"];
						[[%c(SPTPopupManager) sharedManager].presentationQueue addObject:notSoProudPopup];
						[[%c(SPTPopupManager) sharedManager] presentNextQueuedPopup];

						NSLog(@"PS:Your dumb af code caused this error %@", error);

					}

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

- (void)doubleTap:(UITapGestureRecognizer *)gesture {

	getCanvas();

}


%end




%hook SPTNowPlayingInformationUnitViewController


- (void)viewDidLoad { // Center song & artist title


	// Following code is from iCrazeiOS, https://github.com/iCrazeiOS

	%orig;

	if(centerText) {

		[self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.f constant:0.f]];
		[self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.subtitleLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.f constant:0.f]];

	}

}


%end




%hook SPTNowPlayingViewController


- (void)viewDidLayoutSubviews { // Align song & artist title to the top


	%orig;

	if(!textToTheTop) return;

	// Declare all the ViewControllers we need

	SPTNowPlayingInformationUnitViewController *informationUnitViewController = NULL;
	UIViewController *navigationBarUnitViewController = NULL;
	SPTNowPlayingContentLayerViewController *contentLayerViewController = NULL;

	// Get a reference to the ViewControllers by iterating through the children of self

	for(UIViewController *controller in self.childViewControllers) {

		if([controller isKindOfClass:%c(SPTNowPlayingInformationUnitViewController)]) informationUnitViewController = (SPTNowPlayingInformationUnitViewController*)controller;
		else if([controller isKindOfClass:%c(SPTNowPlayingNavigationBarUnitViewController)]) navigationBarUnitViewController = controller;
		else if([controller isKindOfClass:%c(SPTNowPlayingContentLayerViewController)]) contentLayerViewController = (SPTNowPlayingContentLayerViewController*)controller;

	}

	// Only align the label if all controllers have been found (there would be issues otherwise)

	if(informationUnitViewController && navigationBarUnitViewController && contentLayerViewController) {

		// Remove the old Y-Position of the titleLabel && Like Button

		for (NSLayoutConstraint *c in informationUnitViewController.view.constraints) {

			if((c.firstItem == informationUnitViewController.titleLabel || c.secondItem == informationUnitViewController.titleLabel) && (c.firstAttribute == NSLayoutAttributeCenterY || c.secondAttribute == NSLayoutAttributeCenterY))

				[informationUnitViewController.view removeConstraint:c];


			if(informationUnitViewController.heartButtonViewController && (c.firstItem == informationUnitViewController.heartButtonViewController.view || c.secondItem == informationUnitViewController.heartButtonViewController.view) && (c.firstAttribute == NSLayoutAttributeCenterY || c.secondAttribute == NSLayoutAttributeCenterY))
			
				[informationUnitViewController.view removeConstraint:c];


		}

		// Align the titleLabel bellow the NavigationBar

		if(informationUnitViewController.titleLabel.window == navigationBarUnitViewController.view.window && informationUnitViewController.titleLabel.window) [informationUnitViewController.titleLabel.topAnchor constraintEqualToAnchor:navigationBarUnitViewController.view.bottomAnchor].active = true;

		// Move the Like Button down (if it's there)

		if(informationUnitViewController.heartButtonViewController && informationUnitViewController.heartButtonViewController.view.window == informationUnitViewController.view.window && informationUnitViewController.heartButtonViewController.view.window) [informationUnitViewController.heartButtonViewController.view.centerYAnchor constraintEqualToAnchor:informationUnitViewController.view.bottomAnchor].active = true;

	}

}


%end




%hook SPTNowPlayingCoverArtCell


- (void)didMoveToSuperview {


	%orig;

	if(!textToTheTop) return;

	// Declare all the ViewControllers we need

	SPTNowPlayingInformationUnitViewController *informationUnitViewController = NULL;
	UIViewController *navigationBarUnitViewController = NULL;
	SPTNowPlayingViewController *nowPlayingController = ((SPTNowPlayingViewController*)((SPTNowPlayingContentLayerViewController*)self.collectionView.dataSource).parentViewController);
	
	// Get a reference to the ViewControllers by iterating through the children of self

	for(UIViewController *controller in nowPlayingController.childViewControllers) {

		if([controller isKindOfClass:%c(SPTNowPlayingInformationUnitViewController)]) informationUnitViewController = (SPTNowPlayingInformationUnitViewController*)controller;
		else if([controller isKindOfClass:%c(SPTNowPlayingNavigationBarUnitViewController)]) navigationBarUnitViewController = controller;

	}

	// Only align the label if all controllers have been found (there would be issues otherwise)

	if(informationUnitViewController && navigationBarUnitViewController && nowPlayingController) {

		UIImageView *artworkView = self.imageView;
		
		// Remove the old Y-Position of the artworkView

		for (NSLayoutConstraint *c in artworkView.superview.constraints) {

			if((c.firstItem == artworkView || c.secondItem == artworkView) && (c.firstAttribute == NSLayoutAttributeCenterY || c.secondAttribute == NSLayoutAttributeCenterY))

				[artworkView.superview removeConstraint:c];


		}
		
		// Create a UILayoutGuide ranging from the Track Title Label to above the Duration Slider

		UILayoutGuide *guide = [[UILayoutGuide alloc] init];
		[nowPlayingController.view addLayoutGuide:guide];
		
		if(guide.owningView.window == informationUnitViewController.subtitleLabel.window && guide.owningView.window) [guide.topAnchor constraintEqualToAnchor:informationUnitViewController.subtitleLabel.bottomAnchor].active = true;
		if(guide.owningView.window == informationUnitViewController.view.window && guide.owningView.window) [guide.bottomAnchor constraintEqualToAnchor:informationUnitViewController.view.bottomAnchor].active = true;
		
		// Center the artwork between the Track Title Label and the Duration Slider using the previously created LayoutGuide

		if(guide.owningView.window == artworkView.window && guide.owningView.window) [artworkView.centerYAnchor constraintEqualToAnchor:guide.centerYAnchor].active = true;

	}

}


%end
%end




%ctor {

	loadPrefs();

	%init(PerfectSpotify, ConnectButton=Class(@"ConnectUIFeatureImpl.ConnectButtonView"), ClearRecentSearchesButton=Class(@"SPTTing.ChipView"), PlayWhatYouLoveText=Class(@"SPTTing.EmptyState"), PlayButton=Class(@"EncoreConsumerMobile.PlayButtonView"), PlaylistsController=Class(@"PlaylistMigrationFeatureImpl.PLItemsViewModelImplementation"));

}
