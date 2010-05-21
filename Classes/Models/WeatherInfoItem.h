//
//  WeatherInfoItem.h
//  Digital 2.0
//
//  Created by Adrian on 5/21/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBXML.h"

@interface WeatherInfoItem : NSObject 
{
@private
    NSDate *_date;
    NSInteger _maxTempC;
    NSInteger _minTempC;
    NSInteger _windSpeedKph;
    NSString *_windDirection;
    NSInteger _weatherCode;
    NSString *_weatherDescription;
}

@property (nonatomic, retain) NSDate *date;
@property (nonatomic) NSInteger maxTempC;
@property (nonatomic) NSInteger minTempC;
@property (nonatomic) NSInteger windSpeedKph;
@property (nonatomic, retain) NSString *windDirection;
@property (nonatomic) NSInteger weatherCode;
@property (nonatomic, retain) NSString *weatherDescription;

+ (WeatherInfoItem *)itemWithTBXMLElement:(TBXMLElement *)element;

@end
