#import "PerfectSpotify.h"
#import <Cephei/HBPreferences.h> // Import the cephei framework

// Create preference variables


static BOOL enableLibraryX;
static BOOL blackoutMode;
static BOOL hideConnectButton;
static BOOL hideAddSongsButton;
static BOOL hideDevicesButton;
static BOOL hideBigPlayShuffleButton;
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
static BOOL enableCarMode;
static BOOL enableLyricsForAllTracks;
static BOOL disableGeniusLyrics;
static BOOL disableStorylines;
static BOOL showStatusBar;
static BOOL hidePreviousTrackButton;
static BOOL hidePlayPauseButton;
static BOOL hideNextTrackButton;
static BOOL hideSearchBar;
static BOOL hidePlaylistTitle;
static BOOL hideCarButton;
static BOOL hideCarLikeButton;
static BOOL hideChooseMusicButton;
static BOOL oledSpotify;
static BOOL blackoutContextMenu;
static BOOL hideTabBarLabels;
static BOOL trueShuffle;
static BOOL hideRemoveButton;
static BOOL hideClearRecentSearchesButton;
static BOOL unclutterSearchPage;



// Connect Button in main page

%group EnableTweak


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




// Hide Devices Button


%hook SPTGaiaDevicesAvailableViewImplementation

- (void)didMoveToWindow {

%orig;

if (hideDevicesButton) {

self.hidden = YES;

}

return %orig;

}

%end




// Hide Big Play Shuffle button in Playlist


%hook _TtC20EncoreConsumerMobile16HeaderPlayButton

- (void)didMoveToWindow {

        if (hideBigPlayShuffleButton) {
       
        %orig;

        self.hidden = YES;

       }

      %orig;

   }

%end




// Library X


%hook _TtC23YourLibraryXFeatureImpl23YourLibraryXTestManager

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

%end




// OLED view to now playing UI

%hook SPTNowPlayingBackgroundViewModel

-(void)setColor:(id)arg1 {

%orig;

    if(blackoutMode) {

    arg1 =  [UIColor blackColor];

   

}
return %orig;
}

%end

%hook SPTLyricsV2NowPlayingCardViewStyle


-(id)backgroundColor {

%orig;

    if(blackoutMode) {

    return [UIColor blackColor];

}

return %orig;

}

%end


%hook SPTLyricsV2NowPlayingCardViewStyle


-(void)setBackgroundColor:(id)arg1 {

%orig;

    if(blackoutMode) {

    arg1 = [UIColor blackColor];

    

}
return %orig;
}

%end

%hook SPTLyricsV2FullscreenViewStyle


-(id)backgroundColor {

    if(blackoutMode) {
     
    return [UIColor blackColor];

}

return %orig;

}

%end


%hook SPTLyricsV2FullscreenViewStyle
-(void)setBackgroundColor:(id)arg1 {
if(blackoutMode) {
    arg1 = [UIColor blackColor];
    
}
return %orig;
}
%end

%hook SPTLyricsV2TextViewStyle
-(id)backgroundColor {

if(blackoutMode) {
    return [UIColor blackColor];
}
return %orig;
}
%end


%hook SPTLyricsV2TextViewStyle
-(void)setBackgroundColor:(id)arg1 {

if(blackoutMode) {
    arg1 = [UIColor blackColor];
    
}
return %orig;
}
%end



%hook SPTLyricsV2TextViewStyle
-(id)textColor {

    if(blackoutMode) {
    return [UIColor whiteColor];
}
return %orig;
}
%end

%hook SPTLyricsV2TextViewStyle
-(void)setTextColor:(id)arg1 {

    if(blackoutMode) {
    arg1 = [UIColor whiteColor];
    
}
return %orig;
}
%end

%hook SPTLyricsV2FullscreenHeaderViewStyle
-(id)backgroundColor {
    if(blackoutMode) {
    return [UIColor blackColor];
}
return %orig;
}
%end

