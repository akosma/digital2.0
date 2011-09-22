//
//  D2ButtonView.m
//  Digital2.0
//
//  Created by Adrian on 5/8/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import "D2ButtonView.h"

@interface D2ButtonView ()

@property (nonatomic, retain) UIImageView *backgroundImageView;
@property (nonatomic, retain) CADisplayLink *displayLink;

- (void)setup;

@end


@implementation D2ButtonView

@synthesize displayLink = _displayLink;
@synthesize backgroundImageView = _backgroundImageView;
@synthesize foregroundImageView = _foregroundImageView;
@synthesize nextSecondAnimation = _nextSecondAnimation;
@synthesize imageName = _imageName;

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
    
    [self addSubview:self.backgroundImageView];
    [self addSubview:self.foregroundImageView];
    [self subclassSetup];
}

- (void)dealloc 
{
    [_displayLink release];
    [_backgroundImageView release];
    [_foregroundImageView release];
    [_imageName release];
    [super dealloc];
}

#pragma mark - Methods overridden by subclasses

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

#pragma mark - Properties

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

@end
