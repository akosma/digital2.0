//
//  WeatherInfoManager.h
//  Digital 2.0
//
//  Created by Adrian on 5/21/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "WeatherInfoManagerDelegate.h"

@interface WeatherInfoManager : NSObject <CLLocationManagerDelegate> 
{
@private
    NSString *_apiKey;
    CLLocationManager *_locationManager;
    id<WeatherInfoManagerDelegate> _delegate;
    NSMutableArray *_weatherItems;
}

@property (nonatomic, assign) id<WeatherInfoManagerDelegate> delegate;

+ (WeatherInfoManager *)sharedWeatherInfoManager;

- (void)retrieveWeatherInformation;

@end
