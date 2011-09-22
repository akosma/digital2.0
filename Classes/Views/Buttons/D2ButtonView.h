//
//  D2ButtonView.h
//  Digital2.0
//
//  Created by Adrian on 5/8/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "D2ButtonViewDelegate.h"

@interface D2ButtonView : UIView 

@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, assign) IBOutlet id<D2ButtonViewDelegate> delegate;
@property (nonatomic, retain) UIImageView *foregroundImageView;
@property (nonatomic) NSInteger nextSecondAnimation;

- (void)subclassSetup;
- (void)animate;
- (void)initializeTimer;

@end
