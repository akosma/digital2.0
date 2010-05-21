//
//  WeatherInfoManagerDelegate.h
//  Digital 2.0
//
//  Created by Adrian on 5/21/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WeatherInfoManager;

@protocol WeatherInfoManagerDelegate <NSObject>

@required

- (void)weatherInfoManager:(WeatherInfoManager *)manager didRetrieveWeatherInfo:(NSArray *)weatherItems;

@end
