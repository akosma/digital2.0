//
//  ShopFeatureView.h
//  Digital 2.0
//
//  Created by Adrian on 6/6/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "FeatureView.h"

typedef enum {
    CurrentDressCity = 1,
    CurrentDressBeach = 2,
    CurrentDressNight = 3,
    CurrentDressGolf = 4
} CurrentDress;

@interface ShopFeatureView : FeatureView
{
@private
    UIImageView *_contourCity;
    UIImageView *_dressCity;
    UIImageView *_contourBeach;
    UIImageView *_dressBeach;
    UIImageView *_contourNight;
    UIImageView *_dressNight;
    UIImageView *_contourGolf;
    UIImageView *_dressGolf;
    
    UILabel *_titleLabel;
    UILabel *_descriptionLabel;
    UILabel *_cityPriceLabel;
    UILabel *_plagePriceLabel;
    UILabel *_nightPriceLabel;
    UILabel *_golfPriceLabel;
    
    UIView *_videoView;
    UIView *_mainView;
    
    CurrentDress _currentDress;
    UIImageView *_currentDressImage;
    CGPoint _originalDragPoint;
    CGPoint _lastRegisteredPoint;
    
    CGRect _dressCityFrame;
    CGRect _dressBeachFrame;
    CGRect _dressNightFrame;
    CGRect _dressGolfFrame;

    MPMoviePlayerController *_moviePlayer;
    
    BOOL _defileMode;
}

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
