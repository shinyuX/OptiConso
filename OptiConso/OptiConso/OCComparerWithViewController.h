//
//  OCComparerWithViewController.h
//  OptiConso
//
//  Created by Thomas COLLE on 12/12/12.
//  Copyright (c) 2012 Student. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OCCompare.h"

@interface OCComparerWithViewController : UIViewController <UIActionSheetDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *graphView;
@property (strong, nonatomic) OCCompare *compare;

- (IBAction)energyButton:(id)sender;

@end
