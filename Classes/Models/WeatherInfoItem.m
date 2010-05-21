//
//  WeatherInfoItem.m
//  Digital 2.0
//
//  Created by Adrian on 5/21/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import "WeatherInfoItem.h"

#define DATE_TAG_NAME @"date"
#define TEMP_MAX_C_TAG_NAME @"tempMaxC"
#define TEMP_MIN_C_TAG_NAME @"tempMinC"
#define WIND_SPEED_KPH_TAG_NAME @"windspeedKmph"
#define WIND_DIRECTION_TAG_NAME @"winddirection"
#define WEATHER_CODE_TAG_NAME @"weatherCode"
#define WEATHER_DESC_TAG_NAME @"weatherDesc"

@implementation WeatherInfoItem

@synthesize date = _date;
@synthesize maxTempC = _maxTempC;
@synthesize minTempC = _minTempC;
@synthesize windSpeedKph = _windSpeedKph;
@synthesize windDirection = _windDirection;
@synthesize weatherCode = _weatherCode;
@synthesize weatherDescription = _weatherDescription;

+ (WeatherInfoItem *)itemWithTBXMLElement:(TBXMLElement *)element
{
    WeatherInfoItem *item = [[[WeatherInfoItem alloc] init] autorelease];

    TBXMLElement *dateTag = [TBXML childElementNamed:DATE_TAG_NAME parentElement:element];
    TBXMLElement *tempMaxTag = [TBXML childElementNamed:TEMP_MAX_C_TAG_NAME parentElement:element];
    TBXMLElement *tempMinTag = [TBXML childElementNamed:TEMP_MIN_C_TAG_NAME parentElement:element];
    TBXMLElement *windSpeedTag = [TBXML childElementNamed:WIND_SPEED_KPH_TAG_NAME parentElement:element];
    TBXMLElement *windDirectionTag = [TBXML childElementNamed:WIND_DIRECTION_TAG_NAME parentElement:element];
    TBXMLElement *weatherCodeTag = [TBXML childElementNamed:WEATHER_CODE_TAG_NAME parentElement:element];
    TBXMLElement *weatherDescTag = [TBXML childElementNamed:WEATHER_DESC_TAG_NAME parentElement:element];

    NSString *dateText = [NSString stringWithCString:dateTag->text encoding:NSUTF8StringEncoding];
    NSString *tempMaxText = [NSString stringWithCString:tempMaxTag->text encoding:NSUTF8StringEncoding];
    NSString *tempMinText = [NSString stringWithCString:tempMinTag->text encoding:NSUTF8StringEncoding];
    NSString *windSpeedText = [NSString stringWithCString:windSpeedTag->text encoding:NSUTF8StringEncoding];
    NSString *windDirectionText = [NSString stringWithCString:windDirectionTag->text encoding:NSUTF8StringEncoding];
    NSString *weatherCodeText = [NSString stringWithCString:weatherCodeTag->text encoding:NSUTF8StringEncoding];
    NSString *weatherDescText = [NSString stringWithCString:weatherDescTag->text encoding:NSUTF8StringEncoding];
    
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    item.date = [formatter dateFromString:dateText];
    item.maxTempC = [tempMaxText intValue];
    item.minTempC = [tempMinText intValue];
    item.windSpeedKph = [windSpeedText intValue];
    item.windDirection = windDirectionText;
    item.weatherCode = [weatherCodeText intValue];
    item.weatherDescription = weatherDescText;
    
    return item;
}

- (void)dealloc
{
    self.date = nil;
    self.windDirection = nil;
    self.weatherDescription = nil;
    [super dealloc];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@, wind %d kph %@, temp %d-%d", self.weatherDescription, 
            self.windSpeedKph, self.windDirection, self.minTempC, self.maxTempC];
}

@end
