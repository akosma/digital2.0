//
//  DemoAppDelegate.h
//  Digital 2.0
//
//  Created by Adrian on 5/8/10.
//  Copyright akosma software 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@class MainMenuController;

@interface DemoAppDelegate : NSObject <UIApplicationDelegate> 
{
@private
    UIWindow *_window;
    MainMenuController *_mainMenuController;
    MPMoviePlayerController *_moviePlayer;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet MainMenuController *mainMenuController;

@end
