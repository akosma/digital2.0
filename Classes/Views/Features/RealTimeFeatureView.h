//
//  RealTimeFeatureView.h
//  Digital 2.0
//
//  Created by Adrian on 5/21/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeatureView.h"
#import "WeatherInfoManagerDelegate.h"
#import "StockInfoManagerDelegate.h"

@class BoxView;

@interface RealTimeFeatureView : FeatureView <WeatherInfoManagerDelegate,
                                             StockInfoManagerDelegate,
                                             UITableViewDelegate,
                                             UITableViewDataSource>
{
@private
    UITableView *_weatherTableView;
    UITableView *_stockTableView;
    NSArray *_weatherItems;
    NSArray *_stockItems;
    
    UILabel *_titleLabel;
    UIView *_descriptionPlaceholder;
    UIView *_weatherInfoPlaceholder;
    UIView *_stockInfoPlaceholder;
    UILabel *_stockTitleLabel;
    UILabel *_meteoTitleLabel;
    UIView *_mainView;
    
    BoxView *_boxView;
}

@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UIView *descriptionPlaceholder;
@property (nonatomic, retain) IBOutlet UIView *weatherInfoPlaceholder;
@property (nonatomic, retain) IBOutlet UIView *stockInfoPlaceholder;
@property (nonatomic, retain) IBOutlet UILabel *stockTitleLabel;
@property (nonatomic, retain) IBOutlet UILabel *meteoTitleLabel;
@property (nonatomic, retain) IBOutlet UIView *mainView;

@end
