//
//  MakingOfFeatureView.h
//  Digital 2.0
//
//  Created by Adrian on 6/6/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "FeatureView.h"

@interface MakingOfFeatureView : FeatureView
{
@private
    MPMoviePlayerController *_moviePlayer;
    UILabel *_label;
}

@end
