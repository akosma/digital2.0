//
//  D2WeatherInfoItem.m
//  Digital 2.0
//
//  Created by Adrian on 5/21/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import "D2WeatherInfoItem.h"

static NSString *DATE_TAG_NAME = @"date";
static NSString *TEMP_MAX_C_TAG_NAME = @"tempMaxC";
static NSString *TEMP_MIN_C_TAG_NAME = @"tempMinC";
static NSString *WIND_SPEED_KPH_TAG_NAME = @"windspeedKmph";
static NSString *WIND_DIRECTION_TAG_NAME = @"winddirection";
static NSString *WEATHER_CODE_TAG_NAME = @"weatherCode";
static NSString *WEATHER_DESC_TAG_NAME = @"weatherDesc";

@implementation D2WeatherInfoItem

@synthesize date = _date;
@synthesize maxTempC = _maxTempC;
@synthesize minTempC = _minTempC;
@synthesize windSpeedKph = _windSpeedKph;
@synthesize windDirection = _windDirection;
@synthesize weatherCode = _weatherCode;
@synthesize weatherDescription = _weatherDescription;

+ (D2WeatherInfoItem *)itemWithTBXMLElement:(TBXMLElement *)element
{
    D2WeatherInfoItem *item = [[[D2WeatherInfoItem alloc] init] autorelease];

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
    [_date release];
    [_windDirection release];
    [_weatherDescription release];
    [super dealloc];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@, wind %d kph %@, temp %d-%d", self.weatherDescription, 
            self.windSpeedKph, self.windDirection, self.minTempC, self.maxTempC];
}

@end
