//
//  D2RotationButtonView.m
//  Digital 2.0
//
//  Created by Adrian on 5/10/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import "D2RotationButtonView.h"

@interface D2RotationButtonView ()

- (void)changeOrientation;

@end


@implementation D2RotationButtonView

@synthesize orientation = _orientation;

- (void)subclassSetup
{
}

- (void)dealloc 
{
    [super dealloc];
}

#pragma mark - Properties

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

#pragma mark - Private methods

- (void)changeOrientation
{
    [UIView animateWithDuration:0.4 
                     animations:^{
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
                     }];
}

@end