%hook SPTLyricsV2FullscreenHeaderViewStyle
-(void)setBackgroundColor:(id)arg1 {
    if(blackoutMode) {
    arg1 = [UIColor blackColor];
    
}
return %orig;
}
%end

%hook SPTLyricsV2FullscreenFooterViewStyle
-(id)backgroundColor {
    if(blackoutMode) {
    return [UIColor blackColor];
}
return %orig;
}
%end

%hook SPTLyricsV2FullscreenFooterViewStyle
-(void)setBackgroundColor:(id)arg1 {
    if(blackoutMode) {
    arg1 = [UIColor blackColor];
         
}
return %orig;
}
%end




// Hide Close Button

%hook SPTNowPlayingTitleButton

- (void)didMoveToWindow {

if(hideCloseButton) {

%orig;

self.hidden = YES;

}

return %orig;

}


%end




// Hide Context Menu Button


%hook SPTContextMenuAccessoryButton

- (void)didMoveToWindow {

%orig;

if(hideContextMenuButton) {
 

self.hidden = YES;

}

return %orig;

}


%end



// Hide Queue Button

%hook SPTNowPlayingQueueButton

- (void)didMoveToWindow {


%orig;


if(hideQueueButton) {


self.hidden = YES;


}

return %orig;


}


%end



// Hide Like Button


%hook SPTNowPlayingAnimatedLikeButton

- (void)didMoveToWindow {

%orig;

if(hideLikeButton) {

self.hidden = YES;

}

return; %orig;

}


%end



// Hide Shuffle Button


%hook SPTNowPlayingShuffleButton

- (void)didMoveToWindow {

%orig;

if(hideShuffleButton) {

self.hidden = YES;

}

return %orig;

}


%end



// Hide Repeat Button


%hook SPTNowPlayingRepeatButton

- (void)didMoveToWindow {

%orig;

if(hideRepeatButton) {

self.hidden = YES;

}

return %orig;

}


%end




// Hide Time Slider


%hook SPTNowPlayingSliderV2

- (void)didMoveToWindow {

%orig;

if(hideTimeSlider) {

self.hidden = YES;

}

return %orig;

}


%end



// Hide elapsed and remaining time labels


%hook SPTNowPlayingDurationViewV2

- (void)didMoveToWindow {

%orig;

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
-(void)viewDidLoad { // Following code is from iCrazeiOS, check him out! https://github.com/iCrazeiOS
	%orig;
if(centerText) {
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.f constant:0.f]];
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.subtitleLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.f constant:0.f]];

}

}

%end



%hook SPTDrivingModeControllerImplementation

-(void)setDrivingModeEnabled:(bool)arg1 { 

if(enableCarMode) {
    arg1 = 1;

}

return %orig;

}


%end


// Lyrics for all tracks


