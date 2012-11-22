//
//  OCTipCell.h
//  OptiConso
//
//  Created by Epi Mac on 11/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OCTipCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *descLabel;
@property (nonatomic, strong) IBOutlet UIImageView *star1;
@property (nonatomic, strong) IBOutlet UIImageView *star2;
@property (nonatomic, strong) IBOutlet UIImageView *star3;
@property (nonatomic, strong) IBOutlet UIImageView *star4;
@property (nonatomic, strong) IBOutlet UIImageView *star5;

@end
