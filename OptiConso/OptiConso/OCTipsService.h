//
//  OCTipsService.h
//  OptiConso
//
//  Created by Epi Mac on 11/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBJson.h"
#import "OCTip.h"

@protocol TCSDelegate <NSObject>
- (void)TCSDidFinishParsing:(NSMutableArray *)results;
- (void)TCSDidEndWithError;
- (void)TCSDidEndWithoutResult;
@end

@interface OCTipsService : NSObject <NSURLConnectionDelegate, SBJsonStreamParserAdapterDelegate>

@property (nonatomic, strong) SBJsonStreamParser *parser;
@property (nonatomic, strong) SBJsonStreamParserAdapter *adapter;

@property (strong, nonatomic) NSURLConnection *urlConnection;
@property (assign, nonatomic) id<TCSDelegate> delegate;
@property (strong, nonatomic) NSMutableData *data;
@property (strong, nonatomic) NSMutableArray *results;

- (id)initWithDelegate:(id<TCSDelegate>)delegate;
- (void)launchConnection;

@end
