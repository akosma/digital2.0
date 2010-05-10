//
//  ButtonView.h
//  Digital2.0
//
//  Created by Adrian on 5/8/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ButtonViewDelegate.h"

@interface ButtonView : UIView 
{
@private
    UIImageView *_backgroundImageView;
    UIImageView *_foregroundImageView;
    NSString *_imageName;
    BOOL _hasShadow;
    id<ButtonViewDelegate> _delegate;
}

@property (nonatomic, copy) NSString *imageName;
@property (nonatomic) BOOL hasShadow;
@property (nonatomic, assign) IBOutlet id<ButtonViewDelegate> delegate;

- (void)subclassSetup;
- (void)animate;

@end
