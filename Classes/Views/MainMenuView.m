//
//  MainMenuView.m
//  Digital 2.0
//
//  Created by Adrian on 5/10/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import "MainMenuView.h"
#import "ButtonView.h"
#import "CompassButtonView.h"
#import "ClockButtonView.h"
#import "CubeButtonView.h"
#import "RotationButtonView.h"

@interface MainMenuView ()

@property (nonatomic, retain) NSArray *buttons;

@end


@implementation MainMenuView

@synthesize buttons = _buttons;
@synthesize button11 = _button11;
@synthesize button12 = _button12;
@synthesize button13 = _button13;
@synthesize button21 = _button21;
@synthesize button22 = _button22;
@synthesize button23 = _button23;
@synthesize button31 = _button31;
@synthesize button32 = _button32;
@synthesize button33 = _button33;

@dynamic orientation;

- (void)dealloc 
{
    self.buttons = nil;
    self.button11 = nil;
    self.button12 = nil;
    self.button13 = nil;
    self.button21 = nil;
    self.button22 = nil;
    self.button23 = nil;
    self.button31 = nil;
    self.button32 = nil;
    self.button33 = nil;
    [super dealloc];
}

#pragma mark -
#pragma mark UIView methods

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.buttons = [NSArray arrayWithObjects:self.button11, self.button12, self.button13,
                    self.button21, self.button22, self.button23,
                    self.button31, self.button32, self.button33, nil];
}

#pragma mark -
#pragma mark Public methods

- (void)resetAllButtons
{
    for (ButtonView *currentButton in self.buttons)
    {
        currentButton.hasShadow = YES;
    }
}

- (void)animate
{
    [self.button22 animate];
    [self.button23 animate];
}

#pragma mark -
#pragma mark ButtonViewDelegate methods

- (void)didTouchButtonView:(ButtonView *)button
{
    for (ButtonView *currentButton in self.buttons)
    {
        currentButton.hasShadow = (currentButton != button);
    }
}

#pragma mark -
#pragma mark Properties

- (UIInterfaceOrientation)orientation
{
    return _orientation;
}

- (void)setOrientation:(UIInterfaceOrientation)newOrientation
{
    if (newOrientation != self.orientation)
    {
        _orientation = newOrientation;
        
        self.button31.orientation = self.orientation;
        self.button11.orientation = self.orientation;
    }
}

@end
