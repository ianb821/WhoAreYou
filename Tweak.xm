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

%hook NCNotificationShortLookViewController
- (void)longLookWillPresentForTransitionManager:(id)arg1 withSource:(id)arg2 {
    %orig;

    if ([[[self notificationRequest] sectionIdentifier] isEqualToString:@"com.apple.MobileSMS"]) {
        NCNotificationLongLookViewController *longLookViewController = [self _presentedLongLookViewController];
        NCNotificationLongLookView *longLookView = (NCNotificationLongLookView *)longLookViewController.view.contentView;
        NCNotificationShortLookView *shortLookView = (NCNotificationShortLookView *)self.view.contentView;
        longLookView.title = shortLookView.primaryText;
    }
}
%end

%ctor {
    @autoreleasepool {     
        NSString *application = [NSBundle mainBundle].bundleIdentifier;
        if ([application isEqualToString:@"com.apple.springboard"]) {
            %init;
        }
    }
}