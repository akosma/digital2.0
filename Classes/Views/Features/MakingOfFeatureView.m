//
//  MakingOfFeatureView.m
//  Digital 2.0
//
//  Created by Adrian on 6/6/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import "MakingOfFeatureView.h"


@interface MakingOfFeatureView ()

@property (nonatomic, retain) MPMoviePlayerController *moviePlayer;

@end


@implementation MakingOfFeatureView

@synthesize moviePlayer = _moviePlayer;

- (id)initWithFrame:(CGRect)frame 
{
    if ((self = [super initWithFrame:frame])) 
    {
        self.backgroundColor = [UIColor blackColor];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"making_of_final" ofType:@"mp4"];
        NSURL *url = [NSURL fileURLWithPath:path];
        self.moviePlayer = [[[MPMoviePlayerController alloc] initWithContentURL:url] autorelease];
        
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        [center addObserver:self 
                   selector:@selector(moviePlaybackFinished:) 
                       name:MPMoviePlayerPlaybackDidFinishNotification
                     object:self.moviePlayer];
        [center addObserver:self 
                   selector:@selector(movieReady:) 
                       name:MPMoviePlayerLoadStateDidChangeNotification
                     object:self.moviePlayer];
        
        self.moviePlayer.view.hidden = YES;
        self.moviePlayer.backgroundView.backgroundColor = [UIColor blackColor];
        self.moviePlayer.controlStyle = MPMovieControlModeDefault;
        self.moviePlayer.view.autoresizingMask = UIViewAutoresizingFlexibleWidth |
                                                 UIViewAutoresizingFlexibleHeight;
        [self addSubview:self.moviePlayer.view];
    }
    return self;
}

- (void)dealloc 
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    if (self.moviePlayer.playbackState == MPMoviePlaybackStatePlaying)
    {
        [self.moviePlayer stop];
    }
    self.moviePlayer = nil;
    [super dealloc];
}

#pragma mark -
#pragma mark Overridden methods

- (void)setOrientation:(UIInterfaceOrientation)newOrientation
{
    [super setOrientation:newOrientation];
    
    CGRect movieFrame = CGRectMake(0.0, 0.0, 1024.0, 748.0);
    
    if (UIInterfaceOrientationIsPortrait(newOrientation))
    {
        movieFrame = CGRectMake(0.0, 0.0, 768.0, 1024.0);
    }

    self.moviePlayer.view.frame = movieFrame;
}

- (void)minimize
{
    [super minimize];
    if (self.moviePlayer.playbackState == MPMoviePlaybackStatePlaying)
    {
        [self.moviePlayer stop];
    }
}

#pragma mark -
#pragma mark NSNotification handlers

- (void)moviePlaybackFinished:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] postNotificationName:FeatureViewShouldMinimizeNotification 
                                                        object:self];
}

- (void)movieReady:(NSNotification *)notification
{
    if (self.moviePlayer.loadState == 3)
    {
        self.moviePlayer.view.hidden = NO;
        [self.moviePlayer play];
    }
}

@end
