#import "PerfectSpotify.h"
#import "SparkColourPickerUtils.h"
#import <Cephei/HBPreferences.h> // Import the cephei framework



// Create preference variables


//Miscellaneous

static BOOL oledSpotify;
static BOOL blackoutContextMenu;
static BOOL trueShuffle;
static BOOL hideConnectButton;
static BOOL hideAddSongsButton;
static BOOL hideBigPlayShuffleButton;
static BOOL enableLyricsForAllTracks;
static BOOL disableGeniusLyrics;
static BOOL disableStorylines;
static BOOL showStatusBar;
static BOOL hideSearchBar;
static BOOL hideTabBarLabels;
static BOOL hideRemoveButton;
static BOOL hideShareButton;
static BOOL hideSettingsButton;
static BOOL hideTabBarPlayButton;
static BOOL noPopUp;
static BOOL hideQueuePopUp;


// Now Playing UI

static BOOL hideDevicesButton;
static BOOL hideCloseButton;
static BOOL hidePlaylistNameText;
static BOOL hideContextMenuButton;
static BOOL hideQueueButton;
static BOOL hideLikeButton;
static BOOL hideShuffleButton;
static BOOL hideRepeatButton;
static BOOL hideTimeSlider;
static BOOL hideElapsedTime;
static BOOL hideRemainingTime;
static BOOL centerText;
static BOOL textToTheTop;
static BOOL hidePreviousTrackButton;
static BOOL hidePlayPauseButton;
static BOOL hideNextTrackButton;


// Car Mode UI

static BOOL enableCarMode;
static BOOL hidePlaylistTitle;
static BOOL hideCarButton;
static BOOL hideCarLikeButton;
static BOOL hideChooseMusicButton;


// Podcasts UI

static BOOL hideSpeedButton;
static BOOL hideBackButton;
static BOOL hideForwardButton;
static BOOL hideMoonButton;


// Lyrics UI

static BOOL hidePlayButtonOnLyrics;
static BOOL hideXButton;
static BOOL hideArtwork;
static BOOL hideSongLabel;
static BOOL hideArtistLabel;


// Colors

static BOOL enableTextColor;
static BOOL enableTintColor;
static BOOL gradientColors;
static BOOL enableBackgroundUIColor;
static BOOL lyricsCardColor;


// Search Page

static BOOL unclutterSearchPage;
static BOOL hideClearRecentSearchesButton;
static BOOL hideCancelButton;
static BOOL hideCameraButton;
static BOOL hidePlayWhatYouLoveText;




// Miscellaneous Settings




// OLED Spotify




%group PerfectSpotify




%hook GLUEGradientView


-(void)didMoveToWindow {


    if(oledSpotify) {


        %orig;


        self.alpha = 0;


    }


}


%end




%hook SPTHomeView


-(void)didMoveToWindow {


    if(oledSpotify) {


        self.backgroundColor = [UIColor blackColor];


    }


return %orig;


}


%end




%hook SPTHomeGradientBackgroundView


-(void)didMoveToWindow {


    if(oledSpotify) {


        self.backgroundColor = [UIColor blackColor];


    }


return %orig;


}


%end




%hook SPTHomeUIShortcutsCardView


-(void)didMoveToWindow {


    if(oledSpotify) {


        self.backgroundColor = [UIColor blackColor];


    }


return %orig;


}


%end




// OLED tab bar


%hook SPTNowPlayingBarViewController


