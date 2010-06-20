//
//  StockInfoManager.m
//  Digital 2.0
//
//  Created by Adrian on 6/20/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import "StockInfoManager.h"
#import "SynthesizeSingleton.h"
#import "ASIHTTPRequest.h"
#import "ASINetworkQueue.h"
#import "JSON.h"

#define BASE_URL @"http://finance.google.com/finance/info?client=ig&q=NASDAQ:%@"

@interface StockInfoManager ()

@property (nonatomic, retain) NSArray *stockQuotes;
@property (nonatomic, retain) NSMutableArray *stockItems;
@property (nonatomic, retain) ASINetworkQueue *networkQueue;
@property (nonatomic) NSInteger requestCount;

- (void)callDelegate;

@end


@implementation StockInfoManager

SYNTHESIZE_SINGLETON_FOR_CLASS(StockInfoManager)

@synthesize stockQuotes = _stockQuotes;
@synthesize stockItems = _stockItems;
@synthesize delegate = _delegate;
@synthesize networkQueue = _networkQueue;
@synthesize requestCount = _requestCount;

- (id)init
{
    if (self = [super init])
    {
        self.networkQueue = [[[ASINetworkQueue alloc] init] autorelease];
        self.networkQueue.shouldCancelAllRequestsOnFailure = NO;
        self.networkQueue.delegate = self;
        self.networkQueue.requestDidFinishSelector = @selector(requestDone:);
        self.networkQueue.requestDidFailSelector = @selector(requestWentWrong:);
        self.networkQueue.queueDidFinishSelector = @selector(queueFinished:);
        [self.networkQueue go];
        
        self.requestCount = 1;
        
        self.stockQuotes = [NSArray arrayWithObjects:@"AAPL", @"MSFT", @"GOOG", @"YHOO", @"ORCL", @"INTC", @"CSCO", @"DELL", nil];
    }
    return self;
}

- (void)dealloc
{
    self.delegate = nil;
    self.stockQuotes = nil;
    self.stockItems = nil;
    self.networkQueue = nil;
    [super dealloc];
}

#pragma mark -
#pragma mark Public methods

- (void)retrieveStockInformation
{
    if (self.stockItems == nil)
    {
        self.stockItems = [NSMutableArray array];
        for (NSString *stock in self.stockQuotes)
        {
            NSString *urlString = [NSString stringWithFormat:BASE_URL, stock];
            NSURL *url = [NSURL URLWithString:urlString];
            ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
            [self.networkQueue addOperation:request];
        }
    }
    else
    {
        [self callDelegate];
    }
}

#pragma mark -
#pragma mark ASINetworkQueue delegate methods

- (void)requestDone:(ASIHTTPRequest *)request
{
    @synchronized(self)
    {
        self.requestCount += 1;
    }
    NSString *string = [[request responseString] stringByReplacingOccurrencesOfString:@"//" withString:@""];
    NSDictionary *data = [[string JSONValue] objectAtIndex:0];
    [self.stockItems addObject:data];
    
    @synchronized(self)
    {
        if (self.requestCount == [self.stockQuotes count])
        {
            [self callDelegate];
        }
    }
}

- (void)requestWentWrong:(ASIHTTPRequest *)request
{
}

- (void)queueFinished:(ASINetworkQueue *)queue
{
}

#pragma mark -
#pragma mark Private methods

- (void)callDelegate
{
    if ([self.delegate respondsToSelector:@selector(stockInfoManager:didRetrieveStockInfo:)])
    {
        [self.delegate stockInfoManager:self didRetrieveStockInfo:self.stockItems];
    }
}

@end
