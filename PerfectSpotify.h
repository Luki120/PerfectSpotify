#import <UIKit/UIKit.h>
#import <MediaRemote/MediaRemote.h>
#import <substrate.h>
#import <Foundation/Foundation.h>

UIColor* backgroundColor;
UIButton* rightButton;
UIColor* tintColor;
UIColor* setBackgroundColor;


// Interfaces give the ability to the custom Spotify class to inherit the methods from the respective iOS class, useful if the method you're trying to use isn't in the custom class.

@interface SPTContextMenuAccessoryButton : UIView
@property (nonatomic, assign, readwrite, getter=isHidden) BOOL hidden;
@end


@interface SPTNowPlayingQueueButton : UIView
@property (nonatomic, assign, readwrite, getter=isHidden) BOOL hidden;
@end


@interface SPTGaiaDevicesAvailableViewImplementation : UIView
@property (nonatomic, assign, readwrite, getter=isHidden) BOOL hidden;
@end


@interface SPTNowPlayingAnimatedLikeButton : UIView
@property (nonatomic, assign, readwrite, getter=isHidden) BOOL hidden;
@end


@interface SPTNowPlayingShuffleButton : UIView
@property (nonatomic, assign, readwrite, getter=isHidden) BOOL hidden;
@end


@interface SPTNowPlayingRepeatButton : UIView
@property (nonatomic, assign, readwrite, getter=isHidden) BOOL hidden;
@end


@interface SPTNowPlayingSliderV2 : UIView
@property (nonatomic, assign, readwrite, getter=isHidden) BOOL hidden;
@end


@interface SPTNowPlayingDurationViewV2 : UIView
@property (nonatomic, assign, readwrite, getter=isHidden) BOOL hidden;
@end


@interface SPTNowPlayingInformationUnitViewController : UIViewController
@property UIView *titleLabel, *subtitleLabel;
@end


@interface SPTNowPlayingTitleButton : UIView
@end

@interface SPTNowPlayingMarqueeLabel : UIView
@end


@interface SPTNowPlayingPreviousTrackButton : UIView
@property (nonatomic, assign, readwrite, getter=isHidden) BOOL hidden;
@end


@interface SPTNowPlayingNextTrackButton : UIView
@property (nonatomic, assign, readwrite, getter=isHidden) BOOL hidden;
@end


@interface SPTNowPlayingPlayButtonV2 : UIView
@property (nonatomic, assign, readwrite, getter=isHidden) BOOL hidden;
@end


@interface SPTSortingFilteringFilterBarView : UIView
@property (nonatomic, assign, readwrite, getter=isHidden) BOOL hidden;
@end


@interface SPTDrivingModeHeadUnitFeedbackButton : UIView
@property (nonatomic, assign, readwrite, getter=isHidden) BOOL hidden;
@end


@interface _TtC20EncoreConsumerMobile16HeaderPlayButton : UIView
@property (nonatomic, assign, readwrite, getter=isHidden) BOOL hidden;
@end


@interface _UIVisualEffectSubview : UIView
@end


@interface GLUEGradientView : UIView
@property (nonatomic, assign, readwrite) CGFloat alpha;
@end


@interface SPTHomeView : UIView
@end


@interface SPTHomeGradientBackgroundView : UIView
@end


@interface SPTHomeUIShortcutsCardView : UIView
@end


@interface UITabBarButtonLabel: UIView
@end


@interface SPTTableView : UIView
@end


@interface SPTSettingsTableViewCell : UIView
@end


@interface GLUEEmptyStateView : UIView
@end


@interface GLUEEntityRowView : UIView
@end


@interface GLUEEntityRowContentView : UIView
@end


@interface SPTNowPlayingFreeTierFeedbackButton : UIView
@end


@interface SPTDrivingModeFooterUnitViewController : UIViewController
@end


@interface SPTSearchUIRecentsClearAllHubComponentView : UIView
@end


@interface SPTPlaylistExtenderRefreshButtonCell : UIView
@end


@interface SPTNowPlayingBackgroundViewModel : UIView
@end


@interface SPTBrowseUICardComponentView : UIView
@end


@interface HUGS2SectionHeaderComponentView : UIView
@end
