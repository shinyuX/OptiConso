//
//  OCConseilTableViewController.h
//  OptiConso
//
//  Created by  on 10/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OCTipsService.h"
#import "OCTipCell.h"
#import "OCTipSeparatorCell.h"

@interface OCConseilTableViewController : UITableViewController <TCSDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) NSMutableArray *waterTips;
@property (nonatomic, strong) NSMutableArray *elecTips;
@property (nonatomic, strong) NSMutableArray *gazTips;
@property (nonatomic, strong) OCTipsService *TCS;

- (void)TCSDidFinishParsing:(NSMutableArray *)results;
- (void)TCSDidEndWithError;
- (void)TCSDidEndWithoutResult;

@end
