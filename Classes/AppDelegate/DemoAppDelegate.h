//
//  DemoAppDelegate.h
//  Digital 2.0
//
//  Created by Adrian on 5/8/10.
//  Copyright akosma software 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@class MainMenuController;

@interface DemoAppDelegate : NSObject <UIApplicationDelegate> 
{
@private
    UIWindow *_window;
    MainMenuController *_mainMenuController;
    CLLocationManager *_locationManager;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet MainMenuController *mainMenuController;
@property (nonatomic, retain) CLLocationManager *locationManager;

+ (DemoAppDelegate *)sharedAppDelegate;

@end
