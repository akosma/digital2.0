//
//  MapFeatureView.m
//  Digital 2.0
//
//  Created by Adrian on 6/19/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import "MapFeatureView.h"
#import "BoxView.h"

@interface MapFeatureView ()

@property (nonatomic, retain) MKMapView *mapView;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) BoxView *textView;

- (void)zoom;

@end



@implementation MapFeatureView

@synthesize mapView = _mapView;
@synthesize locationManager = _locationManager;
@synthesize textView = _textView;

- (id)initWithFrame:(CGRect)frame 
{
    if ((self = [super initWithFrame:frame])) 
    {
        self.mapView = [[[MKMapView alloc] initWithFrame:frame] autorelease];
        self.mapView.showsUserLocation = YES;
        self.mapView.mapType = MKMapTypeSatellite;
        self.mapView.contentMode = UIViewContentModeCenter;
        self.mapView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self addSubview:self.mapView];

        self.locationManager = [[[CLLocationManager alloc] init] autorelease];
        if (self.locationManager.locationServicesEnabled)
        {
            self.locationManager.delegate = self;
            [self.locationManager startUpdatingLocation];
        }
        else 
        {
            self.locationManager = nil;
        }

        NSString *path = [[NSBundle mainBundle] pathForResource:@"location" ofType:@"txt"];
        NSString *text = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        
        self.textView = [[[BoxView alloc] initWithFrame:CGRectMake(384.0, 580.0, 328.0, 240.0)] autorelease];
        self.textView.text = text;
        self.textView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
        [self addSubview:self.textView];
    }
    return self;
}

- (void)dealloc 
{
    [self.locationManager stopUpdatingLocation];
    self.locationManager.delegate = nil;
    self.locationManager = nil;
    self.mapView = nil;
    self.textView = nil;
    [super dealloc];
}

#pragma mark -
#pragma mark Private methods

- (void)zoom
{
    CLLocationCoordinate2D coordinate = self.locationManager.location.coordinate;
    MKCoordinateSpan span = MKCoordinateSpanMake(0.1, 0.1);
    MKCoordinateRegion region = MKCoordinateRegionMake(coordinate, span);
    [self.mapView setRegion:region animated:YES];
}

#pragma mark -
#pragma CLLocationManagerDelegate methods

- (void)locationManager:(CLLocationManager *)manager 
    didUpdateToLocation:(CLLocation *)newLocation 
           fromLocation:(CLLocation *)oldLocation
{
    [self zoom];
}

@end
