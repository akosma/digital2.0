//
//  D2ConnectivityFeatureView.h
//  Digital 2.0
//
//  Created by Adrian on 6/21/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "D2FeatureView.h"

extern NSString * const D2ConnectivityFeatureViewOpenShareByEmailNotification;

@interface D2ConnectivityFeatureView : D2FeatureView <UIWebViewDelegate>

@property (nonatomic, retain) IBOutlet UIView *mainView;
@property (nonatomic, retain) IBOutlet UIImageView *twitterImageView;
@property (nonatomic, retain) IBOutlet UIImageView *facebookImageView;
@property (nonatomic, retain) IBOutlet UIImageView *safariImageView;
@property (nonatomic, retain) IBOutlet UIImageView *mailImageView;
@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, retain) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *spinningWheel;

@end
