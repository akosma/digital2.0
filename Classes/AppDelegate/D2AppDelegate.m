//
//  D2AppDelegate.m
//  Digital 2.0
//
//  Created by Adrian on 5/8/10.
//  Copyright akosma software 2010. All rights reserved.
//

#import "D2AppDelegate.h"
#import "MainMenuController.h"
#import "Reachability.h"


@interface D2AppDelegate ()

@property (nonatomic, retain) Reachability *reachability;
@property (nonatomic) NetworkStatus networkStatus;

@end


@implementation D2AppDelegate

@synthesize window = _window;
@synthesize mainMenuController = _mainMenuController;
@synthesize locationManager = _locationManager;
@synthesize reachability = _reachability;
@synthesize connectionAvailable = _connectionAvailable;
@synthesize networkStatus = _networkStatus;

+ (D2AppDelegate *)sharedAppDelegate
{
    return (D2AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (void)dealloc
{
    [_window release];
    [_mainMenuController release];
    [_locationManager release];
    [_reachability release];
    [super dealloc];
}

#pragma mark - UIApplicationDelegate methods

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions 
{
    self.connectionAvailable = YES;
    self.reachability = [Reachability reachabilityWithHostName:@"www.google.com"];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:) 
                                                 name:kReachabilityChangedNotification 
                                               object:self.reachability];
    [self.reachability startNotifer];
    
    if ([CLLocationManager locationServicesEnabled])
    {
        self.locationManager = [[[CLLocationManager alloc] init] autorelease];
        self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        self.locationManager.distanceFilter = 500.0;
    }

    [self.window addSubview:self.mainMenuController.view];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.locationManager stopUpdatingHeading];
    [self.locationManager stopUpdatingLocation];
}

#pragma mark - NSNotification methods

- (void)reachabilityChanged:(NSNotification *)notification
{
    self.networkStatus = [self.reachability currentReachabilityStatus];
    self.connectionAvailable = (self.networkStatus != NotReachable);
}

@end
