//
//  ButtonView.m
//  Digital2.0
//
//  Created by Adrian on 5/8/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import "ButtonView.h"
#import <QuartzCore/QuartzCore.h>

@interface ButtonView ()

@property (nonatomic, retain) UIImageView *backgroundImageView;

- (void)setup;
- (void)buttonTouched:(UITapGestureRecognizer *)recognizer;

@end


@implementation ButtonView

@synthesize displayLink = _displayLink;
@synthesize backgroundImageView = _backgroundImageView;
@synthesize foregroundImageView = _foregroundImageView;
@synthesize delegate = _delegate;
@synthesize nextSecondAnimation = _nextSecondAnimation;
@dynamic imageName;

#pragma mark -
#pragma mark Init and dealloc

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self setup];
        
        self.imageName = [NSString stringWithFormat:@"button_%d.png", self.tag];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) 
    {
        [self setup];
    }
    return self;
}

- (void)setup
{
    CGRect rect = CGRectMake(0.0, 0.0, 175.0, 175.0);
    self.backgroundImageView = [[[UIImageView alloc] initWithFrame:rect] autorelease];
    self.backgroundImageView.image = [UIImage imageNamed:@"button_background.png"];
    self.foregroundImageView = [[[UIImageView alloc] initWithFrame:rect] autorelease];
    self.backgroundColor = [UIColor clearColor];
    
    UITapGestureRecognizer *recognizer = [[[UITapGestureRecognizer alloc] initWithTarget:self 
                                                                                  action:@selector(buttonTouched:)] autorelease];
    [self addGestureRecognizer:recognizer];

    [self addSubview:self.backgroundImageView];
    [self addSubview:self.foregroundImageView];
    [self subclassSetup];
}

- (void)dealloc 
{
    self.displayLink = nil;
    self.backgroundImageView = nil;
    self.foregroundImageView = nil;
    self.imageName = nil;
    self.delegate = nil;
    [super dealloc];
}

#pragma mark -
#pragma mark Methods overridden by subclasses

- (void)subclassSetup
{
}

- (void)animate
{
}

- (void)initializeTimer
{
    self.nextSecondAnimation = arc4random() % 59;
    if (self.displayLink == nil)
    {
        self.displayLink = [CADisplayLink displayLinkWithTarget:self 
                                                       selector:@selector(animate)];
        [self.displayLink setFrameInterval:1];
        [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    }
}

#pragma mark -
#pragma mark Properties

- (NSString *)imageName
{
    return _imageName;
}

- (void)setImageName:(NSString *)newImageName
{
    if (![newImageName isEqualToString:self.imageName])
    {
        [_imageName release];
        _imageName = [newImageName copy];
        
        self.foregroundImageView.image = [UIImage imageNamed:self.imageName];
    }
}

#pragma mark -
#pragma mark Gesture recognizer handler

- (void)buttonTouched:(UITapGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateEnded && 
        [self.delegate respondsToSelector:@selector(didTouchButtonView:)])
    {
        [self.delegate didTouchButtonView:self];
    }
}

@end
