@import UIKit;
#import "MediaRemote.h"
#import <Kitten/libKitten.h>
#import <AudioToolbox/AudioServices.h>
#import <GcUniversal/GcColorPickerUtils.h>


// Miscellaneous

static BOOL oledSpotify;
static BOOL hideTabBarLabels;
static BOOL hideConnectButton;

static BOOL hideCancelButton;
static BOOL hidePlayWhatYouLoveText;
static BOOL hideClearRecentSearchesButton;

static BOOL showSongCount;
static BOOL hideEnhanceButton;
static BOOL hideAddSongsButton;
static BOOL hideQueuePopUp;
static BOOL noPopUp;

static BOOL trueShuffle;
static BOOL showStatusBar;
static BOOL disableStorylines;
static BOOL enableLyricsForAllTracks;
static BOOL disableGeniusLyrics;
static BOOL spoofIsPlayingRemotely;


// Now Playing UI

static BOOL enableKleiColors;
static BOOL enableNowPlayingUIBGColor;

static NSString *nowPlayingUIBGColor;

static BOOL hideCloseButton;
static BOOL hidePlaylistNameText;
static BOOL hideContextMenuButton;
static BOOL hideLikeButton;
static BOOL hideSliderKnob;
static BOOL hideTimeSlider;
static BOOL hideElapsedTime;
static BOOL hideRemainingTime;
static BOOL hideShuffleButton;
static BOOL hidePreviousTrackButton;
static BOOL hidePlayPauseButton;
static BOOL hideNextTrackButton;
static BOOL hideRepeatButton;
static BOOL hideDevicesButton;
static BOOL hideFeedbackButton;
static BOOL hideShareButton;
static BOOL hideQueueButton;

static BOOL hideSpeedButton;
static BOOL hideBackButton;
static BOOL hideForwardButton;
static BOOL hideMoonButton;

static BOOL enableSpotifyUI;
static BOOL enableHaptics;
static BOOL enableArtworkBasedColors;

static NSInteger hapticsStrength;

static BOOL saveCanvas;

static NSInteger saveCanvasDestination;

static BOOL centerText;
static BOOL textToTheTop;


// SpringBoard

static BOOL addPSpotifyShortcut;

static BOOL removeEditHSShortcut;
static BOOL removeShareAppShortcut;
static BOOL removeRemoveAppShortcut;

static BOOL removeSpotifySearchShortcut;
static BOOL removeSpotifyRecentlyPlayedShortcut;


static NSString *const prefsKeys = @"/var/mobile/Library/Preferences/me.luki.perfectspotifyprefs.plist";

#define kClass(string) NSClassFromString(string)
#define kIsCurrentApp(string) [[[NSBundle mainBundle] bundleIdentifier] isEqual: string]
#define kOrionExists [[NSFileManager defaultManager] fileExistsAtPath:@"/Library/MobileSubstrate/DynamicLibraries/OrionSettings.dylib"]
#define kShuffleExists [[NSFileManager defaultManager] fileExistsAtPath:@"/Library/MobileSubstrate/DynamicLibraries/shuffle.dylib"]


