//
//  StockInfoManagerDelegate.h
//  Digital 2.0
//
//  Created by Adrian on 6/20/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StockInfoManager;

@protocol StockInfoManagerDelegate <NSObject>

@required

- (void)stockInfoManager:(StockInfoManager *)manager didRetrieveStockInfo:(NSArray *)stockItems;

@end
