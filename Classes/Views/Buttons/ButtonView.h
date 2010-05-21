//
//  ButtonView.h
//  Digital2.0
//
//  Created by Adrian on 5/8/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ButtonViewDelegate.h"

@interface ButtonView : UIView 
{
@private
    CADisplayLink *_displayLink;
    UIImageView *_backgroundImageView;
    UIImageView *_foregroundImageView;
    NSString *_imageName;
    NSInteger _nextSecondAnimation;
    BOOL _hasShadow;
    id<ButtonViewDelegate> _delegate;
}

@property (nonatomic, copy) NSString *imageName;
@property (nonatomic) BOOL hasShadow;
@property (nonatomic, assign) IBOutlet id<ButtonViewDelegate> delegate;
@property (nonatomic, retain) UIImageView *foregroundImageView;
@property (nonatomic, retain) CADisplayLink *displayLink;
@property (nonatomic) NSInteger nextSecondAnimation;

- (void)subclassSetup;
- (void)animate;
- (void)initializeTimer;

@end
