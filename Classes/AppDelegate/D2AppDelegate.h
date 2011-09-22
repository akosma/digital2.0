//
//  D2AppDelegate.h
//  Digital 2.0
//
//  Created by Adrian on 5/8/10.
//  Copyright akosma software 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@class D2MainMenuController;

@interface D2AppDelegate : NSObject <UIApplicationDelegate> 

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet D2MainMenuController *mainMenuController;
@property (nonatomic) BOOL connectionAvailable;
@property (nonatomic, retain) CLLocationManager *locationManager;

+ (D2AppDelegate *)sharedAppDelegate;

@end
