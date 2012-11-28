//
//  OCTipSeparatorCell.m
//  OptiConso
//
//  Created by Thomas COLLE on 11/27/12.
//  Copyright (c) 2012 Student. All rights reserved.
//

#import "OCTipSeparatorCell.h"

@implementation OCTipSeparatorCell

@synthesize titleLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
