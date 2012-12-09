//
//  OCListHabitatService.h
//  OptiConso
//
//  Created by Thomas COLLE on 12/9/12.
//  Copyright (c) 2012 Student. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBJson.h"
#import "OCHabitat.h"

@protocol LHCSDelegate <NSObject>
- (void)LHCSDidFinishParsing:(NSMutableArray *)results;
- (void)LHCSDidNotFindAny;
- (void)LHCSDidEndWithError;
@end

@interface OCListHabitatService : NSObject <NSURLConnectionDelegate, SBJsonStreamParserAdapterDelegate>

@property (nonatomic, strong) SBJsonStreamParser *parser;
@property (nonatomic, strong) SBJsonStreamParserAdapter *adapter;

@property (strong, nonatomic) NSURLConnection *urlConnection;
@property (assign, nonatomic) id<LHCSDelegate> delegate;
@property (strong, nonatomic) NSMutableData *data;
@property (strong, nonatomic) NSMutableArray *results;

- (id)initWithDelegate:(id<LHCSDelegate>)delegate;
- (void)launchConnection;

@end
