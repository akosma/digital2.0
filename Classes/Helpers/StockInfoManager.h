//
//  StockInfoManager.h
//  Digital 2.0
//
//  Created by Adrian on 6/20/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StockInfoManagerDelegate.h"

@class ASINetworkQueue;

@interface StockInfoManager : NSObject 
{
@private
    NSArray *_stockQuotes;
    NSMutableArray *_stockItems;
    id<StockInfoManagerDelegate> _delegate;
    ASINetworkQueue *_networkQueue;
    NSInteger _requestCount;
}

@property (nonatomic, assign) id<StockInfoManagerDelegate> delegate;

+ (StockInfoManager *)sharedStockInfoManager;

- (void)retrieveStockInformation;

@end
