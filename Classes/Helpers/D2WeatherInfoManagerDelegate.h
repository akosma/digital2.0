//
//  D2WeatherInfoManagerDelegate.h
//  Digital 2.0
//
//  Created by Adrian on 5/21/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import <UIKit/UIKit.h>

@class D2WeatherInfoManager;

@protocol D2WeatherInfoManagerDelegate <NSObject>

@required

- (void)weatherInfoManager:(D2WeatherInfoManager *)manager didRetrieveWeatherInfo:(NSArray *)weatherItems;

@end
