//
//  MapFeatureView.h
//  Digital 2.0
//
//  Created by Adrian on 6/19/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "FeatureView.h"

@class BoxView;

@interface MapFeatureView : FeatureView
{
@private
    MKMapView *_mapView;
    BoxView *_textView;
}

@end
