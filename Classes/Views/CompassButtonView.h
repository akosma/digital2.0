//
//  CompassButtonView.h
//  Digital 2.0
//
//  Created by Adrian on 5/8/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "ButtonView.h"

@interface CompassButtonView : ButtonView <CLLocationManagerDelegate>
{
@private
    UIImageView *_compassNeedleImageView;
    CLLocationManager *_locationManager;
    UIInterfaceOrientation _orientation;
}

@property (nonatomic) UIInterfaceOrientation orientation;

@end
