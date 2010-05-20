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
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:duration];
    self.orientation = interfaceOrientation;
    [UIView commitAnimations];
}

- (void)maximize
{
    [UIView beginAnimations:nil context:NULL];
    self.transform = CGAffineTransformIdentity;
    [UIView commitAnimations];
}

- (void)minimize
{
    [UIView beginAnimations:MINIMIZE_ANIMATION_ID context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationFinished:finished:context:)];
    self.transform = CGAffineTransformMakeScale(0.01, 0.01);
    [UIView commitAnimations];
}

#pragma mark -
#pragma mark UIView animation delegate methods

- (void)animationFinished:(NSString *)animationID 
                 finished:(BOOL)finished 
                  context:(void *)context
{
    if ([animationID isEqualToString:MINIMIZE_ANIMATION_ID])
    {
        [self removeFromSuperview];
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
