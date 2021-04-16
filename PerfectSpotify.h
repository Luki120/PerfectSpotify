#import <UIKit/UIKit.h>
#import <MediaRemote/MediaRemote.h>
#import <Cephei/HBPreferences.h> // Import the cephei framework
#import <libKitten.h>
#import "GcColorPickerUtils.h"




//Colors


NSString* tintColor = @"ffffff";
NSString* tintTextColor = @"ffffff";
NSString* backgroundUIColor = @"ffffff";




// Text to the top


@interface SPTNowPlayingInformationUnitViewController : UIViewController
@property UIView *titleLabel;
@property UIView *subtitleLabel;
@property UIViewController *heartButtonViewController;
@end


@interface SPTNowPlayingCoverArtCell : UICollectionViewCell
@property(getter=_collectionView) UICollectionView *collectionView;
@property UIImageView *imageView;
@end


@interface SPTNowPlayingContentLayerViewController : UIViewController
@property UICollectionView *collectionView;
@end


@interface SPTNowPlayingViewController : UIViewController
- (void)setColors; // libKitten
@end


// libKitten stuff


UIImage* currentArtwork;
CAGradientLayer* gradient;


// Miscellaneous


@interface SPTHomeGradientBackgroundView : UIView
@end


@interface SPTHomeUIShortcutsCardView : UIView
@end


@interface GLUEGradientView : UIView
@property (nonatomic, assign, readwrite) CGFloat alpha;
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


// Tint Color


@interface GLUELabel : UILabel
@property (nonatomic, strong, readwrite) UIColor *textColor;
@end


@interface SPTIconConfiguration : UIView
@end


@interface SPTNowPlayingBackgroundViewController : UIViewController
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


@interface SPTNowPlayingShuffleButton : UIButton
@end


@interface SPTNowPlayingRepeatButton : UIButton
@end


@interface SPTNowPlayingSliderV2 : UIView
@end


@interface SPTNowPlayingMarqueeLabel : UIView
@property UIView *topLabel, *bottomLabel;
@property UIColor *textColor;
@end


@interface SPTNowPlayingPreviousTrackButton : UIButton
@end


@interface SPTNowPlayingPlayButtonV2 : UIButton
@end


@interface SPTNowPlayingNextTrackButton : UIButton
@end


@interface _UISlideriOSVisualElement : UIView
@end


// Car Mode UI


@interface SPTDrivingModeHeadUnitFeedbackButton : UIButton
@end


@interface SPTDrivingModeFooterUnitViewController : UIViewController
@end


// Search Page


@interface SPTBrowseUICardComponentView : UIView
@end


@interface HUGS2SectionHeaderComponentView : UIView
@end