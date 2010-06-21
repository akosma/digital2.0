//
//  DemoAppDelegate.m
//  Digital 2.0
//
//  Created by Adrian on 5/8/10.
//  Copyright akosma software 2010. All rights reserved.
//

#import "DemoAppDelegate.h"
#import "MainMenuController.h"

@implementation DemoAppDelegate

@synthesize window = _window;
@synthesize mainMenuController = _mainMenuController;
@synthesize locationManager = _locationManager;

+ (DemoAppDelegate *)sharedAppDelegate
{
    return (DemoAppDelegate *)[UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions 
{
    self.locationManager = [[[CLLocationManager alloc] init] autorelease];
    if (self.locationManager.locationServicesEnabled)
    {
        self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        self.locationManager.distanceFilter = 500.0;
        [self.locationManager startUpdatingLocation];
        [self.locationManager startUpdatingHeading];
    }
    else 
    {
        self.locationManager = nil;
    }
    
    [self.window addSubview:self.mainMenuController.view];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [self.locationManager stopUpdatingHeading];
    [self.locationManager stopUpdatingLocation];
}

- (void)dealloc 
{
    self.locationManager = nil;
    self.mainMenuController = nil;
    self.window = nil;
    [super dealloc];
}

@end