-(void)viewDidLoad {


    %orig;


    if(oledSpotify) {


        UIView* contentView = MSHookIvar<UIView *>(self, "_contentView");


        [contentView setBackgroundColor:[UIColor blackColor]];


    }    


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




// OLED Search page (when you tap on search)


%hook GLUEEmptyStateView


-(void)didMoveToWindow {


    if(oledSpotify) {


        self.backgroundColor = [UIColor blackColor];


    }


return %orig;


}


%end




// OLED Search page (with history)


%hook SPTSearch2ViewController


-(void)viewDidLoad {


    %orig;


    if(oledSpotify) {


        self.view.backgroundColor = [UIColor blackColor];


    }


}


%end





// OLED liking songs pop-up


%hook SPTSimpleSnackbarContentView


-(void)setBackgroundColor:(id)arg1 {


    if(oledSpotify) {


        arg1 = [UIColor blackColor];


    }


return %orig;


}


%end




// Blackout context menu


%hook _UIVisualEffectSubview


-(void)didMoveToWindow { 


    if(blackoutContextMenu) {


        self.backgroundColor = [UIColor blackColor];


    }


return %orig;


}


%end




// True Shuffle (experimental)


%hook SPTSignupParameterShufflerImplementation


-(id)createShuffledKeyListFromParameters:(id)arg1 {


    if(trueShuffle) {

     
        return nil;


    }


return %orig;


}


%end


%hook SPTSignupParameterShufflerImplementation


-(id)shuffleEntriesFromQueryParameters:(id)arg1 {


    if(trueShuffle) {

    
        return nil;


    }


return %orig;


}


%end


%hook SPTSignupParameterShufflerImplementation


-(id)createHashFromParameterValues:(id)arg1 {


    if(trueShuffle) {
    

        return nil;


    }


return %orig;


}


%end


%hook SPTSignupParameterShufflerImplementation


-(id)md5FromString:(id)arg1 {

    
    if(trueShuffle) {


        return nil;


    }


return %orig;


}


%end




// Library X


/*%hook _TtC23YourLibraryXFeatureImpl23YourLibraryXTestManager


- (bool)isYourLibraryXEnabled {


    if (enableLibraryX) {


        return 1;


    }

    
return %orig;


}


%end


%hook SPTYourLibraryTestManagerImplementation


- (bool)isYourLibraryXEnabled {


    if (enableLibraryX) {


        return 1;


    }


return %orig;


}


%end*/



// Connect Button in main page




%hook ConnectButton


-(void)didMoveToWindow {


    if(hideConnectButton) {


        [self setHidden:YES];


    }


return %orig;


}


%end




// Hide "Add Songs" button in playlist


%hook SPTFreeTierPlaylistAdditionalCallToActionAddSongsImplementation


-(bool)enabled {


    if (hideAddSongsButton) {


        return 0;

    
    }


return %orig;


}


%end




// Hide Big Play Shuffle button in Playlist

// Fuck you Spotify, this is the first layoutSubviews in the code

// Couldn't figure another way after the update to 8.5.93


%hook BigPlayShuffleButton


-(void)layoutSubviews {


    %orig;


    if(hideBigPlayShuffleButton) {


        [self removeFromSuperview];


    }


}


%end




// Lyrics for all tracks


%hook SPTLyricsV2TestManagerImplementation


-(bool)isFeatureEnabled { 


    if(enableLyricsForAllTracks) {


        return 1;


    }


return %orig;


}


%end





%hook SPTLyricsV2Service


-(bool)lyricsAvailableForTrack:(id)arg1 {


    if(enableLyricsForAllTracks) {


        return 1;


    }


return %orig;


}


%end




// Disable Genius Lyrics


%hook SPTGeniusService


-(bool)isTrackGeniusEnabled:(id)arg1 {


    if(disableGeniusLyrics) {


        return 0;


    }


return %orig;


}


%end




// Disable Storylines


%hook SPTStorylinesEnabledManager


-(bool)storylinesEnabledForTrack:(id)arg1 {


    if(disableStorylines) {


        return 0;


}


return %orig;


}


%end




// Show Status Bar (Spotify did we asked for you to hide it? No? That's what I thought).


%hook SPTStatusBarManager


-(void)setStatusBarHiddenImmediate:(bool)arg1 withAnimation:(long long)arg2 {


    if (showStatusBar) {


        arg1 = 0;


    }


return %orig;


}


%end




// Hide search bar in Playlists page


%hook SPTSortingFilteringFilterBarView


-(void)didMoveToWindow {


    if(hideSearchBar) {


        self.hidden = YES;


    }


return %orig;


}


%end




// Hide Tab Bar button's labels


%hook UITabBarButtonLabel


-(void)didMoveToWindow {


    if(hideTabBarLabels) {


        self.hidden = YES;


    }


return %orig;


}


%end




// Hide Remove Button (Daily Mix)


%hook SPTNowPlayingFreeTierFeedbackButton


-(void)didMoveToWindow {


    if(hideRemoveButton) {


        self.hidden = YES;


    }


return %orig;


}


%end




// Hide Share Button (Podcasts UI)


%hook SPTNowPlayingShareButtonViewController


-(void)viewDidLoad {


    %orig;


    if(hideShareButton) {


        self.view.hidden = YES;


    }


}


%end




// Hide Settings Button


%hook SPTHomeUITopBarView


-(void)didMoveToWindow {


    if(hideSettingsButton) {


        UIStackView *buttonStack = MSHookIvar<UIStackView *>(self, "_buttonStack");
		
        [buttonStack setHidden:YES];


    }


return %orig;


}


%end




// Hide Play Button (Tab Bar)


%hook SPTNowPlayingBarPlayButton


-(void)didMoveToWindow {


    %orig;


    if(hideTabBarPlayButton) {


        self.hidden = YES;


    }


}


%end




// No Pop-Up when liking songs


%hook SPTSnackbarView


-(void)didMoveToWindow {


    if(noPopUp) {


        self.hidden = YES;


    }


return %orig;


}


%end




%hook SPTProgressView // Hide Queue Pop Up


-(void)didMoveToWindow {


    if(hideQueuePopUp) {


        self.hidden = YES;


    }


return %orig;


}


%end




// Tint Color




// Custom Tint Text Color



%hook UILabel


- (void)setTextColor:(UIColor *)arg1 {


     if(enableTextColor) {


        NSString *tintTextColor = [[NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.perfect.spotifycolors.plist"]
objectForKey:@"tintTextColor"];


        UIColor *color = [SparkColourPickerUtils colourWithString:tintTextColor withFallback:@"#ffffff"];

    
        %orig(color);


    } else {


        return %orig;


       }


}


%end




%hook GLUELabelStyle


-(void)setTextColor:(id)arg1 {


    if(enableTextColor) {


        NSString *tintTextColor = [[NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.perfect.spotifycolors.plist"]
objectForKey:@"tintTextColor"];


        UIColor *color = [SparkColourPickerUtils colourWithString:tintTextColor withFallback:@"#ffffff"];

    
        %orig(color);


    } else {


        return %orig;


       }


}


%end




// Tint Color



%hook SPTIconConfiguration


-(id)iconColor {


    if(enableTintColor) {


        NSString *tintColor = [[NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.perfect.spotifycolors.plist"]
objectForKey:@"tintColor"];


            if (tintColor != nil) {


                return [SparkColourPickerUtils colourWithString:tintColor withFallback:@"#ffffff"];


            }


    }

    
    return %orig;


}


%end




// Tinted Labels on tab bar player


%hook SPTNowPlayingBarPageView


-(void)didMoveToWindow {


    %orig;


    if(enableTextColor) {


        SPTNowPlayingMarqueeLabel* topLabel = MSHookIvar<SPTNowPlayingMarqueeLabel *>(self, "_topLabel");
		
        [topLabel setTextColor:[UIColor purpleColor]];


        SPTNowPlayingMarqueeLabel* bottomLabel = MSHookIvar<SPTNowPlayingMarqueeLabel *>(self, "_bottomLabel");

        [bottomLabel setTextColor:[UIColor purpleColor]];


    } else {


        return %orig;


       }


}


%end




%hook SPTNowPlayingPlayButtonV2


-(id)fillColor {


    if(enableTintColor) {


        NSString *tintColor = [[NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.perfect.spotifycolors.plist"]
objectForKey:@"tintColor"];


            if (tintColor != nil) {


                return [SparkColourPickerUtils colourWithString:tintColor withFallback:@"#ffffff"];


            }


    }


    return %orig;


}


%end




%hook SPTNowPlayingPreviousTrackButton


-(UIColor *)iconColor {


    if(enableTintColor) {


        NSString *tintColor = [[NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.perfect.spotifycolors.plist"]
objectForKey:@"tintColor"];


        return [SparkColourPickerUtils colourWithString:tintColor withFallback:@"#ffffff"];   


    } else {


    return %orig;


    }


}


%end




%hook SPTNowPlayingNextTrackButton


-(UIColor *)iconColor {


    if(enableTintColor) {


        NSString *tintColor = [[NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.perfect.spotifycolors.plist"]
objectForKey:@"tintColor"];


        return [SparkColourPickerUtils colourWithString:tintColor withFallback:@"#ffffff"];


    } else {


    return %orig;


    }


}


%end




// Now Playing UI




// OLED view to now playing UI or custom colors


%hook SPTNowPlayingBackgroundViewController


-(id)color {


    if(enableBackgroundUIColor) {


        NSString *backgroundUIColor = [[NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.perfect.spotifycolors.plist"]
        objectForKey:@"backgroundUIColor"];


            return [SparkColourPickerUtils colourWithString:backgroundUIColor withFallback:@"#000000"];


    } else {


    return %orig;


    }


}    


%end




// Tint color for the devices button


%hook SPTGaiaDevicesAvailableViewModel


-(void)setColor:(id)arg1 {


    if(enableTintColor) {


        NSString *tintColor = [[NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.perfect.spotifycolors.plist"]
        objectForKey:@"tintColor"];


        UIColor *color = [SparkColourPickerUtils colourWithString:tintColor withFallback:@"#ffffff"];

    
        %orig(color);


    } else {


        return %orig;


       }


}


%end




//Lyrics Card Color


%hook SPTLyricsV2NowPlayingCardViewStyle


-(void)setBackgroundColor:(id)arg1 {


    if(lyricsCardColor) {


        NSString *lyricsCardColor = [[NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.perfect.spotifycolors.plist"]
        objectForKey:@"lyricsCardColor"];


        UIColor *color = [SparkColourPickerUtils colourWithString:lyricsCardColor withFallback:@"#ffffff"];

    
        %orig(color);


    } else {


        return %orig;


       }


}

%end




%hook SPTLyricsV2FullscreenViewStyle


-(void)setBackgroundColor:(id)arg1 {


    if(lyricsCardColor) {


        NSString *lyricsCardColor = [[NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.perfect.spotifycolors.plist"]
        objectForKey:@"lyricsCardColor"];


        UIColor *color = [SparkColourPickerUtils colourWithString:lyricsCardColor withFallback:@"#ffffff"];

    
        %orig(color);


    } else {


        return %orig;


       }


}


%end




%hook SPTLyricsV2TextViewStyle


-(void)setBackgroundColor:(id)arg1 {


    if(lyricsCardColor) {


        NSString *lyricsCardColor = [[NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.perfect.spotifycolors.plist"]
        objectForKey:@"lyricsCardColor"];


        UIColor *color = [SparkColourPickerUtils colourWithString:lyricsCardColor withFallback:@"#ffffff"];

    
        %orig(color);


    } else {


        return %orig;


       }


}


%end




%hook SPTLyricsV2TextViewStyle


-(void)setTextColor:(id)arg1 {


    if(lyricsCardColor) {


        arg1 = [UIColor whiteColor];


    }


return %orig;


}


%end




%hook SPTLyricsV2FullscreenHeaderViewStyle


-(void)setBackgroundColor:(id)arg1 {


    if(lyricsCardColor) {


        NSString *lyricsCardColor = [[NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.perfect.spotifycolors.plist"]
        objectForKey:@"lyricsCardColor"];


        UIColor *color = [SparkColourPickerUtils colourWithString:lyricsCardColor withFallback:@"#ffffff"];

    
        %orig(color);


    } else {


        return %orig;


       }


}


%end




%hook SPTLyricsV2FullscreenFooterViewStyle


-(void)setBackgroundColor:(id)arg1 {


    if(lyricsCardColor) {


        NSString *lyricsCardColor = [[NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.perfect.spotifycolors.plist"]
        objectForKey:@"lyricsCardColor"];


        UIColor *color = [SparkColourPickerUtils colourWithString:lyricsCardColor withFallback:@"#ffffff"];

    
        %orig(color);


    } else {


        return %orig;


       }


}


%end




//Now Playing UI


// Hide Devices Button


%hook SPTGaiaDevicesAvailableViewImplementation


-(void)didMoveToWindow {


    if (hideDevicesButton) {


        self.hidden = YES;


    }


return %orig;


}


%end




// Hide Close Button


%hook SPTNowPlayingTitleButton


-(void)didMoveToWindow {


    if(hideCloseButton) {


        self.hidden = YES;


    }


return %orig;


}


%end




// Hide Playlist Name Text


%hook SPTNowPlayingNavigationBarViewV2


-(void)didMoveToWindow { // Following code is from Litten, check her out and her amazing tweaks! https://github.com/Litteeen


    %orig;


    if(hidePlaylistNameText) {


        SPTNowPlayingMarqueeLabel* title = MSHookIvar<SPTNowPlayingMarqueeLabel *>(self, "_titleLabel");
		

        [title setHidden:YES];
	

    }


}


%end




// Hide Context Menu Button


%hook SPTContextMenuAccessoryButton


-(void)didMoveToWindow {


    if(hideContextMenuButton) {
 

        self.hidden = YES;


    }


return %orig;


}


%end



// Hide Queue Button


%hook SPTNowPlayingQueueButton


-(void)didMoveToWindow {


    if(hideQueueButton) {


        self.hidden = YES;


    }


return %orig;


}


%end



// Hide Like Button


%hook SPTNowPlayingAnimatedLikeButton


-(void)didMoveToWindow {


    if(hideLikeButton) {


        self.hidden = YES;


    }


return %orig;


}


%end



// Hide Shuffle Button


%hook SPTNowPlayingShuffleButton


-(void)didMoveToWindow {


    if(hideShuffleButton) {


        self.hidden = YES;


    }


return %orig;


}


%end



// Hide Repeat Button


%hook SPTNowPlayingRepeatButton


-(void)didMoveToWindow {


    if(hideRepeatButton) {


        self.hidden = YES;


    }


return %orig;


}


%end




// Hide Time Slider


%hook SPTNowPlayingSliderV2


-(void)didMoveToWindow {


    if(hideTimeSlider) {


        self.hidden = YES;


    }


return %orig;


}


%end



// Hide elapsed and remaining time labels


%hook SPTNowPlayingDurationViewV2


-(void)didMoveToWindow {


    if(hideElapsedTime) { // Following code is from Litten, check her out and her amazing tweaks! https://github.com/Litteeen


        UILabel* elapsedTimeLabel = MSHookIvar<UILabel *>(self, "_timeTakenLabel"); 
        [elapsedTimeLabel setHidden:YES];


    }


    if (hideRemainingTime) {


        UILabel* remainingTimeLabel = MSHookIvar<UILabel *>(self, "_timeRemainingLabel"); 
        [remainingTimeLabel setHidden:YES];


}


return %orig;


}


%end



// Center Artist name and song title


%hook SPTNowPlayingInformationUnitViewController


-(void)viewDidLoad { 


    // Following code is from iCrazeiOS, check him out! https://github.com/iCrazeiOS


    %orig;


    if(centerText) {


	    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.f constant:0.f]];
	    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.subtitleLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.f constant:0.f]];


    }


}

%end




// Hide Previous Track Button


%hook SPTNowPlayingPreviousTrackButton


-(void)didMoveToWindow {


    if(hidePreviousTrackButton) {


        self.hidden = YES;


    }


return %orig;


}


%end




// Hide Play/Pause Button


%hook SPTNowPlayingPlayButtonV2


-(void)didMoveToWindow {


    if(hidePlayPauseButton) {


        self.hidden = YES;


    }


return %orig;


}


%end




// Hide Next Track Button


%hook SPTNowPlayingNextTrackButton


-(void)didMoveToWindow {


    if(hideNextTrackButton) {


        self.hidden = YES;


    }


return %orig;


}


%end




// Car Mode UI


%hook SPTDrivingModeControllerImplementation


-(void)setDrivingModeEnabled:(bool)arg1 {


    if(enableCarMode) {


        arg1 = 1;


    }


return %orig;


}


%end




// Hide car button


%hook SPTDrivingModeNavigationBarView


-(void)didMoveToWindow {


    if(hidePlaylistTitle) {


        UIButton* titleLabel = MSHookIvar<UIButton *>(self, "_titleLabel");


        [titleLabel setHidden:YES];


    }


    if(hideCarButton) {


        UIButton* rightButton = MSHookIvar<UIButton *>(self, "_rightButton");


        [rightButton setHidden:YES];


    }


return %orig;


}


%end




// Hide Like button in car play UI


%hook SPTDrivingModeHeadUnitFeedbackButton


-(void)didMoveToWindow {


    if(hideCarLikeButton) {


        self.hidden = YES;


    }


return %orig;


}


%end




// Hide choose music button


%hook SPTDrivingModeFooterUnitViewController


-(void)viewDidLoad {


    if (hideChooseMusicButton) {


        self.view.hidden = YES;


    }


return %orig;


}


%end




// Podcasts UI / Hide Speed, Back, Forward, Moon Buttons


%hook SPTNowPlayingHeadUnitView


-(void)didMoveToWindow {


    if(hideBackButton) {


        UIButton* leftSecondaryButton = MSHookIvar<UIButton *>(self, "_leftSecondaryButton");
		

        [leftSecondaryButton setHidden:YES];


    }


    if(hideSpeedButton) {


        UIButton* leftTertiaryButton = MSHookIvar<UIButton *>(self, "_leftTertiaryButton");
		

        [leftTertiaryButton setHidden:YES];


    }


    if(hideForwardButton) {


        UIButton* rightSecondaryButton = MSHookIvar<UIButton *>(self, "_rightSecondaryButton");
		

        [rightSecondaryButton setHidden:YES];


    }


    if(hideMoonButton) {


        UIButton* rightTertiaryButton = MSHookIvar<UIButton *>(self, "_rightTertiaryButton");
		

        [rightTertiaryButton setHidden:YES];


    }


return %orig;


}


%end




// Lyrics UI




// Hide Play Button on Lyrics view


%hook SPTLyricsV2FullscreenFooterView


-(void)didMoveToWindow {


    if(hidePlayButtonOnLyrics) {


        SPTNowPlayingPlayButtonV2* playPauseButton = MSHookIvar<SPTNowPlayingPlayButtonV2 *>(self, "_playPauseButton");
		

        [playPauseButton setHidden:YES];


    }


return %orig;


}


%end




// No X Button on Lyrics view


%hook SPTLyricsV2FullscreenViewController


-(void)viewDidLoad {


    %orig;


    if(hideXButton) {


        UIButton* closeButton = MSHookIvar<UIButton *>(self, "_closeButton");
		

        [closeButton setHidden:YES];


    }


}


%end




// Hide Artwork / Song/Artist Titles


%hook SPTLyricsV2FullscreenHeaderView


-(void)didMoveToWindow {


    if(hideArtwork) {


        UIImageView* imageView = MSHookIvar<UIImageView *>(self, "_imageView");
		

        [imageView setHidden:YES];


    }


    if(hideSongLabel) {


        GLUELabel* titleLabel = MSHookIvar<GLUELabel *>(self, "_titleLabel");
		

        [titleLabel setHidden:YES];


    }


    if(hideArtistLabel) {


        GLUELabel* subtitleLabel = MSHookIvar<GLUELabel *>(self, "_subtitleLabel");
		

        [subtitleLabel setHidden:YES];


    }


return %orig;


}


%end




// Search Page




// Hide ugly stuff in search page


%hook SPTBrowseUICardComponentView


-(void)didMoveToWindow {


    if(unclutterSearchPage) {


        self.hidden = YES;


    }


return %orig;


}


%end




%hook HUGS2SectionHeaderComponentView


-(void)didMoveToWindow {


    if(unclutterSearchPage) {


        self.hidden = YES;


    }


return %orig;


}


%end




// Hide Clear Recent Searches Button


%hook ClearRecentSearchesButton


-(void)didMoveToWindow {


    if(hideClearRecentSearchesButton) {


        [self setHidden:YES];


    }


return %orig;


}


%end




// Hide Cancel/Camera Buttons in search page


%hook SPTSearchUISearchControls


-(void)didMoveToWindow {


    if(hideCancelButton) {


        UIButton* cancelButton = MSHookIvar<UIButton *>(self, "_cancelButton");


        [cancelButton setHidden:YES];


    }


    if(hideCameraButton) {


        UIButton* scannablesButton = MSHookIvar<UIButton *>(self, "_scannablesButton");


        [scannablesButton setHidden:YES];


    }


return %orig;


}


%end




//Hide the "Play what you love text"


%hook PlayWhatYouLoveText


-(void)didMoveToWindow {


    if(hidePlayWhatYouLoveText) {


        [self setHidden:YES];


    }


return %orig;    


}


%end




// Fix for the shuffle and repeat buttons being hidden in context menu


%hook SPTNowPlayingContextMenuHeaderView


-(void)didMoveToWindow {


    %orig;


    SPTNowPlayingShuffleButton* shuffleButton = MSHookIvar<SPTNowPlayingShuffleButton *>(self, "_shuffleButton");
		
    [shuffleButton setHidden:NO];


    SPTNowPlayingRepeatButton* repeatButton = MSHookIvar<SPTNowPlayingRepeatButton *>(self, "_repeatButton");
		
    [repeatButton setHidden:NO];


}


%end




%hook SPTNowPlayingViewController

-(void)viewDidLayoutSubviews{

	%orig;
	
	if(!textToTheTop) return;
	
	//Declare all the ViewControllers we need
	SPTNowPlayingInformationUnitViewController *informationUnitViewController = NULL;
	UIViewController *navigationBarUnitViewController = NULL;
	SPTNowPlayingContentLayerViewController *contentLayerViewController = NULL;
	
	//Get a reference to the ViewControllers by iterating through the children of self
	for(UIViewController *controller in self.childViewControllers){
		if([controller isKindOfClass:%c(SPTNowPlayingInformationUnitViewController)]) informationUnitViewController = (SPTNowPlayingInformationUnitViewController*)controller;
		else if([controller isKindOfClass:%c(SPTNowPlayingNavigationBarUnitViewController)]) navigationBarUnitViewController = controller;
		else if([controller isKindOfClass:%c(SPTNowPlayingContentLayerViewController)]) contentLayerViewController = (SPTNowPlayingContentLayerViewController*)controller;
	}
	
	//Only align the label if all controllers have been found (there would be issues otherwise)
	if(informationUnitViewController && navigationBarUnitViewController && contentLayerViewController){
		//Remove the old Y-Position of the titleLabel && Like Button
		for (NSLayoutConstraint *c in informationUnitViewController.view.constraints) {
			if((c.firstItem == informationUnitViewController.titleLabel || c.secondItem == informationUnitViewController.titleLabel) && (c.firstAttribute == NSLayoutAttributeCenterY || c.secondAttribute == NSLayoutAttributeCenterY)) {
				[informationUnitViewController.view removeConstraint:c];
			}
			
			if(informationUnitViewController.heartButtonViewController && (c.firstItem == informationUnitViewController.heartButtonViewController.view || c.secondItem == informationUnitViewController.heartButtonViewController.view) && (c.firstAttribute == NSLayoutAttributeCenterY || c.secondAttribute == NSLayoutAttributeCenterY)) {
				[informationUnitViewController.view removeConstraint:c];
			}
		}
		
		//Align the titleLabel bellow the NavigationBar
		if(informationUnitViewController.titleLabel.window == navigationBarUnitViewController.view.window && informationUnitViewController.titleLabel.window) [informationUnitViewController.titleLabel.topAnchor constraintEqualToAnchor:navigationBarUnitViewController.view.bottomAnchor].active = true;
		
		//Move the Like Button down (if it's there)
		if(informationUnitViewController.heartButtonViewController && informationUnitViewController.heartButtonViewController.view.window == informationUnitViewController.view.window && informationUnitViewController.heartButtonViewController.view.window) [informationUnitViewController.heartButtonViewController.view.centerYAnchor constraintEqualToAnchor:informationUnitViewController.view.bottomAnchor].active = true;
	}
}

%end

%hook SPTNowPlayingCoverArtCell

-(void)didMoveToSuperview{
	%orig;
	
	if(!textToTheTop) return;
	
	//Declare all the ViewControllers we need
	SPTNowPlayingInformationUnitViewController *informationUnitViewController = NULL;
	UIViewController *navigationBarUnitViewController = NULL;
	SPTNowPlayingViewController *nowPlayingController = ((SPTNowPlayingViewController*)((SPTNowPlayingContentLayerViewController*)self.collectionView.dataSource).parentViewController);
	
	//Get a reference to the ViewControllers by iterating through the children of self
	for(UIViewController *controller in nowPlayingController.childViewControllers){
		if([controller isKindOfClass:%c(SPTNowPlayingInformationUnitViewController)]) informationUnitViewController = (SPTNowPlayingInformationUnitViewController*)controller;
		else if([controller isKindOfClass:%c(SPTNowPlayingNavigationBarUnitViewController)]) navigationBarUnitViewController = controller;
	}
	
	//Only align the label if all controllers have been found (there would be issues otherwise)
	if(informationUnitViewController && navigationBarUnitViewController && nowPlayingController){
		UIImageView *artworkView = self.imageView;
		
		//Remove the old Y-Position of the artworkView
		for (NSLayoutConstraint *c in artworkView.superview.constraints) {
			if((c.firstItem == artworkView || c.secondItem == artworkView) && (c.firstAttribute == NSLayoutAttributeCenterY || c.secondAttribute == NSLayoutAttributeCenterY)) {
				[artworkView.superview removeConstraint:c];
			}
		}
		
		//Create a UILayoutGuide ranging from the Track Title Label to above the Duration Slider
		UILayoutGuide *guide = [[UILayoutGuide alloc] init];
		[nowPlayingController.view addLayoutGuide:guide];
		
		if(guide.owningView.window == informationUnitViewController.subtitleLabel.window && guide.owningView.window) [guide.topAnchor constraintEqualToAnchor:informationUnitViewController.subtitleLabel.bottomAnchor].active = true;
		if(guide.owningView.window == informationUnitViewController.view.window && guide.owningView.window) [guide.bottomAnchor constraintEqualToAnchor:informationUnitViewController.view.bottomAnchor].active = true;
		
		//Center the artwork between the Track Title Label and the Duration Slider using the previously created LayoutGuide
		if(guide.owningView.window == artworkView.window && guide.owningView.window) [artworkView.centerYAnchor constraintEqualToAnchor:guide.centerYAnchor].active = true;
	}
}

%end




%hook MPNowPlayingInfoCenter


- (void)setNowPlayingInfo:(id)arg1 { // update colors when artwork changed

    if(gradientColors) {

	    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"kleiUpdateColors" object:nil];
            });


    }

return %orig;

}


%end




%hook SPTNowPlayingViewController // Litten's gradient thingy, thank you so much for this <3


%new


- (void)setColors { // get artwork colors


    if(gradientColors) {


        //NSLog(@"[PERFECTSPOTIFY] %@", [libKitten backgroundColor:currentArtwork]);

	    MRMediaRemoteGetNowPlayingInfo(dispatch_get_main_queue(), ^(CFDictionaryRef information) {
		NSDictionary* dict = (__bridge NSDictionary *)information;
		    if (dict) {
			    if (dict[(__bridge NSString *)kMRMediaRemoteNowPlayingInfoArtworkData]) {
				currentArtwork = [UIImage imageWithData:[dict objectForKey:(__bridge NSString*)kMRMediaRemoteNowPlayingInfoArtworkData]];
				    if (currentArtwork)
					[gradient setColors:[NSArray arrayWithObjects:(id)[[libKitten backgroundColor:currentArtwork] CGColor], (id)[[libKitten primaryColor:currentArtwork] CGColor], nil]];
			        }
      	        } else {
			    [gradient setColors:[NSArray arrayWithObjects:(id)[[UIColor clearColor] CGColor], (id)[[UIColor clearColor] CGColor], nil]];
		    }
    	});
    }

}


- (void)viewDidLoad { // add gradient


    %orig;


    if(gradientColors) {

	    if (!gradient) {
		    gradient = [[CAGradientLayer alloc] init];
		    [gradient setFrame:[[self view] bounds]];
		    [gradient setStartPoint:CGPointMake(0.0, 0.5)];
    	    [gradient setEndPoint:CGPointMake(0.5, 1.0)];
		    [gradient setColors:[NSArray arrayWithObjects:(id)[[UIColor clearColor] CGColor], (id)[[UIColor clearColor] CGColor], nil]];
		    [gradient setLocations:[NSArray arrayWithObjects:@(-0.5), @(1.5), nil]];
		    [[[self view] layer] insertSublayer:gradient atIndex:0];
	    }

	        [[NSNotificationCenter defaultCenter] removeObserver:self];
	        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setColors) name:@"kleiUpdateColors" object:nil]; // add notification observer to dynamically change artwork

    }


}

- (void)viewWillAppear:(BOOL)animated { // update colors when now playing view appears


    %orig;

	[self setColors];

}


%end
%end




    // You'll need to add another %end if you're grouping all hooks




%ctor {
  



  // Create HBPreferences instance with your identifier, usually I just add prefs to the end of my package identifier


HBPreferences *preferences = [[HBPreferences alloc] initWithIdentifier:@"com.perfect.spotify"];

  // Register preference variables, naming the preference key and variable the same thing reduces confusion for me.

  [preferences registerBool:&lyricsCardColor default:NO forKey:@"lyricsCardColor"];
  [preferences registerBool:&hideConnectButton default:NO forKey:@"hideConnectButton"];
  [preferences registerBool:&hideAddSongsButton default:NO forKey:@"hideAddSongsButton"];
  [preferences registerBool:&hideDevicesButton default:NO forKey:@"hideDevicesButton"];
  [preferences registerBool:&hideBigPlayShuffleButton default:NO forKey:@"hideBigPlayShuffleButton"];
  [preferences registerBool:&hideCloseButton default:NO forKey:@"hideCloseButton"];
  [preferences registerBool:&hidePlaylistNameText default:NO forKey:@"hidePlaylistNameText"];
  [preferences registerBool:&hideContextMenuButton default:NO forKey:@"hideContextMenuButton"];
  [preferences registerBool:&hideQueueButton default:NO forKey:@"hideQueueButton"];
  [preferences registerBool:&hideLikeButton default:NO forKey:@"hideLikeButton"];
  [preferences registerBool:&hideShuffleButton default:NO forKey:@"hideShuffleButton"];
  [preferences registerBool:&hideRepeatButton default:NO forKey:@"hideRepeatButton"];
  [preferences registerBool:&hideTimeSlider default:NO forKey:@"hideTimeSlider"];
  [preferences registerBool:&hideElapsedTime default:NO forKey:@"hideElapsedTime"];
  [preferences registerBool:&hideRemainingTime default:NO forKey:@"hideRemainingTime"];
  [preferences registerBool:&centerText default:NO forKey:@"centerText"];
  [preferences registerBool:&enableCarMode default:NO forKey:@"enableCarMode"];
  [preferences registerBool:&enableLyricsForAllTracks default:NO forKey:@"enableLyricsForAllTracks"];
  [preferences registerBool:&disableGeniusLyrics default:NO forKey:@"disableGeniusLyrics"];
  [preferences registerBool:&disableStorylines default:NO forKey:@"disableStorylines"];
  [preferences registerBool:&showStatusBar default:NO forKey:@"showStatusBar"];
  [preferences registerBool:&hidePreviousTrackButton default:NO forKey:@"hidePreviousTrackButton"];
  [preferences registerBool:&hidePlayPauseButton default:NO forKey:@"hidePlayPauseButton"];
  [preferences registerBool:&hideNextTrackButton default:NO forKey:@"hideNextTrackButton"];
  [preferences registerBool:&hideSearchBar default:NO forKey:@"hideSearchBar"];
  [preferences registerBool:&blackoutContextMenu default:NO forKey:@"blackoutContextMenu"];
  [preferences registerBool:&hidePlaylistTitle default:NO forKey:@"hidePlaylistTitle"];
  [preferences registerBool:&hideCarButton default:NO forKey:@"hideCarButton"];
  [preferences registerBool:&hideCarLikeButton default:NO forKey:@"hideCarLikeButton"];
  [preferences registerBool:&hideChooseMusicButton default:NO forKey:@"hideChooseMusicButton"];
  [preferences registerBool:&oledSpotify default:NO forKey:@"oledSpotify"]; 
  [preferences registerBool:&hideTabBarLabels default:NO forKey:@"hideTabBarLabels"];
  [preferences registerBool:&trueShuffle default:NO forKey:@"trueShuffle"];
  [preferences registerBool:&hideRemoveButton default:NO forKey:@"hideRemoveButton"];
  [preferences registerBool:&hideClearRecentSearchesButton default:NO forKey:@"hideClearRecentSearchesButton"];
  [preferences registerBool:&unclutterSearchPage default:NO forKey:@"unclutterSearchPage"];
  [preferences registerBool:&hideShareButton default:NO forKey:@"hideShareButton"];
  [preferences registerBool:&hideSettingsButton default:NO forKey:@"hideSettingsButton"];
  [preferences registerBool:&hideTabBarPlayButton default:NO forKey:@"hideTabBarPlayButton"];
  [preferences registerBool:&hidePlayButtonOnLyrics default:NO forKey:@"hidePlayButtonOnLyrics"];
  [preferences registerBool:&hideCancelButton default:NO forKey:@"hideCancelButton"];
  [preferences registerBool:&hideCameraButton default:NO forKey:@"hideCameraButton"];
  [preferences registerBool:&hideXButton default:NO forKey:@"hideXButton"];
  [preferences registerBool:&noPopUp default:NO forKey:@"noPopUp"];
  [preferences registerBool:&hideBackButton default:NO forKey:@"hideBackButton"];
  [preferences registerBool:&hideSpeedButton default:NO forKey:@"hideSpeedButton"];
  [preferences registerBool:&hideForwardButton default:NO forKey:@"hideForwardButton"];
  [preferences registerBool:&hideMoonButton default:NO forKey:@"hideMoonButton"];
  [preferences registerBool:&hideArtwork default:NO forKey:@"hideArtwork"];
  [preferences registerBool:&hideSongLabel default:NO forKey:@"hideSongLabel"];
  [preferences registerBool:&hideArtistLabel default:NO forKey:@"hideArtistLabel"];
  [preferences registerBool:&enableTextColor default:NO forKey:@"enableTextColor"];
  [preferences registerBool:&enableTintColor default:NO forKey:@"enableTintColor"];
  [preferences registerBool:&enableBackgroundUIColor default:NO forKey:@"enableBackgroundUIColor"];
  [preferences registerBool:&textToTheTop default:NO forKey:@"textToTheTop"];
  [preferences registerBool:&gradientColors default:NO forKey:@"gradientColors"];
  [preferences registerBool:&hidePlayWhatYouLoveText default:NO forKey:@"hidePlayWhatYouLoveText"];
  [preferences registerBool:&hideQueuePopUp default:NO forKey:@"hideQueuePopUp"];
  //[preferences registerBool:&hideVolumeSliderKnob default:NO forKey:@"hideVolumeSliderKnob"];  

    // Check if the toggles switches are enabled from preferences then init the group hooks

    %init(PerfectSpotify, ConnectButton=objc_getClass("ConnectUIFeatureImpl.ConnectButtonView"), BigPlayShuffleButton=objc_getClass("EncoreConsumerMobile.PlayButtonView"), ClearRecentSearchesButton=objc_getClass("SPTTing.ChipView"), PlayWhatYouLoveText=objc_getClass("SPTTing.EmptyState"));


}