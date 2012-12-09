//
//  OCHabitat.h
//  OptiConso
//
//  Created by Thomas COLLE on 12/9/12.
//  Copyright (c) 2012 Student. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCHabitat : NSObject

@property (nonatomic, assign) int habitatId;
@property (nonatomic, assign) int habitatSurface;
@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, strong) NSString *habitatName;

- (id)initWithId:(int)theId name:(NSString *)theName selected:(BOOL)selected surface:(int)thesurface;

@end
