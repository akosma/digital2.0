//
//  FeatureView.h
//  Digital 2.0
//
//  Created by Adrian on 5/20/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import <UIKit/UIKit.h>

#define FeatureViewShouldMinimizeNotification @"FeatureViewShouldMinimizeNotification"

@interface FeatureView : UIView 
{
@private
    UIInterfaceOrientation _orientation;
    BOOL _requiresNetwork;
    BOOL _minimized;
    BOOL _shouldBeCached;
}

@property (nonatomic) UIInterfaceOrientation orientation;
@property (nonatomic) BOOL requiresNetwork;
@property (nonatomic) BOOL minimized;
@property (nonatomic) BOOL shouldBeCached;

+ (id)featureViewWithOrientation:(UIInterfaceOrientation)orientation;

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration;
- (void)maximize;
- (void)minimize;

@end
