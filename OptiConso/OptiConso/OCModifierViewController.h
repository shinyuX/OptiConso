//
//  OCModifierViewController.h
//  OptiConso
//
//  Created by Thomas COLLE on 12/5/12.
//  Copyright (c) 2012 Student. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ModifierViewDelegate <NSObject>
- (void)ModifierViewDidAddValue:(NSInteger)value forEnergy:(NSInteger)energy date:(NSString *)date;
@end

@interface OCModifierViewController : UIViewController <UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) IBOutlet UITextField *valueField;
@property (strong, nonatomic) IBOutlet UISegmentedControl *energySC;
@property (assign, nonatomic) id<ModifierViewDelegate> delegate;

- (IBAction)validateButton:(id)sender;

@end
