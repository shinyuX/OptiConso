//
//  OCAddValueService.m
//  OptiConso
//
//  Created by Thomas COLLE on 12/5/12.
//  Copyright (c) 2012 Student. All rights reserved.
//

#import "OCAddValueService.h"

@implementation OCAddValueService
@synthesize parser;
@synthesize adapter;
@synthesize urlConnection;
@synthesize delegate;
@synthesize data;
@synthesize results;

- (id)initWithDelegate:(id<AVCSDelegate>)theDelegate
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
                [self.delegate AVCSDidEndWithError];
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
        [self.delegate AVCSDidEndWithError];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    SBJsonStreamParserStatus status = [self.parser parse:data];
    if (![self.delegate isKindOfClass:[NSNull class]])
    {
        if (status == SBJsonStreamParserError)
            [self.delegate AVCSDidEndWithError];
        else
            [self.delegate AVCSDidFinishParsing:self.results];
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
}

@end