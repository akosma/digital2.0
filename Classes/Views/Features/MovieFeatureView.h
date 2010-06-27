//
//  MovieFeatureView.h
//  Digital 2.0
//
//  Created by Adrian on 5/20/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "FeatureView.h"

@interface MovieFeatureView : FeatureView <UIScrollViewDelegate>
{
@private
    NSMutableArray *_movieControllers;
    NSArray *_movieNames;
    NSArray *_texts;
    NSArray *_titles;
    UIScrollView *_scrollView;
    NSInteger _currentMovieID;
    UILabel *_titleLabel;
    UILabel *_textLabel;
    UIButton *_rightButton;
    UIButton *_leftButton;
}

- (void)showCurrentMovie;

@end
