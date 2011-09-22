//
//  D2ButtonViewDelegate.h
//  Digital 2.0
//
//  Created by Adrian on 5/8/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import <UIKit/UIKit.h>

@class D2ButtonView;

@protocol D2ButtonViewDelegate <NSObject>

@optional

- (void)didTouchButtonView:(D2ButtonView *)button;

@end
