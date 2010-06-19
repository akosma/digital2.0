//
//  FluidFeatureView.h
//  Digital 2.0
//
//  Created by Adrian on 5/20/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeatureView.h"

@class BoxView;

@interface FluidFeatureView : FeatureView
{
@private
    UIImageView *_photoView;
    BoxView *_textView;
}

@end
