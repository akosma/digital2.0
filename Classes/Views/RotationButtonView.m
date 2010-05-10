//
//  RotationButtonView.m
//  Digital 2.0
//
//  Created by Adrian on 5/10/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import "RotationButtonView.h"

@interface RotationButtonView ()

- (void)changeOrientation;

@end


@implementation RotationButtonView

@dynamic orientation;

- (void)subclassSetup
{
}

- (void)dealloc 
{
    [super dealloc];
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
        [self performSelector:@selector(changeOrientation) withObject:nil afterDelay:1.0];
    }
}

#pragma mark -
#pragma mark Private methods

- (void)changeOrientation
{
    [UIView beginAnimations:nil context:NULL];
    CGAffineTransform transform = CGAffineTransformIdentity;
    switch (self.orientation) 
    {
        case UIInterfaceOrientationPortrait:
            break;
            
        case UIInterfaceOrientationPortraitUpsideDown:
            transform = CGAffineTransformMakeRotation(M_PI);
            break;
            
        case UIInterfaceOrientationLandscapeLeft:
            transform = CGAffineTransformMakeRotation(M_PI / 2.0);
            break;
            
        case UIInterfaceOrientationLandscapeRight:
            transform = CGAffineTransformMakeRotation(- M_PI / 2.0);
            break;
            
        default:
            break;
    }
    self.foregroundImageView.transform = transform;
    [UIView commitAnimations];
}

@end
