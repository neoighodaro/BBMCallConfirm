#import <UIKit/UIKit.h>

static BOOL shownCallConfirmation;

@interface BBMUserViewController : NSObject <UIAlertViewDelegate>
-(void)callUser;
@end


@interface BBMConversationViewController : NSObject <UIAlertViewDelegate>
-(void)callIconTapped;
@end


%hook BBMUserViewController

-(void) callUser {
  if ( ! shownCallConfirmation) {
    UIAlertView *confirmation = [[UIAlertView alloc] initWithTitle:@"Are You Sure?" message:@"Are you sure you want to place a BBM call this user?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Call", nil];
    [confirmation show];
    [confirmation release];

  } else {
    NSLog(@"Calling user");
    shownCallConfirmation = NO;
    %orig;
  }
}


%new
- (void)alertView:(UIAlertView *)alert clickedButtonAtIndex:(NSInteger)buttonIndex {
  if (buttonIndex == 1) {
    shownCallConfirmation = YES;
    [self callUser];
  }
}

%end




%hook BBMConversationViewController

-(void) callIconTapped {
  if ( ! shownCallConfirmation) {
    UIAlertView *confirmation = [[UIAlertView alloc] initWithTitle:@"Are You Sure?" message:@"Are you sure you want to place a BBM call this user?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Call", nil];
    [confirmation show];
    [confirmation release];

  } else {
    shownCallConfirmation = NO;
    %orig;
  }
}

%new
- (void)alertView:(UIAlertView *)alert clickedButtonAtIndex:(NSInteger)buttonIndex {
  if (buttonIndex == 1) {
    shownCallConfirmation = YES;
    [self callIconTapped];
  }
}
%end