//
//  MainMenuController.h
//  Digital 2.0
//
//  Created by Adrian on 5/8/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <QuartzCore/QuartzCore.h>
#import "MainMenuViewDelegate.h"

@class MainMenuView;
@class SoundManager;
@class FluidFeatureView;

@interface MainMenuController : UIViewController <MainMenuViewDelegate>
{
@private
    MainMenuView *_mainMenuView;
    CADisplayLink *_displayLink;
    
    UIButton *_akosmaInfoButton;
    UIButton *_moserInfoButton;
    UIButton *_vpsInfoButton;
    
    UIView *_touchableView;
    
    UIPopoverController *_popover;
    
    MPMoviePlayerController *_moviePlayer;
    SoundManager *_soundManager;
    FluidFeatureView *_fluidFeatureView;
}

@property (nonatomic, retain) IBOutlet MainMenuView *mainMenuView;
@property (nonatomic, retain) IBOutlet UIButton *akosmaInfoButton;
@property (nonatomic, retain) IBOutlet UIButton *moserInfoButton;
@property (nonatomic, retain) IBOutlet UIButton *vpsInfoButton;
@property (nonatomic, retain) IBOutlet UIView *touchableView;

- (IBAction)showInfo:(id)sender;

@end
