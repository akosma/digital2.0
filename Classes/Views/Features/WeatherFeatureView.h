//
//  WeatherFeatureView.h
//  Digital 2.0
//
//  Created by Adrian on 5/21/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeatureView.h"
#import "WeatherInfoManagerDelegate.h"

@interface WeatherFeatureView : FeatureView <WeatherInfoManagerDelegate,
                                             UITableViewDelegate,
                                             UITableViewDataSource>
{
@private
    UITableView *_tableView;
    NSArray *_weatherItems;
}

@end
