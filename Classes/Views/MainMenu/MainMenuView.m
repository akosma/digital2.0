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
#import "VideoButtonView.h"
#import "EAGLView.h"

@interface MainMenuView ()

@property (nonatomic, retain) NSArray *buttons;
@property (nonatomic, retain) NSArray *normalFrames;
@property (nonatomic) CGSize originalSize;
@property (nonatomic, assign) ButtonView *selectedButton;

- (void)highlightCurrentButtonInDock;

@end


@implementation MainMenuView

@synthesize buttons = _buttons;
@synthesize normalFrames = _normalFrames;
@synthesize button11 = _button11;
@synthesize button12 = _button12;
@synthesize button13 = _button13;
@synthesize button21 = _button21;
@synthesize button22 = _button22;
@synthesize button23 = _button23;
@synthesize button31 = _button31;
@synthesize button32 = _button32;
@synthesize button33 = _button33;
@synthesize originalSize = _originalSize;
@synthesize dockView = _dockView;
@synthesize selectedButton = _selectedButton;
@synthesize delegate = _delegate;

@dynamic minimized;
@dynamic orientation;

- (void)dealloc 
{
    self.delegate = nil;
    self.selectedButton = nil;
    self.normalFrames = nil;
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
    self.dockView = nil;
    [super dealloc];
}

#pragma mark -
#pragma mark UIView methods

- (void)awakeFromNib
{
    [super awakeFromNib];
    _minimized = NO;
    self.buttons = [NSArray arrayWithObjects:self.button11, self.button12, self.button13,
                    self.button21, self.button22, self.button23,
                    self.button31, self.button32, self.button33, nil];
    self.normalFrames = [NSArray arrayWithObjects:[NSValue valueWithCGRect:self.button11.frame],
                         [NSValue valueWithCGRect:self.button12.frame],
                         [NSValue valueWithCGRect:self.button13.frame],
                         [NSValue valueWithCGRect:self.button21.frame],
                         [NSValue valueWithCGRect:self.button22.frame],
                         [NSValue valueWithCGRect:self.button23.frame],
                         [NSValue valueWithCGRect:self.button31.frame],
                         [NSValue valueWithCGRect:self.button32.frame],
                         [NSValue valueWithCGRect:self.button33.frame],
                         nil];
    self.originalSize = self.frame.size;
    self.backgroundColor = [UIColor clearColor];
    self.dockView.backgroundColor = [UIColor clearColor];

    UIPanGestureRecognizer *panRecognizer = [[[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                     action:@selector(panRecognized:)] autorelease];
    panRecognizer.maximumNumberOfTouches = 1;
    [self addGestureRecognizer:panRecognizer];
}

#pragma mark -
#pragma mark Public methods

- (void)panRecognized:(UIPanGestureRecognizer *)recognizer
{
    if (self.isMinimized)
    {
        switch (recognizer.state) 
        {
            case UIGestureRecognizerStateChanged:
            {
                CGPoint point = [recognizer locationInView:self.dockView];
                if (point.x > 0 && point.y > 0)
                {
                    ButtonView *buttonView = (ButtonView *)[self hitTest:point withEvent:nil];
                    if (buttonView != nil)
                    {
                        if ([buttonView isKindOfClass:[ButtonView class]])
                        {
                            self.selectedButton = buttonView;
                            [self highlightCurrentButtonInDock];
                        }
                        else if ([buttonView isKindOfClass:[EAGLView class]])
                        {
                            buttonView = (ButtonView *)buttonView.superview;
                            self.selectedButton = buttonView;
                            [self highlightCurrentButtonInDock];
                        }
                    }
                }
                break;
            }
                
            case UIGestureRecognizerStateEnded:
            {
                if ([self.delegate respondsToSelector:@selector(mainMenu:didSelectButtonWithTag:)])
                {
                    [self.delegate mainMenu:self didSelectButtonWithTag:self.selectedButton.tag];
                }
                break;
            }

            default:
                break;
        }
    }
}

#pragma mark -
#pragma mark ButtonViewDelegate methods

- (void)didTouchButtonView:(ButtonView *)button
{
    self.selectedButton = button;
    if ([self.delegate respondsToSelector:@selector(mainMenu:didSelectButtonWithTag:)])
    {
        [self.delegate mainMenu:self didSelectButtonWithTag:button.tag];
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

- (BOOL)isMinimized
{
    return _minimized;
}

- (void)setMinimized:(BOOL)newValue
{
    if (newValue != self.minimized)
    {
        _minimized = newValue;
        
        [UIView animateWithDuration:0.4 
                         animations:^{
                             if (self.isMinimized)
                             {
                                 self.frame = self.dockView.frame;
                             }
                             else
                             {
                                 self.frame = CGRectMake(self.superview.bounds.size.width / 2.0 - self.originalSize.width / 2.0, 
                                                         self.superview.bounds.size.height / 2.0 - self.originalSize.height / 2.0,
                                                         self.originalSize.width, self.originalSize.height);
                                 
                                 for (NSInteger index = 0; index < [self.buttons count]; ++index)
                                 {
                                     ButtonView *currentButton = [self.buttons objectAtIndex:index];
                                     NSValue *currentRectValue = [self.normalFrames objectAtIndex:index];
                                     currentButton.transform = CGAffineTransformIdentity;
                                     currentButton.frame = [currentRectValue CGRectValue];
                                 }
                             }
                         }];
    }
    [self highlightCurrentButtonInDock];
}

#pragma mark -
#pragma mark Private methods

- (void)highlightCurrentButtonInDock
{
    if (self.isMinimized)
    {
        [UIView animateWithDuration:0.4 
                         animations:^{
                             for (NSInteger index = 0; index < [self.buttons count]; ++index)
                             {
                                 ButtonView *currentButton = [self.buttons objectAtIndex:index];
                                 currentButton.transform = CGAffineTransformMakeScale(0.3, 0.3);
                                 if (currentButton == self.selectedButton)
                                 {
                                     currentButton.frame = CGRectMake(index * 60.0, 
                                                                      -10.0, 
                                                                      currentButton.frame.size.width, 
                                                                      currentButton.frame.size.height);
                                     
                                 }
                                 else
                                 {
                                     currentButton.frame = CGRectMake(index * 60.0, 
                                                                      0.0, 
                                                                      currentButton.frame.size.width, 
                                                                      currentButton.frame.size.height);
                                 }
                             }
                         }];
    }
}

@end
