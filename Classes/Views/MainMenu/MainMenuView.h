//
//  MainMenuView.h
//  Digital 2.0
//
//  Created by Adrian on 5/10/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "D2ButtonViewDelegate.h"
#import "MainMenuViewDelegate.h"

@class D2ButtonView;
@class D2CompassButtonView;
@class D2ClockButtonView;
@class D2CubeButtonView;
@class D2RotationButtonView;
@class D2VideoButtonView;

@interface MainMenuView : UIView <D2ButtonViewDelegate>
{
@private
    D2RotationButtonView *_button11;
    D2ButtonView *_button12;
    D2ButtonView *_button13;
    D2VideoButtonView *_button21;
    D2ClockButtonView *_button22;
    D2CubeButtonView *_button23;
    D2CompassButtonView *_button31;
    D2ButtonView *_button32;
    D2ButtonView *_button33;
    
    D2ButtonView *_selectedButton;

    NSArray *_buttons;
    NSArray *_normalFrames;
    UIInterfaceOrientation _orientation;
    CGSize _originalSize;
    
    UIView *_dockView;
    
    BOOL _minimized;
    
    id<MainMenuViewDelegate> _delegate;
}

@property (nonatomic, retain) IBOutlet D2RotationButtonView *button11;
@property (nonatomic, retain) IBOutlet D2ButtonView *button12;
@property (nonatomic, retain) IBOutlet D2ButtonView *button13;
@property (nonatomic, retain) IBOutlet D2VideoButtonView *button21;
@property (nonatomic, retain) IBOutlet D2ClockButtonView *button22;
@property (nonatomic, retain) IBOutlet D2CubeButtonView *button23;
@property (nonatomic, retain) IBOutlet D2CompassButtonView *button31;
@property (nonatomic, retain) IBOutlet D2ButtonView *button32;
@property (nonatomic, retain) IBOutlet D2ButtonView *button33;

@property (nonatomic) UIInterfaceOrientation orientation;
@property (nonatomic, getter=isMinimized) BOOL minimized;
@property (nonatomic, retain) IBOutlet UIView *dockView;
@property (nonatomic, assign) IBOutlet id<MainMenuViewDelegate> delegate;

@end
