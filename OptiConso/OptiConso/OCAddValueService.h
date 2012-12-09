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
- (void)AVCSDidFinishParsing;
- (void)AVCSDidEndWithError;
@end

@interface OCAddValueService : NSObject <NSURLConnectionDelegate, SBJsonStreamParserAdapterDelegate>

@property (nonatomic, strong) SBJsonStreamParser *parser;
@property (nonatomic, strong) SBJsonStreamParserAdapter *adapter;

@property (strong, nonatomic) NSURLConnection *urlConnection;
@property (assign, nonatomic) id<AVCSDelegate> delegate;
@property (strong, nonatomic) NSMutableData *data;

- (id)initWithDelegate:(id<AVCSDelegate>)delegate;
- (void)launchConnectionForEnergy:(int)theenergy date:(NSString *)thedate value:(int)thevalue;

@end