%hook SPTLyricsV2TestManagerImplementation
-(bool)isFeatureEnabled { 

%orig;

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




// Disable Storylines

%hook SPTStorylinesEnabledManager


-(bool)storylinesEnabledForTrack:(id)arg1 {

    if(disableStorylines) {

    return 0;

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




// Show Status Bar (Spotify did we asked for you to hide it? No? That's what I thought.)

%hook SPTStatusBarManager

-(void)setStatusBarHiddenImmediate:(bool)arg1 withAnimation:(long long)arg2 {

    if (showStatusBar) {
    arg1 = 0;

}

    return %orig;

}


%end




// Hide Playlist Name Text


%hook SPTNowPlayingNavigationBarViewV2

- (void)didMoveToWindow { // Following code is from Litten, check her out and her amazing tweaks! https://github.com/Litteeen

%orig;

if(hidePlaylistNameText) {

SPTNowPlayingMarqueeLabel* title = MSHookIvar<SPTNowPlayingMarqueeLabel *>(self, "_titleLabel");
		
[title setHidden:YES];
	

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




// Hide search bar in Playlists page


%hook SPTSortingFilteringFilterBarView


-(void)didMoveToWindow {

if(hideSearchBar) {

self.hidden = YES;

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

}

%end




// Blackout context menu


%hook _UIVisualEffectSubview

-(void)didMoveToWindow { 

if(blackoutContextMenu) {

self.backgroundColor = [UIColor blackColor];

}

}

%end




// Hide car button


%hook SPTDrivingModeNavigationBarView

-(void)didMoveToWindow {

if(hideCarButton) {

UIButton* rightButton = MSHookIvar<UIButton *>(self, "_rightButton");

[rightButton setHidden:YES];

}

if(hidePlaylistTitle) {

UIButton* titleLabel = MSHookIvar<UIButton *>(self, "_titleLabel");

[titleLabel setHidden:YES];

}

}


%end




// Hide choose music button


%hook SPTDrivingModeFooterUnitViewController

-(void)viewDidLoad {

if (hideChooseMusicButton) {

%orig;

self.view.hidden = YES;

}

%orig;

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




%hook _UIBarBackground

-(void)updateBackground {

%orig;

if(oledSpotify) {


  UIImageView* imageView = MSHookIvar<UIImageView *>(self, "_colorAndImageView1");

[imageView setBackgroundColor:[UIColor blackColor]];

}

}

%end




// OLED Spotify

%hook GLUEGradientView

-(void)didMoveToWindow {

if(oledSpotify) {

%orig;

self.alpha = 0;

}

}

%end




// OLED Spotify

%hook SPTHomeView

-(void)didMoveToWindow {

if(oledSpotify) {

self.backgroundColor = [UIColor blackColor];

}

}

%end




%hook SPTHomeGradientBackgroundView

-(void)didMoveToWindow {

if(oledSpotify) {

self.backgroundColor = [UIColor blackColor];

}

}

%end




%hook SPTHomeUIShortcutsCardView

-(void)didMoveToWindow {

if(oledSpotify) {

self.backgroundColor = [UIColor blackColor];

}

}

%end




// Hide Tab Bar button's labels

%hook UITabBarButtonLabel

-(void)didMoveToWindow {

if(hideTabBarLabels) {

self.hidden = YES;

}

}

%end




// OLED Search page (when you tap on search)


%hook GLUEEmptyStateView

-(void)didMoveToWindow {

if(oledSpotify) {

self.backgroundColor = [UIColor blackColor];

}

}

%end




// Hide Remove Button (Daily Mix)

%hook SPTNowPlayingFreeTierFeedbackButton

-(void)didMoveToWindow {

if(hideRemoveButton) {

self.hidden = YES;

}

}

%end




// Hide Clear Recent Searches Button

%hook SPTSearchUIRecentsClearAllHubComponentView

-(void)didMoveToWindow {

if(hideClearRecentSearchesButton) {

self.hidden = YES;

}

return %orig;

}

%end




// Hide ugly stuff in search page


%hook SPTBrowseUICardComponentView

-(void)didMoveToWindow {

if(unclutterSearchPage) {

self.hidden = YES;

}

}

%end




%hook HUGS2SectionHeaderComponentView

-(void)didMoveToWindow {

if(unclutterSearchPage) {


self.hidden = YES;

}

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
%end




  // You'll need to add another %end if you're grouping all hooks




%ctor {
  


  // Create HBPreferences instance with your identifier, usually I just add prefs to the end of my package identifier
 HBPreferences *preferences = [[HBPreferences alloc] initWithIdentifier:@"com.perfect.spotify"];

  // Register preference variables, naming the preference key and variable the same thing reduces confusion for me.

  [preferences registerBool:&enableLibraryX default:NO forKey:@"enableLibraryX"];
  [preferences registerBool:&blackoutMode default:NO forKey:@"blackoutModeEnabled"];
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


    // Check if the toggles switches are enabled from preferences then init the group hooks

    %init(EnableTweak, ConnectButton=objc_getClass("ConnectUIFeatureImpl.ConnectButtonView"));


}
