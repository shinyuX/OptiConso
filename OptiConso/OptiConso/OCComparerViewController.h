//
//  OCComparerViewController.h
//  OptiConso
//
//  Created by Thomas COLLE on 12/12/12.
//  Copyright (c) 2012 Student. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OCListCompareService.h"
#import "OCComparerWithViewController.h"

@interface OCComparerViewController : UITableViewController <UIAlertViewDelegate, LCCSDelegate>

@property (strong, nonatomic) NSMutableArray *compareList;
@property (strong, nonatomic) OCCompare *compare;
@property (strong, nonatomic) OCListCompareService *LCCS;

- (void)LCCSDidFinishParsing:(NSMutableArray *)results;
- (void)LCCSDidNotFindAny;
- (void)LCCSDidEndWithError;

@end
