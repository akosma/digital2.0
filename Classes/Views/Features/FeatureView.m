//
//  FeatureView.m
//  Digital 2.0
//
//  Created by Adrian on 5/20/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import "FeatureView.h"

#define MINIMIZE_ANIMATION_ID @"MINIMIZE_ANIMATION_ID"

@implementation FeatureView

@synthesize requiresNetwork = _requiresNetwork;
@synthesize minimized = _minimized;
@synthesize shouldBeCached = _shouldBeCached;
@dynamic orientation;

+ (id)featureViewWithOrientation:(UIInterfaceOrientation)orientation
{
    id view = [[[[self class] alloc] initWithFrame:CGRectMake(0.0, 0.0, 768.0, 1004.0)] autorelease];
    [view setOrientation:orientation];
    [view setTransform:CGAffineTransformMakeScale(0.01, 0.01)];
    return view;
}

- (id)initWithFrame:(CGRect)frame 
{
    if ((self = [super initWithFrame:frame])) 
    {
        self.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
        self.contentMode = UIViewContentModeScaleToFill;
        self.requiresNetwork = NO;
        self.minimized = YES;
        self.shouldBeCached = YES;
    }
    return self;
}

- (void)dealloc 
{
    [super dealloc];
}

#pragma mark -
#pragma mark Public methods

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration
{
    self.orientation = interfaceOrientation;
}

- (void)maximize
{
    self.minimized = NO;
    [UIView animateWithDuration:0.4 
                     animations:^{
                         self.transform = CGAffineTransformIdentity;
                     }];
}

- (void)minimize
{
    self.minimized = YES;
    self.transform = CGAffineTransformMakeScale(0.01, 0.01);
    [self removeFromSuperview];
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
        if (UIInterfaceOrientationIsPortrait(newOrientation))
        {
            self.frame = CGRectMake(0.0, 0.0, 768.0, 1004.0);
        }
        else
        {
            self.frame = CGRectMake(0.0, 0.0, 1024.0, 748.0);
        }
    }
}

@end
