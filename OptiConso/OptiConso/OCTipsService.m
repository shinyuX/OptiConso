//
//  OCTipsService.m
//  OptiConso
//
//  Created by Epi Mac on 11/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OCTipsService.h"

@implementation OCTipsService

@synthesize parser;
@synthesize adapter;
@synthesize urlConnection;
@synthesize delegate;
@synthesize data;
@synthesize results;

- (id)initWithDelegate:(id<TCSDelegate>)theDelegate
{
    self = [super init];
    if (self)
    {
        self.delegate = theDelegate;
        self.data = [[NSMutableData alloc] init];
        self.adapter = [[SBJsonStreamParserAdapter alloc] init];
        self.adapter.delegate = self;
        self.parser = [[SBJsonStreamParser alloc] init];
        self.parser.delegate = self.adapter;        
        self.parser.supportMultipleDocuments = YES;
        self.results = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)launchConnection
{
    self.data = [[NSMutableData alloc] init];
    [self.results removeAllObjects];
    
    NSString *url = [NSString stringWithFormat:@"http://opticonso.fr/api/v1/conseil/all.json"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10.0];  
    [request setHTTPShouldHandleCookies:NO];
    
    self.urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [self.urlConnection start];
}

#pragma mark - NSURLConnection Delegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response 
{
    if ([response isKindOfClass:[NSHTTPURLResponse class]])
    {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        int theStatusCode = [httpResponse statusCode];
        if (theStatusCode != 200)
        {
            [connection cancel];
            if (![self.delegate isKindOfClass:[NSNull class]])
            {
                if (theStatusCode == 204)
                    [self.delegate TCSDidEndWithoutResult];
                else
                    [self.delegate TCSDidEndWithError];
            }
        }
    }
}

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace
{
    return YES;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)theData
{
    [self.data appendData:theData];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if (![self.delegate isKindOfClass:[NSNull class]])
        [self.delegate TCSDidEndWithError];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    SBJsonStreamParserStatus status = [self.parser parse:data];
    if (![self.delegate isKindOfClass:[NSNull class]])
    {
        if (status == SBJsonStreamParserError)
            [self.delegate TCSDidEndWithError];
        else
            [self.delegate TCSDidFinishParsing:self.results];
    }
}

#pragma mark - SBJsonStreamParserAdapterDelegate methods

- (void)handleBarcodeContent:(NSString *)content
{
}

- (void)parser:(SBJsonStreamParser *)parserr foundArray:(NSArray *)array
{
    for (NSDictionary *dict in array)
    {
        [self parser:parserr foundObject:dict];
    }
}

- (void)parser:(SBJsonStreamParser *)parserr foundObject:(NSDictionary *)dict
{
    // We found a tips array
    if ([dict objectForKey:@"conseils"])
    {
        [self parser:parserr foundArray:[dict objectForKey:@"conseils"]];
    }
    
    // We found a tip object
    else if ([dict objectForKey:@"content"])
    {
        int rank = [[dict objectForKey:@"note"] intValue];
        NSString *name = [dict objectForKey:@"title"];
        NSString *desc = [dict objectForKey:@"content"];
        int mode = [[dict objectForKey:@"energy"] intValue];
        OCTip *currentTip = [[OCTip alloc] initWithType:mode name:name description:desc rank:rank];
        [self.results addObject:currentTip];
    }
}

@end
