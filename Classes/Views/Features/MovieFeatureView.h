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

@interface MovieFeatureView : FeatureView 
{
@private
    MPMoviePlayerController *_moviePlayer;
}

@end
