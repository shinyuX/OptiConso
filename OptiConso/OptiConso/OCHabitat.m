//
//  OCHabitat.m
//  OptiConso
//
//  Created by Thomas COLLE on 12/9/12.
//  Copyright (c) 2012 Student. All rights reserved.
//

#import "OCHabitat.h"

@implementation OCHabitat

@synthesize habitatId;
@synthesize habitatName;
@synthesize isSelected;
@synthesize habitatSurface;

- (id)initWithId:(int)theId name:(NSString *)theName selected:(BOOL)selected surface:(int)thesurface
{
    self = [super init];
    if (self)
    {
        self.habitatId = theId;
        self.habitatName = theName;
        self.isSelected = selected;
        self.habitatSurface = thesurface;
    }
    return self;
}

@end
