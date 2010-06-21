//
//  MapFeatureView.m
//  Digital 2.0
//
//  Created by Adrian on 6/19/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import "MapFeatureView.h"
#import "BoxView.h"
#import "DemoAppDelegate.h"

@interface MapFeatureView ()

@property (nonatomic, retain) MKMapView *mapView;
@property (nonatomic, retain) BoxView *textView;

@end



@implementation MapFeatureView

@synthesize mapView = _mapView;
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

        CLLocationCoordinate2D coordinate = [DemoAppDelegate sharedAppDelegate].locationManager.location.coordinate;
        CLLocationCoordinate2D center = {coordinate.latitude -= 0.0001, coordinate.longitude += 0.0001};
        MKCoordinateSpan span = MKCoordinateSpanMake(0.001, 0.001);
        MKCoordinateRegion region = MKCoordinateRegionMake(center, span);
        [self.mapView setRegion:region animated:YES];
        
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
    self.mapView = nil;
    self.textView = nil;
    [super dealloc];
}

@end
