//
//  OCMesConsosViewController.h
//  OptiConso
//
//  Created by Epi Mac on 11/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OCLoginViewController.h"
#import "OCModifierViewController.h"
#import "OCChangerHabitatViewController.h"

@interface OCMesConsosViewController : UIViewController <LoginViewDelegate, ModifierViewDelegate, ChangerViewDelegate, UIActionSheetDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *graphView;
@property (assign, nonatomic) BOOL connected;

- (void)LoginViewDidValidateAuthentication;
- (void)ModifierViewDidAddValue;
- (void)ChangerViewDidPickHabitat:(OCHabitat *)habitat;

- (IBAction)energyButton:(id)sender;

@end
