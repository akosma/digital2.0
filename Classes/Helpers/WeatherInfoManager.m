//
//  WeatherInfoManager.m
//  Digital 2.0
//
//  Created by Adrian on 5/21/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import "WeatherInfoManager.h"
#import "SynthesizeSingleton.h"
#import "TBXML.h"
#import "WeatherInfoItem.h"
#import "ASIHTTPRequest.h"

#define WEATHER_TAG_NAME @"weather"
#define BASE_URL @"http://www.worldweatheronline.com/feed/weather.ashx?lat=%1.4f&lon=%1.4f&num_of_days=5&key=%@"

@interface WeatherInfoManager ()

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, copy) NSString *apiKey;
@property (nonatomic, retain) NSMutableArray *weatherItems;

- (void)deserializeData:(NSData *)data;
- (void)callDelegate;

@end


@implementation WeatherInfoManager

SYNTHESIZE_SINGLETON_FOR_CLASS(WeatherInfoManager)

@synthesize apiKey = _apiKey;
@synthesize locationManager = _locationManager;
@synthesize delegate = _delegate;
@synthesize weatherItems = _weatherItems;

#pragma mark -
#pragma mark Init and dealloc

- (id)init
{
    if (self = [super init])
    {
        self.locationManager = [[[CLLocationManager alloc] init] autorelease];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        self.locationManager.distanceFilter = 500.0;
        
        self.apiKey = @"d1787f1384072206101005";
    }
    return self;
}

- (void)dealloc
{
    self.locationManager.delegate = nil;
    [self.locationManager stopUpdatingLocation];
    self.locationManager = nil;
    self.apiKey = nil;
    self.delegate = nil;
    self.weatherItems = nil;
    [super dealloc];
}

#pragma mark -
#pragma mark Public methods

- (void)retrieveWeatherInformation
{
    if (self.weatherItems == nil)
    {
        [self.locationManager startUpdatingLocation];
    }
    else 
    {
        [self callDelegate];
    }
}

#pragma mark -
#pragma mark CLLocationManagerDelegate methods

- (void)locationManager:(CLLocationManager *)manager 
    didUpdateToLocation:(CLLocation *)newLocation 
           fromLocation:(CLLocation *)oldLocation
{
    CLLocationDegrees latitude = newLocation.coordinate.latitude;
    CLLocationDegrees longitude = newLocation.coordinate.longitude;
    
    NSString *stringURL = [NSString stringWithFormat:BASE_URL, latitude, longitude, self.apiKey];
    NSURL *url = [NSURL URLWithString:stringURL];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    request.delegate = self;
    [request startAsynchronous];
}

#pragma mark -
#pragma mark ASIHTTPRequest delegate methods

- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSData *responseData = [request responseData];
    [self deserializeData:responseData];
    [self callDelegate];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
}

#pragma mark -
#pragma mark Private methods

- (void)deserializeData:(NSData *)data
{
    if (self.weatherItems == nil)
    {
        TBXML *tbxml = [TBXML tbxmlWithXMLData:data];
        TBXMLElement *root = tbxml.rootXMLElement;
        self.weatherItems = [NSMutableArray array];
        if (root) 
        {
            TBXMLElement *weatherTag = [TBXML childElementNamed:WEATHER_TAG_NAME parentElement:root];
            
            while (weatherTag != nil)
            {
                WeatherInfoItem *item = [WeatherInfoItem itemWithTBXMLElement:weatherTag];
                [self.weatherItems addObject:item];
                
                weatherTag = [TBXML nextSiblingNamed:WEATHER_TAG_NAME searchFromElement:weatherTag];
            }
        }
    }
}

- (void)callDelegate
{
    if ([self.delegate respondsToSelector:@selector(weatherInfoManager:didRetrieveWeatherInfo:)])
    {
        [self.delegate weatherInfoManager:self didRetrieveWeatherInfo:self.weatherItems];
    }
}

@end