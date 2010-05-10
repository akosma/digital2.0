//
//  MainMenuController.h
//  Digital 2.0
//
//  Created by Adrian on 5/8/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ButtonViewDelegate.h"

@class ButtonView;
@class CompassButtonView;
@class ClockButtonView;
@class CubeButtonView;

@interface MainMenuController : UIViewController <ButtonViewDelegate>
{
@private
    ButtonView *_button11;
    ButtonView *_button12;
    ButtonView *_button13;
    ButtonView *_button21;
    ClockButtonView *_button22;
    CubeButtonView *_button23;
    CompassButtonView *_button31;
    ButtonView *_button32;
    ButtonView *_button33;
    
    CADisplayLink *_displayLink;

    NSArray *_buttons;
}

@property (nonatomic, retain) IBOutlet ButtonView *button11;
@property (nonatomic, retain) IBOutlet ButtonView *button12;
@property (nonatomic, retain) IBOutlet ButtonView *button13;
@property (nonatomic, retain) IBOutlet ButtonView *button21;
@property (nonatomic, retain) IBOutlet ClockButtonView *button22;
@property (nonatomic, retain) IBOutlet CubeButtonView *button23;
@property (nonatomic, retain) IBOutlet CompassButtonView *button31;
@property (nonatomic, retain) IBOutlet ButtonView *button32;
@property (nonatomic, retain) IBOutlet ButtonView *button33;


@end
