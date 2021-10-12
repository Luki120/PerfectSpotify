#import "PerfectSpotify.h"


// Miscellaneous Settings


%group PerfectSpotify


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




%hook SPTHomeUIShortcutsCardView


- (void)didMoveToWindow {


	%orig;

	if(oledSpotify) self.backgroundColor = UIColor.blackColor;


}


%end




%hook SPTNowPlayingBarViewController


- (void)viewDidLoad { // OLED tab bar


	%orig;

	if(oledSpotify) {

		UIView *contentView = MSHookIvar<UIView *>(self, "_contentView");

		[contentView setBackgroundColor:[UIColor blackColor]];

	}    

}


%end




%hook UIView


- (void)didMoveToWindow { // well fuck


	%orig;

	ancestor = [self _viewControllerForAncestor];

	if(oledSpotify)

		if([ancestor isKindOfClass:%c(SPTNowPlayingBarV2ViewController)])

			self.backgroundColor = UIColor.blackColor;


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

	if(oledSpotify) {

		UITabBarAppearance *tabBar = [[UITabBarAppearance alloc] init];
		tabBar.backgroundColor = [UIColor blackColor];
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




%hook SPTSimpleSnackbarContentView


- (void)setBackgroundColor:(id)arg1 { // OLED liking songs pop-up


	if(oledSpotify) %orig(UIColor.blackColor);


}


%end




%hook _UIVisualEffectSubview


- (void)didMoveToWindow { // Blackout context menu


	%orig;

	if(oledSpotify) self.backgroundColor = UIColor.blackColor;


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




%hook ConnectButton


- (void)didMoveToWindow { // Connect Button in main page


	%orig;

	if(hideConnectButton) [self setHidden:YES];


}


%end




%hook SPTFreeTierPlaylistAdditionalCallToActionAddSongsImplementation


- (bool)enabled { // Hide "Add Songs" button in playlist


	if(hideAddSongsButton) return NO;

	return %orig;


}


%end




%hook SPTLyricsV2TestManagerImplementation


- (bool)isFeatureEnabled { // Lyrics for all tracks


	if(enableLyricsForAllTracks) return YES;

	return %orig;


}


%end





%hook SPTLyricsV2Service


- (bool)lyricsAvailableForTrack:(id)arg1 {


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




%hook SPTStorylinesEnabledManager


- (bool)storylinesEnabledForTrack:(id)arg1 { // Disable Storylines


	if(disableStorylines) return NO;

	return %orig;


}


%end




%hook SPTStatusBarManager


- (void)setStatusBarHiddenImmediate:(bool)arg1 withAnimation:(long long)arg2 { // Show Status Bar


	if(showStatusBar) arg1 = NO;

	else %orig;

}


%end




%hook UITabBarButtonLabel


- (void)didMoveToWindow { // Hide Tab Bar button's labels


	%orig;

	if(hideTabBarLabels) self.hidden = YES;


}


%end




%hook SPTNowPlayingFreeTierFeedbackButton


- (void)didMoveToWindow { // Hide Remove Button (Daily Mix)


	%orig;

	if(hideRemoveButton) self.hidden = YES;


}


%end




%hook SPTNowPlayingShareButtonViewController


- (void)viewDidLoad { // Hide Share Button (Podcasts UI)


	%orig;

	if(hideShareButton) self.view.hidden = YES;


}


%end




%hook SPTNowPlayingBarPlayButton


- (void)didMoveToWindow { // Hide Play Button (Tab Bar)


	%orig;

	if(hideTabBarPlayButton) self.hidden = YES;


}


%end




%hook SPTSnackbarView


- (void)didMoveToWindow { // No Pop-Up when liking songs


	%orig;

	if(noPopUp) self.hidden = YES;


}


%end




%hook SPTProgressView // Hide Queue Pop Up


- (void)didMoveToWindow {


	%orig;

	if(hideQueuePopUp) self.hidden = YES;


}


%end




// Tint Color


// Litten's Klei gradients, thank you


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


	MRMediaRemoteGetNowPlayingInfo(dispatch_get_main_queue(), ^(CFDictionaryRef information) {

		NSDictionary *dict = (__bridge NSDictionary *)information;

		if(dict) {
            
			CATransition *transitionKleiView = [CATransition animation];
			transitionKleiView.type = kCATransitionFade;
			transitionKleiView.duration = 1.0f;
			transitionKleiView.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

			[gradient addAnimation:transitionKleiView forKey:nil];

			if(dict[(__bridge NSString *)kMRMediaRemoteNowPlayingInfoArtworkData]) {

				currentArtwork = [UIImage imageWithData:[dict objectForKey:(__bridge NSString*)kMRMediaRemoteNowPlayingInfoArtworkData]];

				if(currentArtwork)

					[gradient setColors:[NSArray arrayWithObjects:(id)[[libKitten backgroundColor:currentArtwork] CGColor], (id)[[libKitten primaryColor:currentArtwork] CGColor], nil]];

			}


		} else [gradient setColors:[NSArray arrayWithObjects:(id)UIColor.clearColor.CGColor, (id)UIColor.clearColor.CGColor, nil]];

	});

}


- (void)viewDidLoad { // add gradient


	%orig;

	[self setColors];

	if(gradientColors) {

		if(!gradient) {

			gradient = [CAGradientLayer new];
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




%hook UIImageView


- (void)didMoveToWindow {


	%orig;

	if(enableTintColor) self.tintColor = [GcColorPickerUtils colorWithHex:tintColor];


}


%end




%hook GLUELabelStyle


- (void)setTextColor:(id)arg1 {


	if(enableTextColor) %orig([GcColorPickerUtils colorWithHex:tintTextColor]);

	else %orig;


}


%end




%hook SPTIconConfiguration


- (id)iconColor { // Tint Color


	if(enableTintColor) return [GcColorPickerUtils colorWithHex:tintColor];

	return %orig;


}


%end




%hook SPTNowPlayingBarPageView


- (void)didMoveToWindow {


	%orig;

	if(enableTextColor) { // Tinted Labels on tab bar player


		SPTNowPlayingMarqueeLabel *topLabel = MSHookIvar<SPTNowPlayingMarqueeLabel *>(self, "_topLabel");
		
		[topLabel setTextColor:[GcColorPickerUtils colorWithHex:tintTextColor]];


		SPTNowPlayingMarqueeLabel *bottomLabel = MSHookIvar<SPTNowPlayingMarqueeLabel *>(self, "_bottomLabel");

		[bottomLabel setTextColor:[GcColorPickerUtils colorWithHex:tintTextColor]];


	}

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




// Now Playing UI


%hook SPTNowPlayingTitleButton


- (void)didMoveToWindow { // Hide Close Button


	%orig;

	if(hideCloseButton) self.hidden = YES;


}


%end




%hook SPTNowPlayingNavigationBarViewV2


- (void)didMoveToWindow { // Hide Playlist Name Text, following code is from Litten https://github.com/Litteeen


	%orig;

	if(hidePlaylistNameText) {

		SPTNowPlayingMarqueeLabel *title = MSHookIvar<SPTNowPlayingMarqueeLabel *>(self, "_titleLabel");

		[title setHidden:YES];

	}

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


	if(hideSliderKnob) {

		UIImageView *knobView = MSHookIvar<UIImageView *>(self, "_thumbView");

		[knobView setAlpha:0];

	}

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


- (void)didMoveToWindow { // Hide elapsed and remaining time labels, following code is from Litten, https://github.com/Litteeen


	if(hideElapsedTime) {

		UILabel *elapsedTimeLabel = MSHookIvar<UILabel *>(self, "_timeTakenLabel"); 
		[elapsedTimeLabel setHidden:YES];

	}

	if(hideRemainingTime) {

		UILabel *remainingTimeLabel = MSHookIvar<UILabel *>(self, "_timeRemainingLabel"); 
		[remainingTimeLabel setHidden:YES];

	}

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




%hook SPTNowPlayingQueueButton


- (void)didMoveToWindow { // Hide Queue Button


	%orig;

	if(hideQueueButton) self.hidden = YES;

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




%hook SPTNowPlayingHeadUnitView


- (id)initWithFrame:(CGRect)frame { // get an instance of SPTNowPlayingHeadUnitView

	id orig = %orig;

	headUnitView = self;

	return orig;

}


- (void)didMoveToWindow { // Podcasts UI / Hide Speed, Back, Forward Buttons

	if(hideBackButton || hidePreviousTrackButton) MSHookIvar<UIButton *>(self, "_leftSecondaryButton").hidden = YES;

	if(hideSpeedButton) MSHookIvar<UIButton *>(self, "_leftTertiaryButton").hidden = YES;

	if(hideForwardButton || hideNextTrackButton) MSHookIvar<UIButton *>(self, "_rightSecondaryButton").hidden = YES;

	else %orig;

}


%end




%hook SPTNowPlayingSleepTimerButtonViewController


- (void)setSleepTimerButton:(id)arg1 {

	if(hideMoonButton) {}

	else %orig;

}


%end




%hook ClearRecentSearchesButton


- (void)didMoveToWindow { // Hide Clear Recent Searches Button


	%orig;

	if(hideClearRecentSearchesButton) [self setHidden:YES];


}


%end




%hook SPTSearchUISearchControls


- (void)didMoveToWindow { // Hide Cancel Button in search page


	%orig;

	if(hideCancelButton) {

		UIButton *cancelButton = MSHookIvar<UIButton *>(self, "_cancelButton");

		[cancelButton setHidden:YES];

	}

}


%end




%hook PlayWhatYouLoveText


- (void)didMoveToWindow { // Hide the "Play what you love text"


	%orig;

	if(hidePlayWhatYouLoveText) [self setHidden:YES];


}


%end




/*%hook SPTNowPlayingPlaybackActionsHandlerImplementation


- (void)playPause:(id)arg1 {

	%orig;

	if(self.isPaused == YES) headUnitView.backgroundColor = UIColor.systemPurpleColor;
	else if(self.isPaused == NO) headUnitView.backgroundColor = UIColor.systemPinkColor;

}


%end*/
%end




%ctor {

	loadPrefs();

	%init(PerfectSpotify, ConnectButton=objc_getClass("ConnectUIFeatureImpl.ConnectButtonView"), ClearRecentSearchesButton=objc_getClass("SPTTing.ChipView"), PlayWhatYouLoveText=objc_getClass("SPTTing.EmptyState"), PlayButton=objc_getClass("EncoreConsumerMobile.PlayButtonView"));

}
