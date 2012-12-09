//
//  OCPickHabitatService.h
//  OptiConso
//
//  Created by Thomas COLLE on 12/9/12.
//  Copyright (c) 2012 Student. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBJson.h"
#import "OCHabitat.h"

@protocol PHCSDelegate <NSObject>
- (void)PHCSDidFinishParsing;
- (void)PHCSDidEndWithError;
@end

@interface OCPickHabitatService : NSObject <NSURLConnectionDelegate, SBJsonStreamParserAdapterDelegate>

@property (nonatomic, strong) SBJsonStreamParser *parser;
@property (nonatomic, strong) SBJsonStreamParserAdapter *adapter;

@property (strong, nonatomic) NSURLConnection *urlConnection;
@property (assign, nonatomic) id<PHCSDelegate> delegate;
@property (strong, nonatomic) NSMutableData *data;

- (id)initWithDelegate:(id<PHCSDelegate>)delegate;
- (void)launchConnectionForHabitat:(OCHabitat *)habitat;

@end
