//
//  MovieFeatureView.m
//  Digital 2.0
//
//  Created by Adrian on 5/20/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import "MovieFeatureView.h"

@interface MovieFeatureView ()

@property (nonatomic, retain) MPMoviePlayerController *moviePlayer;

@end


@implementation MovieFeatureView

@synthesize moviePlayer = _moviePlayer;

- (id)initWithFrame:(CGRect)frame 
{
    if ((self = [super initWithFrame:frame])) 
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"mp4"];
        NSURL *url = [NSURL fileURLWithPath:path];
        self.moviePlayer = [[[MPMoviePlayerController alloc] initWithContentURL:url] autorelease];
        self.moviePlayer.shouldAutoplay = YES;

        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        [center addObserver:self 
                   selector:@selector(moviePlaybackFinished:) 
                       name:MPMoviePlayerPlaybackDidFinishNotification
                     object:self.moviePlayer];
        [center addObserver:self 
                   selector:@selector(moviePlaybackFinished:) 
                       name:MPMoviePlayerDidExitFullscreenNotification
                     object:self.moviePlayer];
        [center addObserver:self 
                   selector:@selector(moviePlaybackChanged:) 
                       name:MPMoviePlayerPlaybackStateDidChangeNotification
                     object:self.moviePlayer];
        [center addObserver:self 
                   selector:@selector(movieReady:) 
                       name:MPMoviePlayerLoadStateDidChangeNotification
                     object:self.moviePlayer];

        CGFloat width = 500.0;
        self.moviePlayer.view.frame = CGRectMake(self.bounds.size.width / 2.0 - width / 2.0, 
                                                (self.bounds.size.height - 120.0) / 2.0 - width / 2.0, 
                                                width, 
                                                width);
        self.moviePlayer.view.transform = CGAffineTransformMakeScale(0.01, 0.01);
        self.moviePlayer.backgroundView.backgroundColor = [UIColor whiteColor];
        self.moviePlayer.view.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | 
                                                    UIViewAutoresizingFlexibleTopMargin | 
                                                    UIViewAutoresizingFlexibleLeftMargin | 
                                                    UIViewAutoresizingFlexibleBottomMargin;
        [self addSubview:self.moviePlayer.view];
    }
    return self;
}

- (void)dealloc 
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.moviePlayer stop];
    self.moviePlayer = nil;
    [super dealloc];
}

#pragma mark -
#pragma mark NSNotification handlers

- (void)moviePlaybackFinished:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] postNotificationName:FeatureViewShouldMinimizeNotification 
                                                        object:self];
}

- (void)moviePlaybackChanged:(NSNotification *)notification
{
    if (self.moviePlayer.playbackState == MPMoviePlaybackStatePaused ||
             self.moviePlayer.playbackState == MPMoviePlaybackStateStopped)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:FeatureViewShouldMinimizeNotification 
                                                            object:self];
    }
}

- (void)movieReady:(NSNotification *)notification
{
    if (self.moviePlayer.loadState == 3)
    {
        [UIView beginAnimations:nil context:NULL];
        self.moviePlayer.view.transform = CGAffineTransformIdentity;
        [UIView commitAnimations];
    }
}

@end
