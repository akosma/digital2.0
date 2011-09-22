//
//  D2StockInfoManagerDelegate.h
//  Digital 2.0
//
//  Created by Adrian on 6/20/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import <UIKit/UIKit.h>

@class D2StockInfoManager;

@protocol D2StockInfoManagerDelegate <NSObject>

@required

- (void)stockInfoManager:(D2StockInfoManager *)manager didRetrieveStockInfo:(NSArray *)stockItems;

@end
