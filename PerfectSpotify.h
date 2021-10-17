@import UIKit;
#import "MediaRemote.h"
#import <Kitten/libKitten.h>
#import <MediaRemote/MediaRemote.h>
#import <AudioToolbox/AudioServices.h>
#import <GcUniversal/GcColorPickerUtils.h>


// Colors


static BOOL enableTextColor;
static BOOL enableTintColor;
static BOOL gradientColors;
static BOOL enableBackgroundUIColor;


NSString *tintColor = @"ffffff";
NSString *tintTextColor = @"ffffff";
NSString *backgroundUIColor = @"ffffff";


// Miscellaneous


static BOOL oledSpotify;
static BOOL hideTabBarLabels;
static BOOL hideConnectButton;
static BOOL hideTabBarPlayButton;

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
static BOOL hideRemoveButton;


// Now Playing UI


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
static BOOL hideShareButton;
static BOOL hideQueueButton;

static BOOL hideSpeedButton;
static BOOL hideBackButton;
static BOOL hideForwardButton;
static BOOL hideMoonButton;

static BOOL enableSpotifyUI;
static BOOL enableHaptics;
static BOOL enableModernButtons;
static BOOL enableArtworkBasedColors;

static int hapticsStrength;

static BOOL saveCanvas;

static int saveCanvasDestination;

static BOOL centerText;
static BOOL textToTheTop;


static NSString *prefsKeys = @"/var/mobile/Library/Preferences/me.luki.perfectspotifyprefs.plist";


#define Class(string) NSClassFromString(string)


static void loadPrefs() {

	NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:prefsKeys];
	NSMutableDictionary *prefs = dict ? [dict mutableCopy] : [NSMutableDictionary dictionary];

	// Colors

	enableTextColor = prefs[@"enableTextColor"] ? [prefs[@"enableTextColor"] boolValue] : NO;
	enableTintColor = prefs[@"enableTintColor"] ? [prefs[@"enableTintColor"] boolValue] : NO;
	gradientColors = prefs[@"gradientColors"] ? [prefs[@"gradientColors"] boolValue] : NO;
	enableBackgroundUIColor = prefs[@"enableBackgroundUIColor"] ? [prefs[@"enableBackgroundUIColor"] boolValue] : NO;

	// Miscellaneous

	oledSpotify = prefs[@"oledSpotify"] ? [prefs[@"oledSpotify"] boolValue] : NO;
	hideTabBarLabels = prefs[@"hideTabBarLabels"] ? [prefs[@"hideTabBarLabels"] boolValue] : NO;
	hideConnectButton = prefs[@"hideConnectButton"] ? [prefs[@"hideConnectButton"] boolValue] : NO;
	hideTabBarPlayButton = prefs[@"hideTabBarPlayButton"] ? [prefs[@"hideTabBarPlayButton"] boolValue] : NO;

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
	hideRemoveButton = prefs[@"hideRemoveButton"] ? [prefs[@"hideRemoveButton"] boolValue] : NO;

	// Now Playing UI

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
	hideShareButton = prefs[@"hideShareButton"] ? [prefs[@"hideShareButton"] boolValue] : NO;
	hideQueueButton = prefs[@"hideQueueButton"] ? [prefs[@"hideQueueButton"] boolValue] : NO;

	enableSpotifyUI = prefs[@"enableSpotifyUI"] ? [prefs[@"enableSpotifyUI"] boolValue] : NO;
	enableHaptics = prefs[@"enableHaptics"] ? [prefs[@"enableHaptics"] boolValue] : NO;
	enableModernButtons = prefs[@"enableModernButtons"] ? [prefs[@"enableModernButtons"] boolValue] : NO;
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

}


// Colors


NSData *artworkData;
CAGradientLayer *gradient;


@interface SPTNowPlayingBackgroundViewController : UIViewController
- (void)setColors; // libKitten
@end


// Miscellaneous


@interface GLUEGradientView : UIView
@property (assign, nonatomic, readwrite) CGFloat alpha;
@end


@interface SPTHomeView : UIView
@end


@interface SPTHomeGradientBackgroundView : UIView
@end


@interface HUGSCustomViewControl : UIControl
@property UIView *contentView;
@end


@interface SPTBarGradientView : UIView
@end


@interface UIView ()
- (id)_viewControllerForAncestor;
@end


@interface GLUEEmptyStateView : UIView
@end


@interface SPTSearch2ViewController : UIViewController
@end


@interface _UIVisualEffectSubview : UIView
@end


@interface SPTNowPlayingBarPlayButton : UIButton
@end


@interface SPTEncoreLabel : UILabel
@end


@interface SPTNowPlayingFreeTierFeedbackButton : UIButton
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


@interface SPTNowPlayingAnimatedLikeButton : UIButton
@end


@interface SPTNowPlayingSliderV2 : UIView
@end


@interface SPTNowPlayingPreviousTrackButton : UIButton
@end


@interface SPTNowPlayingNextTrackButton : UIButton
@end


@interface SPTGaiaDevicesAvailableViewImplementation : UIView
@end


@interface SPTNowPlayingQueueButton : UIButton
@end


// ++ Features


// Spotify UI


@interface SPTNowPlayingHeadUnitView : UIView
@property (nonatomic, strong) UIButton *rewindButton;
@property (nonatomic, strong) UIButton *skipButton;
@property (nonatomic, strong) UIButton *playPauseButton;
- (void)rewind;
- (void)playPause;
- (void)skip;
- (void)triggerHaptics;
- (void)setupSpotifyUI;
- (void)setupSpotifyUIConstraints;
- (void)setupSpotifyUIModernButtonsConstraints;
@end


@interface SPTPlayerState : NSObject
@property (assign, getter=isPaused, nonatomic, readwrite) BOOL paused;
@end


// Canvas


@interface SPTCanvasContentLayerViewController : UIViewController
- (void)doubleTap:(UITapGestureRecognizer *)gesture;
@end


@interface SPTPopupDialog : NSObject
+ (instancetype)popupWithTitle:(NSString *)arg1 message:(NSString *)arg2 dismissButtonTitle:(NSString *)arg3;
@end


@interface SPTPopupManager : NSObject
@property (assign, nonatomic, readwrite) NSMutableArray *presentationQueue;
+ (SPTPopupManager *)sharedManager;
- (void)presentNextQueuedPopup;
@end


@interface _LSQueryResult : NSObject
@end


@interface LSResourceProxy : _LSQueryResult
@end


@interface LSBundleProxy : LSResourceProxy
@property (nonatomic, readonly) NSURL *dataContainerURL;
@end


@interface LSApplicationProxy : LSBundleProxy
+ (id)applicationProxyForIdentifier:(id)arg1;
@end


@interface UIApplication ()
- (BOOL)_openURL:(id)arg1;
@end


// Center artist and song title & align to the top


@interface SPTNowPlayingInformationUnitViewController : UIViewController
@property UIView *titleLabel;
@property UIView *subtitleLabel;
@property UIViewController *heartButtonViewController;
@end


@interface SPTNowPlayingViewController : UIViewController
@end


@interface SPTNowPlayingContentLayerViewController : UIViewController
@property UICollectionView *collectionView;
@end


@interface SPTNowPlayingCoverArtCell : UICollectionViewCell
@property (getter=_collectionView) UICollectionView *collectionView;
@property UIImageView *imageView;
@end


// For instances

id playlistController = nil;
SPTNowPlayingHeadUnitView *headUnitView = nil;
SPTCanvasContentLayerViewController *canvasContentLayerVC = nil;
