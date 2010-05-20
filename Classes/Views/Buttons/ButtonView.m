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

@synthesize backgroundImageView = _backgroundImageView;
@synthesize foregroundImageView = _foregroundImageView;
@synthesize delegate = _delegate;
@dynamic hasShadow;
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
    
    self.hasShadow = NO;
    
    UITapGestureRecognizer *recognizer = [[[UITapGestureRecognizer alloc] initWithTarget:self 
                                                                                  action:@selector(buttonTouched:)] autorelease];
    [self addGestureRecognizer:recognizer];

    [self addSubview:self.backgroundImageView];
    [self addSubview:self.foregroundImageView];
    [self subclassSetup];
}

- (void)dealloc 
{
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

#pragma mark -
#pragma mark Properties

- (BOOL)hasShadow
{
    return _hasShadow;
}

- (void)setHasShadow:(BOOL)newValue
{
    if (newValue != self.hasShadow)
    {
        _hasShadow = newValue;
        
        if (self.hasShadow)
        {
            self.backgroundImageView.layer.shadowColor = [UIColor blackColor].CGColor;
            self.backgroundImageView.layer.shadowRadius = 5.0;
            self.backgroundImageView.layer.shadowOpacity = 0.75;
            self.backgroundImageView.layer.shadowOffset = CGSizeMake(0.0, 1.0);
        }
        else
        {
            self.backgroundImageView.layer.shadowColor = [UIColor clearColor].CGColor;
            self.backgroundImageView.layer.shadowRadius = 0.0;
            self.backgroundImageView.layer.shadowOpacity = 0.0;
            self.backgroundImageView.layer.shadowOffset = CGSizeMake(0.0, 0.0);
        }
    }
}

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
    if ([self.delegate respondsToSelector:@selector(didTouchButtonView:)])
    {
        [self.delegate didTouchButtonView:self];
    }
}

@end
