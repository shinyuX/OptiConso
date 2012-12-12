//
//  OCCompare.h
//  OptiConso
//
//  Created by Thomas COLLE on 12/12/12.
//  Copyright (c) 2012 Student. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCCompare : NSObject

@property (nonatomic, assign) int userId;
@property (nonatomic, assign) int habitatId;
@property (nonatomic, assign) int habitatSurface;
@property (nonatomic, strong) NSString *habitatName;
@property (nonatomic, strong) NSString *userName;

- (id)initWithUserId:(int)theUserId userName:(NSString *)theUserName habitatName:(NSString *)theHabitatName habitatId:(int)theHabitatId surface:(int)thesurface;

@end
