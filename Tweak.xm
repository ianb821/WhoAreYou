#import "IBWAYHeaders.h"

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