//
//  OCLoginViewController.h
//  OptiConso
//
//  Created by Epi Mac on 11/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OCAuthenticationService.h"

@protocol LoginViewDelegate <NSObject>
- (void)LoginViewDidValidateAuthentication;
@end

@interface OCLoginViewController : UIViewController <ACSDelegate, UITextFieldDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UITextField *usernameText;
@property (strong, nonatomic) IBOutlet UITextField *passText;
@property (assign, nonatomic) id<LoginViewDelegate> delegate;
@property (strong, nonatomic) OCAuthenticationService *ACS;

- (IBAction)validateButton:(id)sender;

- (void)ACSDidFinishParsing:(NSString *)token;
- (void)ACSDidEndWithError;

@end
