//
//  OCCompare.m
//  OptiConso
//
//  Created by Thomas COLLE on 12/12/12.
//  Copyright (c) 2012 Student. All rights reserved.
//

#import "OCCompare.h"

@implementation OCCompare
@synthesize habitatId;
@synthesize habitatName;
@synthesize habitatSurface;
@synthesize userId;
@synthesize userName;

- (id)initWithUserId:(int)theUserId userName:(NSString *)theUserName habitatName:(NSString *)theHabitatName habitatId:(int)theHabitatId surface:(int)thesurface
{
    self = [super init];
    if (self)
    {
        self.habitatId = theHabitatId;
        self.habitatName = theHabitatName;
        self.habitatSurface = thesurface;
        self.userId = theUserId;
        self.userName = theUserName;
    }
    return self;
}

@end
