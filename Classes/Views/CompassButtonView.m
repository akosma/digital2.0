//
//  CompassButtonView.m
//  Digital 2.0
//
//  Created by Adrian on 5/8/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import "CompassButtonView.h"

CGFloat degreesToRadians(double radians)
{
    return M_PI * radians / 180.0;
}

@interface CompassButtonView ()

@property (nonatomic, retain) UIImageView *compassNeedleImageView;
@property (nonatomic, retain) CLLocationManager *locationManager;

@end


@implementation CompassButtonView

@synthesize compassNeedleImageView = _compassNeedleImageView;
@synthesize locationManager = _locationManager;
@synthesize orientation = _orientation;

- (void)subclassSetup
{
    self.compassNeedleImageView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"button_31_needle.png"]] autorelease];
    [self addSubview:self.compassNeedleImageView];

    self.locationManager = [[[CLLocationManager alloc] init] autorelease];
    if (self.locationManager.headingAvailable)
    {
        self.locationManager.delegate = self;
        self.locationManager.headingFilter = kCLHeadingFilterNone;
        [self.locationManager startUpdatingHeading];
    }
    else 
    {
        self.locationManager = nil;
    }
}

- (void)dealloc 
{
    [self.locationManager stopUpdatingHeading];
    self.locationManager.delegate = nil;
    self.locationManager = nil;
    self.compassNeedleImageView = nil;
    [super dealloc];
}

#pragma mark -
#pragma CLLocationManagerDelegate methods

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    CGFloat angle = degreesToRadians(360.0 - newHeading.trueHeading);
    switch (self.orientation) 
    {
        case UIInterfaceOrientationPortrait:
            break;
            
        case UIInterfaceOrientationPortraitUpsideDown:
            angle += M_PI;
            break;
            
        case UIInterfaceOrientationLandscapeLeft:
            angle += M_PI / 2.0;
            break;
            
        case UIInterfaceOrientationLandscapeRight:
            angle -= M_PI / 2.0;
            break;

        default:
            break;
    }
    [UIView beginAnimations:nil context:NULL];
    self.compassNeedleImageView.transform = CGAffineTransformMakeRotation(angle);
    [UIView commitAnimations];
}

- (BOOL)locationManagerShouldDisplayHeadingCalibration:(CLLocationManager *)manager
{
    return NO;
}

@end
