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
static BOOL hideArtistSongText;
static BOOL hideTimeSlider;
static BOOL hideElapsedTime;
static BOOL hideRemainingTime;
static BOOL centerText;
static BOOL enableCarMode;
static BOOL enableLyricsForAllTracks;
static BOOL disableGeniusLyrics;
static BOOL disableStorylines;
static BOOL showStatusBar;


// Connect Button in main page

%group EnableTweak

%hook _TtC22ConnectUIV2FeatureImpl20ConnectButtonFactory
-(id)provideConnectButtonView {
    if (hideConnectButton) {
        return nil;
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
-(id)color {
    if (blackoutMode) {
        return [UIColor blackColor];
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
  [preferences registerBool:&hideArtistSongText default:NO forKey:@"hideArtistSongText"];
  [preferences registerBool:&hideTimeSlider default:NO forKey:@"hideTimeSlider"];
  [preferences registerBool:&hideElapsedTime default:NO forKey:@"hideElapsedTime"];
  [preferences registerBool:&hideRemainingTime default:NO forKey:@"hideRemainingTime"];
  [preferences registerBool:&centerText default:NO forKey:@"centerText"];
  [preferences registerBool:&enableCarMode default:NO forKey:@"enableCarMode"];
  [preferences registerBool:&enableLyricsForAllTracks default:NO forKey:@"enableLyricsForAllTracks"];
  [preferences registerBool:&disableGeniusLyrics default:NO forKey:@"disableGeniusLyrics"];
  [preferences registerBool:&disableStorylines default:NO forKey:@"disableStorylines"];
  [preferences registerBool:&showStatusBar default:NO forKey:@"showStatusBar"];

   // Check if the toggles switches are enabled from preferences then init the group hooks

    %init(EnableTweak);
}
