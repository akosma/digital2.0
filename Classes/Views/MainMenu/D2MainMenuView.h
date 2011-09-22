//
//  D2MainMenuView.h
//  Digital 2.0
//
//  Created by Adrian on 5/10/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "D2ButtonViewDelegate.h"
#import "D2MainMenuViewDelegate.h"

@class D2ButtonView;
@class D2CompassButtonView;
@class D2ClockButtonView;
@class D2CubeButtonView;
@class D2RotationButtonView;
@class D2VideoButtonView;

@interface D2MainMenuView : UIView <D2ButtonViewDelegate>

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
@property (nonatomic, assign) IBOutlet id<D2MainMenuViewDelegate> delegate;

@end
