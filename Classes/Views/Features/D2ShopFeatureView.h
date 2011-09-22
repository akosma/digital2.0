//
//  D2ShopFeatureView.h
//  Digital 2.0
//
//  Created by Adrian on 6/6/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "D2FeatureView.h"


@interface D2ShopFeatureView : D2FeatureView

@property (nonatomic, retain) IBOutlet UIImageView *contourCity;
@property (nonatomic, retain) IBOutlet UIImageView *dressCity;
@property (nonatomic, retain) IBOutlet UIImageView *contourBeach;
@property (nonatomic, retain) IBOutlet UIImageView *dressBeach;
@property (nonatomic, retain) IBOutlet UIImageView *contourNight;
@property (nonatomic, retain) IBOutlet UIImageView *dressNight;
@property (nonatomic, retain) IBOutlet UIImageView *contourGolf;
@property (nonatomic, retain) IBOutlet UIImageView *dressGolf;
@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, retain) IBOutlet UILabel *cityPriceLabel;
@property (nonatomic, retain) IBOutlet UILabel *plagePriceLabel;
@property (nonatomic, retain) IBOutlet UILabel *nightPriceLabel;
@property (nonatomic, retain) IBOutlet UILabel *golfPriceLabel;
@property (nonatomic, retain) IBOutlet UIView *videoView;
@property (nonatomic, retain) IBOutlet UIView *mainView;

@end