static void loadPrefs() {

	NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:prefsKeys];
	NSMutableDictionary *prefs = dict ? [dict mutableCopy] : [NSMutableDictionary dictionary];

	// Miscellaneous
	oledSpotify = prefs[@"oledSpotify"] ? [prefs[@"oledSpotify"] boolValue] : NO;
	hideTabBarLabels = prefs[@"hideTabBarLabels"] ? [prefs[@"hideTabBarLabels"] boolValue] : NO;
	hideConnectButton = prefs[@"hideConnectButton"] ? [prefs[@"hideConnectButton"] boolValue] : NO;

	hideCancelButton = prefs[@"hideCancelButton"] ? [prefs[@"hideCancelButton"] boolValue] : NO;
	hidePlayWhatYouLoveText = prefs[@"hidePlayWhatYouLoveText"] ? [prefs[@"hidePlayWhatYouLoveText"] boolValue] : NO;
	hideClearRecentSearchesButton = prefs[@"hideClearRecentSearchesButton"] ? [prefs[@"hideClearRecentSearchesButton"] boolValue] : NO;

	showSongCount = prefs[@"showSongCount"] ? [prefs[@"showSongCount"] boolValue] : NO;
	hideEnhanceButton = prefs[@"hideEnhanceButton"] ? [prefs[@"hideEnhanceButton"] boolValue] : NO;
	hideAddSongsButton = prefs[@"hideAddSongsButton"] ? [prefs[@"hideAddSongsButton"] boolValue] : NO;
	hideQueuePopUp = prefs[@"hideQueuePopUp"] ? [prefs[@"hideQueuePopUp"] boolValue] : NO;
	noPopUp = prefs[@"noPopUp"] ? [prefs[@"noPopUp"] boolValue] : NO;

	trueShuffle = prefs[@"trueShuffle"] ? [prefs[@"trueShuffle"] boolValue] : NO;
	showStatusBar = prefs[@"showStatusBar"] ? [prefs[@"showStatusBar"] boolValue] : NO;
	disableStorylines = prefs[@"disableStorylines"] ? [prefs[@"disableStorylines"] boolValue] : NO;
	enableLyricsForAllTracks = prefs[@"enableLyricsForAllTracks"] ? [prefs[@"enableLyricsForAllTracks"] boolValue] : NO;
	disableGeniusLyrics = prefs[@"disableGeniusLyrics"] ? [prefs[@"disableGeniusLyrics"] boolValue] : NO;
	spoofIsPlayingRemotely = prefs[@"spoofIsPlayingRemotely"] ? [prefs[@"spoofIsPlayingRemotely"] boolValue] : NO;

	// Now Playing UI
	enableKleiColors = prefs[@"enableKleiColors"] ? [prefs[@"enableKleiColors"] boolValue] : NO;
	enableNowPlayingUIBGColor = prefs[@"enableNowPlayingUIBGColor"] ? [prefs[@"enableNowPlayingUIBGColor"] boolValue] : NO;

	nowPlayingUIBGColor = prefs[@"nowPlayingUIBGColor"] ?: [prefs[@"nowPlayingUIBGColor"] stringValue];

	hideCloseButton = prefs[@"hideCloseButton"] ? [prefs[@"hideCloseButton"] boolValue] : NO;
	hidePlaylistNameText = prefs[@"hidePlaylistNameText"] ? [prefs[@"hidePlaylistNameText"] boolValue] : NO;
	hideContextMenuButton = prefs[@"hideContextMenuButton"] ? [prefs[@"hideContextMenuButton"] boolValue] : NO;
	hideLikeButton = prefs[@"hideLikeButton"] ? [prefs[@"hideLikeButton"] boolValue] : NO;
	hideSliderKnob = prefs[@"hideSliderKnob"] ? [prefs[@"hideSliderKnob"] boolValue] : NO;
	hideTimeSlider = prefs[@"hideTimeSlider"] ? [prefs[@"hideTimeSlider"] boolValue] : NO;
	hideElapsedTime = prefs[@"hideElapsedTime"] ? [prefs[@"hideElapsedTime"] boolValue] : NO;
	hideRemainingTime = prefs[@"hideRemainingTime"] ? [prefs[@"hideRemainingTime"] boolValue] : NO;
	hideShuffleButton = prefs[@"hideShuffleButton"] ? [prefs[@"hideShuffleButton"] boolValue] : NO;
	hidePreviousTrackButton = prefs[@"hidePreviousTrackButton"] ? [prefs[@"hidePreviousTrackButton"] boolValue] : NO;
	hidePlayPauseButton = prefs[@"hidePlayPauseButton"] ? [prefs[@"hidePlayPauseButton"] boolValue] : NO;
	hideNextTrackButton = prefs[@"hideNextTrackButton"] ? [prefs[@"hideNextTrackButton"] boolValue] : NO;
	hideRepeatButton = prefs[@"hideRepeatButton"] ? [prefs[@"hideRepeatButton"] boolValue] : NO;
	hideDevicesButton = prefs[@"hideDevicesButton"] ? [prefs[@"hideDevicesButton"] boolValue] : NO;
	hideFeedbackButton = prefs[@"hideFeedbackButton"] ? [prefs[@"hideFeedbackButton"] boolValue] : NO;
	hideShareButton = prefs[@"hideShareButton"] ? [prefs[@"hideShareButton"] boolValue] : NO;
	hideQueueButton = prefs[@"hideQueueButton"] ? [prefs[@"hideQueueButton"] boolValue] : NO;

	enableSpotifyUI = prefs[@"enableSpotifyUI"] ? [prefs[@"enableSpotifyUI"] boolValue] : NO;
	enableHaptics = prefs[@"enableHaptics"] ? [prefs[@"enableHaptics"] boolValue] : NO;
	enableArtworkBasedColors = prefs[@"enableArtworkBasedColors"] ? [prefs[@"enableArtworkBasedColors"] boolValue] : NO;
	hapticsStrength = prefs[@"hapticsStrength"] ? [prefs[@"hapticsStrength"] integerValue] : 2;

	saveCanvas = prefs[@"saveCanvas"] ? [prefs[@"saveCanvas"] boolValue] : NO;
	saveCanvasDestination = prefs[@"saveCanvasDestination"] ? [prefs[@"saveCanvasDestination"] integerValue] : 0;

	centerText = prefs[@"centerText"] ? [prefs[@"centerText"] boolValue] : NO;
	textToTheTop = prefs[@"textToTheTop"] ? [prefs[@"textToTheTop"] boolValue] : NO;

	hideSpeedButton = prefs[@"hideSpeedButton"] ? [prefs[@"hideSpeedButton"] boolValue] : NO;
	hideBackButton = prefs[@"hideBackButton"] ? [prefs[@"hideBackButton"] boolValue] : NO;
	hideForwardButton = prefs[@"hideForwardButton"] ? [prefs[@"hideForwardButton"] boolValue] : NO;
	hideMoonButton = prefs[@"hideMoonButton"] ? [prefs[@"hideMoonButton"] boolValue] : NO;

	// SpringBoard
	addPSpotifyShortcut = prefs[@"addPSpotifyShortcut"] ? [prefs[@"addPSpotifyShortcut"] boolValue] : NO;

	removeEditHSShortcut = prefs[@"removeEditHSShortcut"] ? [prefs[@"removeEditHSShortcut"] boolValue] : NO;
	removeShareAppShortcut = prefs[@"removeShareAppShortcut"] ? [prefs[@"removeShareAppShortcut"] boolValue] : NO;
	removeRemoveAppShortcut = prefs[@"removeRemoveAppShortcut"] ? [prefs[@"removeRemoveAppShortcut"] boolValue] : NO;

	removeSpotifySearchShortcut = prefs[@"removeSpotifySearchShortcut"] ? [prefs[@"removeSpotifySearchShortcut"] boolValue] : NO;
	removeSpotifyRecentlyPlayedShortcut = prefs[@"removeSpotifyRecentlyPlayedShortcut"] ? [prefs[@"removeSpotifyRecentlyPlayedShortcut"] boolValue] : NO;

}


