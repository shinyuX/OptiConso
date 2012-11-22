//
//  OCTip.h
//  OptiConso
//
//  Created by  on 10/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define OC_WATER_TIP 0
#define OC_ELEC_TIP  1
#define OC_GAZ_TIP   2

@interface OCTip : NSObject

@property (nonatomic, assign) int tipType;
@property (nonatomic, strong) NSString *tipName;
@property (nonatomic, strong) NSString *tipDescription;
@property (nonatomic, assign) int tipRank;

- (id)initWithType:(int)type name:(NSString *)name description:(NSString *)desc rank:(int)theRank;

@end
