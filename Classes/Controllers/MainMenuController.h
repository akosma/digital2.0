//
//  MainMenuController.h
//  Digital 2.0
//
//  Created by Adrian on 5/8/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "MainMenuViewDelegate.h"

@class MainMenuView;

@interface MainMenuController : UIViewController <MainMenuViewDelegate>
{
@private
    MainMenuView *_mainMenuView;
    CADisplayLink *_displayLink;
}

@property (nonatomic, retain) IBOutlet MainMenuView *mainMenuView;

@end
