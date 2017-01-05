#import <UIKit/UIKit.h>

@class NCNotificationShortLookViewController;

@interface NCNotificationRequest : NSObject
- (NSString *)sectionIdentifier;
@end

@interface _NCNotificationViewControllerView : UIView
@property (assign,nonatomic) UIView *contentView;
@end

@interface NCNotificationLongLookViewController: UIViewController
@property (nonatomic,retain) _NCNotificationViewControllerView *view;
-(NCNotificationShortLookViewController *)_presentingNotificationViewController;
@end

@interface NCNotificationShortLookViewController : UIViewController
@property (nonatomic,retain) _NCNotificationViewControllerView *view;

- (NCNotificationRequest *)notificationRequest;
- (NCNotificationLongLookViewController *)_presentedLongLookViewController;
@end

@interface NCNotificationLongLookView : UIView
@property (nonatomic,copy) NSString *title;
@end

@interface NCNotificationShortLookView : UIView
@property (nonatomic,copy) NSString *primaryText;
@end
