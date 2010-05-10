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

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions 
{
    [self.window addSubview:self.mainMenuController.view];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)dealloc 
{
    self.window = nil;
    [super dealloc];
}


@end