// Global

static CAGradientLayer *gradient;
static UIColor *cachedPrimaryColors;
static UIColor *cachedSecondaryColors;
static UIColor *cachedBackgroundColors;


@interface SPTNowPlayingBackgroundViewController : UIViewController
- (void)setColors; // libKitten
@end


// Miscellaneous

@interface GLUEGradientView : UIView
@property (assign, nonatomic) CGFloat alpha;
@end


@interface SPTHomeView : UIView
@end


@interface SPTHomeGradientBackgroundView : UIView
@end


@interface SPTBarGradientView : UIView
@end


@interface GLUEEmptyStateView : UIView
@end


@interface SPTSearch2ViewController : UIViewController
@end


@interface SPTUIBlurView : UIView
@end


@interface SPTNowPlayingBarViewController : UIViewController
@property (nonatomic, strong) UIView *contentView;
@end


@interface SPTEncoreLabel : UILabel
- (UIViewController *)_viewControllerForAncestor;
@end


// Now Playing UI

@interface SPTNowPlayingTitleButton : UIButton
@end


@interface SPTNowPlayingMarqueeLabel : UIView
@property UIView *topLabel, *bottomLabel;
@property UIColor *textColor;
@end


@interface SPTContextMenuAccessoryButton : UIButton
@end


@interface SPTNowPlayingSliderV2 : UIView
@end


// ++ Features
// Spotify UI

@interface SPTNowPlayingHeadUnitView : UIView
@property (nonatomic, strong) UIButton *rewindButton;
@property (nonatomic, strong) UIButton *skipButton;
@property (nonatomic, strong) UIButton *playPauseButton;
@property (nonatomic, strong) UIStackView *buttonsStackView;
- (void)didTapRewindButton;
- (void)didTapPlayPauseButton;
- (void)didTapSkipButton;
- (void)sendMRCommandAndTriggerHapticsIfRequested:(MRCommand)command;
- (void)setupSpotifyUI;
- (void)setupSpotifyUIConstraints;
- (UIButton *)createButtonWithImage:(UIImage *)image forSelector:(SEL)selector;
- (void)setupSizeConstraintsForButton:(UIButton *)button;
@end


@interface SPTPlayerState : NSObject
@property (assign, getter=isPaused, nonatomic) BOOL paused;
@end


// Canvas

@interface SPTNowPlayingViewController : UIViewController
- (void)didDoubleTapCanvas;
@end


@interface SPTPopupDialog : NSObject
+ (instancetype)popupWithTitle:(NSString *)arg1 message:(NSString *)arg2 dismissButtonTitle:(NSString *)arg3;
@end


@interface SPTPopupManager : NSObject
@property (assign, nonatomic) NSMutableArray *presentationQueue;
+ (SPTPopupManager *)sharedManager;
- (void)presentNextQueuedPopup;
@end


// 3DTouch shortcut items

@interface SBSApplicationShortcutIcon : NSObject
@end


@interface SBSApplicationShortcutCustomImageIcon : SBSApplicationShortcutIcon
- (id)initWithImageData:(id)arg1 dataType:(NSInteger)arg2 isTemplate:(BOOL)arg3;
@end


@interface SBSApplicationShortcutItem : NSObject
@property (copy, nonatomic) NSString *type;
@property (copy, nonatomic) NSString *localizedTitle;
@property (copy, nonatomic) SBSApplicationShortcutIcon *icon;
@end


@interface SBIcon : NSObject
@property (copy, nonatomic, readonly) NSString *displayName;
- (id)applicationBundleID;
- (BOOL)isApplicationIcon;
@end


@interface SBIconView : NSObject
@property (nonatomic, strong) SBIcon *icon;
- (NSString *)applicationBundleIdentifier;
- (NSString *)applicationBundleIdentifierForShortcuts;
@end


@interface UIApplication ()
- (BOOL)_openURL:(NSURL *)url;
@end


// For instances

static id playlistController = nil;
static SPTNowPlayingHeadUnitView *headUnitView = nil;
static SPTNowPlayingViewController *canvasContentLayerVC = nil;
