//
//  D2CompassButtonView.h
//  Digital 2.0
//
//  Created by Adrian on 5/8/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "D2ButtonView.h"

@interface D2CompassButtonView : D2ButtonView <CLLocationManagerDelegate>

@property (nonatomic) UIInterfaceOrientation orientation;

@end
