@import UIKit;
#import "MediaRemote.h"
#import <Kitten/libKitten.h>
#import <MediaRemote/MediaRemote.h>
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

static BOOL centerText;
static BOOL textToTheTop;

static BOOL hideSpeedButton;
static BOOL hideBackButton;
static BOOL hideForwardButton;
static BOOL hideMoonButton;


static NSString *prefsKeys = @"/var/mobile/Library/Preferences/me.luki.perfectspotifyprefs.plist";


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

	centerText = prefs[@"centerText"] ? [prefs[@"centerText"] boolValue] : NO;
	textToTheTop = prefs[@"textToTheTop"] ? [prefs[@"textToTheTop"] boolValue] : NO;

	hideSpeedButton = prefs[@"hideSpeedButton"] ? [prefs[@"hideSpeedButton"] boolValue] : NO;
	hideBackButton = prefs[@"hideBackButton"] ? [prefs[@"hideBackButton"] boolValue] : NO;
	hideForwardButton = prefs[@"hideForwardButton"] ? [prefs[@"hideForwardButton"] boolValue] : NO;
	hideMoonButton = prefs[@"hideMoonButton"] ? [prefs[@"hideMoonButton"] boolValue] : NO;

}


// Text to the top


@interface SPTNowPlayingInformationUnitViewController : UIViewController
@property UIView *titleLabel;
@property UIView *subtitleLabel;
@property UIViewController *heartButtonViewController;
@end


@interface SPTNowPlayingCoverArtCell : UICollectionViewCell
@property (getter=_collectionView) UICollectionView *collectionView;
@property UIImageView *imageView;
@end


@interface SPTNowPlayingContentLayerViewController : UIViewController
@property UICollectionView *collectionView;
@end


@interface SPTNowPlayingViewController : UIViewController
@end


// libKitten stuff

NSData *artworkData;
UIImage *currentArtwork;
CAGradientLayer *gradient;


// Miscellaneous


@interface SPTHomeGradientBackgroundView : UIView
@end


@interface HUGSCustomViewControl : UIView
@property UIView *contentView;
@end


@interface GLUEGradientView : UIView
@property (nonatomic, assign, readwrite) CGFloat alpha;
@end


@interface SPTBarGradientView : UIView
@end


@interface SPTHomeView : UIView
@end


@interface SPTSearch2ViewController : UIViewController
@end


@interface GLUEEmptyStateView : UIView
@end


@interface _UIVisualEffectSubview : UIView
@end


@interface SPTSortingFilteringFilterBarView : UIView
@end


@interface UITabBarButtonLabel: UIView
@end


@interface SPTNowPlayingFreeTierFeedbackButton : UIButton
@end


@interface SPTNowPlayingShareButtonViewController : UIViewController
@end


@interface SPTNowPlayingBarPlayButton : UIButton
@end


@interface SPTSnackbarView : UIView
@end


@interface SPTProgressView : UIView
@end


@interface UIView ()
- (id)_viewControllerForAncestor;
@end


UIViewController *ancestor;


// Tint Color


@interface GLUELabel : UILabel
@property (nonatomic, strong, readwrite) UIColor *textColor;
@end


@interface SPTIconConfiguration : UIView
@end


@interface SPTNowPlayingBackgroundViewController : UIViewController
- (void)setColors; // libKitten
@end


// Now Playing UI


@interface SPTGaiaDevicesAvailableViewImplementation : UIView
@end


@interface SPTNowPlayingTitleButton : UIButton
@end


@interface SPTContextMenuAccessoryButton : UIButton
@end


@interface SPTNowPlayingQueueButton : UIButton
@end


@interface SPTNowPlayingAnimatedLikeButton : UIButton
@end


@interface SPTNowPlayingSliderV2 : UIView
@end


@interface SPTNowPlayingMarqueeLabel : UIView
@property UIView *topLabel, *bottomLabel;
@property UIColor *textColor;
@end


@interface SPTNowPlayingPreviousTrackButton : UIButton
@end


@interface SPTNowPlayingNextTrackButton : UIButton
@end


@interface _TtC12EncoreMobileP33_B5AC1D940E67B9CC1AA7D284C3953D9112EncoreButton : UIView
@property UIImageView *imageView;
- (id)_viewControllerForAncestor;
@end


@interface _UISlideriOSVisualElement : UIView
@end


// Spotify UI


@interface SPTNowPlayingPlaybackActionsHandlerImplementation : NSObject
@property BOOL isPaused;
@end


@interface SPTNowPlayingHeadUnitView : UIView
/*@property (nonatomic, strong) UIButton *rewindButton;
@property (nonatomic, strong) UIButton *skipButton;
@property (nonatomic, strong) UIButton *playPauseButton;
- (void)rewind:(UIButton *)sender;
- (void)skip:(UIButton *)sender;
- (void)playPause:(UIButton *)sender*/
@end


SPTNowPlayingHeadUnitView *headUnitView = nil;

//UIImage *skipButtonImage = [UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/PerfectSpotify.bundle/skip.png"];
//UIImage *playPauseButtonImage = [UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/PerfectSpotify.bundle/play.png"];
