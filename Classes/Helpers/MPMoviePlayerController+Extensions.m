//
//  MPMoviePlayerController+Extensions.m
//  digital2.0
//
//  Created by Adrian on 8/4/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import "MPMoviePlayerController+Extensions.h"

@implementation MPMoviePlayerController (Extensions)

- (void)fullStop
{
    [self stop];
    if (self.playbackState == MPMoviePlaybackStatePlaying)
    {
        self.currentPlaybackTime = self.duration;
    }
    [self.view removeFromSuperview];
}

@end
