//
//  OCAuthenticationService.h
//  OptiConso
//
//  Created by Epi Mac on 11/13/12.
//  Copyright (c) 2012 OptiConso. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SBJson.h"

@protocol ACSDelegate <NSObject>
- (void)ACSDidFinishParsing:(NSString *)token;
- (void)ACSDidEndWithError;
@end

@interface OCAuthenticationService : NSObject <NSURLConnectionDelegate, SBJsonStreamParserAdapterDelegate>

@property (nonatomic, strong) SBJsonStreamParser *parser;
@property (nonatomic, strong) SBJsonStreamParserAdapter *adapter;

@property (strong, nonatomic) NSURLConnection *urlConnection;
@property (assign, nonatomic) id<ACSDelegate> delegate;
@property (strong, nonatomic) NSMutableData *data;
@property (strong, nonatomic) NSString *token;

- (id)initWithDelegate:(id<ACSDelegate>)delegate;
- (void)launchConnectionForUsername:(NSString *)username pass:(NSString *)pass;

@end
