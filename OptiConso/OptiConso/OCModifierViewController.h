//
//  OCModifierViewController.h
//  OptiConso
//
//  Created by Thomas COLLE on 12/5/12.
//  Copyright (c) 2012 Student. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OCAddValueService.h"

@protocol ModifierViewDelegate <NSObject>
- (void)ModifierViewDidAddValue;
@end

@interface OCModifierViewController : UIViewController <UIAlertViewDelegate, AVCSDelegate>

@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) IBOutlet UITextField *valueField;
@property (strong, nonatomic) IBOutlet UISegmentedControl *energySC;
@property (strong, nonatomic) OCAddValueService *AVCS;
@property (assign, nonatomic) id<ModifierViewDelegate> delegate;

- (IBAction)validateButton:(id)sender;

- (void)AVCSDidFinishParsing;
- (void)AVCSDidEndWithError;

@end
