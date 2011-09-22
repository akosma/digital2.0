//
//  D2MapFeatureView.m
//  Digital 2.0
//
//  Created by Adrian on 6/19/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import "D2MapFeatureView.h"
#import "D2BoxView.h"
#import "D2AppDelegate.h"

@interface D2MapFeatureView ()

@property (nonatomic, retain) MKMapView *mapView;
@property (nonatomic, retain) D2BoxView *textView;

@end



@implementation D2MapFeatureView

@synthesize mapView = _mapView;
@synthesize textView = _textView;

- (id)initWithFrame:(CGRect)frame 
{
    if ((self = [super initWithFrame:frame])) 
    {
        self.requiresNetwork = YES;

        self.mapView = [[[MKMapView alloc] initWithFrame:frame] autorelease];
        self.mapView.showsUserLocation = YES;
        self.mapView.mapType = MKMapTypeSatellite;
        self.mapView.contentMode = UIViewContentModeCenter;
        self.mapView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self addSubview:self.mapView];

        CLLocationCoordinate2D coordinate = [D2AppDelegate sharedAppDelegate].locationManager.location.coordinate;
        CLLocationCoordinate2D center = {coordinate.latitude -= 0.0001, coordinate.longitude += 0.0001};
        MKCoordinateSpan span = MKCoordinateSpanMake(0.00105, 0.00105);
        MKCoordinateRegion region = MKCoordinateRegionMake(center, span);
        [self.mapView setRegion:region animated:YES];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"location" ofType:@"txt"];
        NSString *text = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        
        self.textView = [[[D2BoxView alloc] initWithFrame:CGRectMake(384.0, 580.0, 328.0, 240.0)] autorelease];
        self.textView.text = text;
        self.textView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
        [self addSubview:self.textView];
    }
    return self;
}

- (void)dealloc 
{
    [_mapView release];
    [_textView release];
    [super dealloc];
}

@end
