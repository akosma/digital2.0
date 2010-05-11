//
//  VideoButtonView.m
//  Digital 2.0
//
//  Created by Adrian on 5/11/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import "VideoButtonView.h"

@interface VideoButtonView ()

@property (nonatomic, retain) MPMoviePlayerController *moviePlayer;

@end


@implementation VideoButtonView

@synthesize moviePlayer = _moviePlayer;

- (void)subclassSetup
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"button_21" ofType:@"mp4"];
    NSURL *url = [NSURL fileURLWithPath:path];
    self.moviePlayer = [[[MPMoviePlayerController alloc] initWithContentURL:url] autorelease];
    self.moviePlayer.shouldAutoplay = YES;
    self.moviePlayer.controlStyle = MPMovieControlStyleNone;
    self.moviePlayer.repeatMode = MPMovieRepeatModeOne;
    self.moviePlayer.view.frame = self.bounds;
    self.moviePlayer.view.transform = CGAffineTransformMakeScale(0.9, 0.9);
    [self addSubview:self.moviePlayer.view];
    [self.moviePlayer play];
}

- (void)dealloc 
{
    self.moviePlayer = nil;
    [super dealloc];
}


@end
