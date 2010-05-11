//
//  VideoButtonView.h
//  Digital 2.0
//
//  Created by Adrian on 5/11/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "ButtonView.h"

@interface VideoButtonView : ButtonView 
{
@private
    MPMoviePlayerController *_moviePlayer;
}

@end
