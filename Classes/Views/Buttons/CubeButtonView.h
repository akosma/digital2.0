//
//  CubeButtonView.h
//  Digital 2.0
//
//  Created by Adrian on 5/8/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ButtonView.h"

@class EAGLView;

@interface CubeButtonView : ButtonView 
{
@private
    EAGLView *_eaglView;
}

@end
