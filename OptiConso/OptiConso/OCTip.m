//
//  OCTip.m
//  OptiConso
//
//  Created by  on 10/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OCTip.h"

@implementation OCTip

@synthesize tipType;
@synthesize tipName;
@synthesize tipDescription;
@synthesize tipRank;

- (id)initWithType:(int)type name:(NSString *)name description:(NSString *)desc rank:(int)theRank
{
    self = [super init];
    if (self)
    {
        self.tipType = type;
        self.tipName = name;
        self.tipDescription = desc;
        self.tipRank = theRank;
    }
    return self;
}

@end
