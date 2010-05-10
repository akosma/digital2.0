//
//  RotationButtonView.h
//  Digital 2.0
//
//  Created by Adrian on 5/10/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ButtonView.h"

@interface RotationButtonView : ButtonView 
{
@private
    UIInterfaceOrientation _orientation;
}

@property (nonatomic) UIInterfaceOrientation orientation;

@end
