//
//  FeatureView.m
//  Digital 2.0
//
//  Created by Adrian on 5/20/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import "FeatureView.h"

@implementation FeatureView

@dynamic orientation;

- (id)initWithFrame:(CGRect)frame 
{
    if ((self = [super initWithFrame:frame])) 
    {
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
