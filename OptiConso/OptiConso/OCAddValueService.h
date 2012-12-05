//
//  OCAddValueService.h
//  OptiConso
//
//  Created by Thomas COLLE on 12/5/12.
//  Copyright (c) 2012 Student. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBJson.h"

@protocol AVCSDelegate <NSObject>
- (void)AVCSDidFinishParsing:(NSMutableArray *)results;
- (void)AVCSDidEndWithError;
@end

@interface OCAddValueService : NSObject <NSURLConnectionDelegate, SBJsonStreamParserAdapterDelegate>

@property (nonatomic, strong) SBJsonStreamParser *parser;
@property (nonatomic, strong) SBJsonStreamParserAdapter *adapter;

@property (strong, nonatomic) NSURLConnection *urlConnection;
@property (assign, nonatomic) id<AVCSDelegate> delegate;
@property (strong, nonatomic) NSMutableData *data;
@property (strong, nonatomic) NSMutableArray *results;

- (id)initWithDelegate:(id<AVCSDelegate>)delegate;
- (void)launchConnection;

@end