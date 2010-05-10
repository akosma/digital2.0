//
//  MainMenuView.h
//  Digital 2.0
//
//  Created by Adrian on 5/10/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ButtonViewDelegate.h"

@class ButtonView;
@class CompassButtonView;
@class ClockButtonView;
@class CubeButtonView;
@class RotationButtonView;

@interface MainMenuView : UIView <ButtonViewDelegate>
{
@private
    RotationButtonView *_button11;
    ButtonView *_button12;
    ButtonView *_button13;
    ButtonView *_button21;
    ClockButtonView *_button22;
    CubeButtonView *_button23;
    CompassButtonView *_button31;
    ButtonView *_button32;
    ButtonView *_button33;    

    NSArray *_buttons;
    UIInterfaceOrientation _orientation;
}

@property (nonatomic, retain) IBOutlet RotationButtonView *button11;
@property (nonatomic, retain) IBOutlet ButtonView *button12;
@property (nonatomic, retain) IBOutlet ButtonView *button13;
@property (nonatomic, retain) IBOutlet ButtonView *button21;
@property (nonatomic, retain) IBOutlet ClockButtonView *button22;
@property (nonatomic, retain) IBOutlet CubeButtonView *button23;
@property (nonatomic, retain) IBOutlet CompassButtonView *button31;
@property (nonatomic, retain) IBOutlet ButtonView *button32;
@property (nonatomic, retain) IBOutlet ButtonView *button33;

@property (nonatomic) UIInterfaceOrientation orientation;

- (void)animate;
- (void)resetAllButtons;

@end
