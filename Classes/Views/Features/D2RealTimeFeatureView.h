//
//  D2RealTimeFeatureView.h
//  Digital 2.0
//
//  Created by Adrian on 5/21/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import "D2FeatureView.h"
#import "WeatherInfoManagerDelegate.h"
#import "StockInfoManagerDelegate.h"

@class BoxView;

@interface D2RealTimeFeatureView : D2FeatureView <WeatherInfoManagerDelegate,
                                                  StockInfoManagerDelegate,
                                                  UITableViewDelegate,
                                                  UITableViewDataSource>

@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UIView *descriptionPlaceholder;
@property (nonatomic, retain) IBOutlet UIView *weatherInfoPlaceholder;
@property (nonatomic, retain) IBOutlet UIView *stockInfoPlaceholder;
@property (nonatomic, retain) IBOutlet UILabel *stockTitleLabel;
@property (nonatomic, retain) IBOutlet UILabel *meteoTitleLabel;
@property (nonatomic, retain) IBOutlet UIView *mainView;

@end