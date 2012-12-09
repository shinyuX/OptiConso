//
//  OCListHabitatService.m
//  OptiConso
//
//  Created by Thomas COLLE on 12/9/12.
//  Copyright (c) 2012 Student. All rights reserved.
//

#import "OCListHabitatService.h"

@implementation OCListHabitatService
@synthesize parser;
@synthesize adapter;
@synthesize urlConnection;
@synthesize delegate;
@synthesize data;
@synthesize results;

- (id)initWithDelegate:(id<LHCSDelegate>)theDelegate
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
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [defaults objectForKey:@"kToken"];
    NSString *url = [NSString stringWithFormat:@"http://opticonso.fr/api/v1/habitat/all.json?auth_token=%@", token];
    
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
                    [self.delegate LHCSDidNotFindAny];
                else
                    [self.delegate LHCSDidEndWithError];
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
        [self.delegate LHCSDidEndWithError];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    SBJsonStreamParserStatus status = [self.parser parse:data];
    if (![self.delegate isKindOfClass:[NSNull class]])
    {
        if (status == SBJsonStreamParserError)
            [self.delegate LHCSDidEndWithError];
        else
            [self.delegate LHCSDidFinishParsing:self.results];
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
    // We found a habitat array
    if ([dict objectForKey:@"habitats"])
    {
        [self parser:parserr foundArray:[dict objectForKey:@"habitats"]];
    }
    
    // We found a habitat object
    if ([dict objectForKey:@"nom"])
    {
        int theId = [[dict objectForKey:@"id"] intValue];
        int theSurface = [[dict objectForKey:@"surface"] intValue];
        NSString *name = [dict objectForKey:@"nom"];
        BOOL selected = [[dict objectForKey:@"selected"] intValue];

        OCHabitat *habitat = [[OCHabitat alloc] initWithId:theId name:name selected:selected surface:theSurface];
        [self.results addObject:habitat];
    }
    
}

@end
