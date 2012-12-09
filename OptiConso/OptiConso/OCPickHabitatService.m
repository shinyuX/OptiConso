//
//  OCPickHabitatService.m
//  OptiConso
//
//  Created by Thomas COLLE on 12/9/12.
//  Copyright (c) 2012 Student. All rights reserved.
//

#import "OCPickHabitatService.h"

@implementation OCPickHabitatService
@synthesize parser;
@synthesize adapter;
@synthesize urlConnection;
@synthesize delegate;
@synthesize data;

- (id)initWithDelegate:(id<PHCSDelegate>)theDelegate
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
    }
    return self;
}

- (void)launchConnectionForHabitat:(OCHabitat *)habitat
{
    self.data = [[NSMutableData alloc] init];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [defaults objectForKey:@"kToken"];
    NSString *url = [NSString stringWithFormat:@"http://opticonso.fr/api/v1/habitat/select.json?auth_token=%@", token];
    
    NSString *bodyContent = [NSString stringWithFormat:@"id=%d", habitat.habitatId];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10.0];  
    [request setHTTPShouldHandleCookies:NO];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[bodyContent dataUsingEncoding:NSUTF8StringEncoding]];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
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
                [self.delegate PHCSDidEndWithError];
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
        [self.delegate PHCSDidEndWithError];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    SBJsonStreamParserStatus status = [self.parser parse:data];
    if (![self.delegate isKindOfClass:[NSNull class]])
    {
        if (status == SBJsonStreamParserError)
            [self.delegate PHCSDidEndWithError];
        else
            [self.delegate PHCSDidFinishParsing];
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
    // We found a message object
    if ([dict objectForKey:@"message"])
    {
    }
}

@end
