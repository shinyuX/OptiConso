//
//  OCListCompareService.h
//  OptiConso
//
//  Created by Thomas COLLE on 12/12/12.
//  Copyright (c) 2012 Student. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBJson.h"
#import "OCCompare.h"

@protocol LCCSDelegate <NSObject>
- (void)LCCSDidFinishParsing:(NSMutableArray *)results;
- (void)LCCSDidNotFindAny;
- (void)LCCSDidEndWithError;
@end

@interface OCListCompareService : NSObject <NSURLConnectionDelegate, SBJsonStreamParserAdapterDelegate>

@property (nonatomic, strong) SBJsonStreamParser *parser;
@property (nonatomic, strong) SBJsonStreamParserAdapter *adapter;

@property (strong, nonatomic) NSURLConnection *urlConnection;
@property (assign, nonatomic) id<LCCSDelegate> delegate;
@property (strong, nonatomic) NSMutableData *data;
@property (strong, nonatomic) NSMutableArray *results;

- (id)initWithDelegate:(id<LCCSDelegate>)delegate;
- (void)launchConnection;

@end
