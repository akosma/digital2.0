//
//  D2WeatherInfoManager.h
//  Digital 2.0
//
//  Created by Adrian on 5/21/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "D2WeatherInfoManagerDelegate.h"

@interface D2WeatherInfoManager : NSObject 

@property (nonatomic, assign) id<D2WeatherInfoManagerDelegate> delegate;

+ (D2WeatherInfoManager *)sharedD2WeatherInfoManager;

- (void)retrieveWeatherInformation;

@end
