//
//  D2StockInfoManager.h
//  Digital 2.0
//
//  Created by Adrian on 6/20/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "D2StockInfoManagerDelegate.h"


@interface D2StockInfoManager : NSObject 

@property (nonatomic, assign) id<D2StockInfoManagerDelegate> delegate;

+ (D2StockInfoManager *)sharedD2StockInfoManager;

- (void)retrieveStockInformation;

@end
