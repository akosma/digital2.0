//
//  MovieFeatureView.m
//  Digital 2.0
//
//  Created by Adrian on 5/20/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import "MovieFeatureView.h"

@interface MovieFeatureView ()

@property (nonatomic, retain) NSMutableArray *movieControllers;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic) NSInteger currentMovieID;
@property (nonatomic, retain) NSArray *movieNames;

@end


@implementation MovieFeatureView

@synthesize movieControllers = _movieControllers;
@synthesize scrollView = _scrollView;
@synthesize currentMovieID = _currentMovieID;
@synthesize movieNames = _movieNames;

- (id)initWithFrame:(CGRect)frame 
{
    if ((self = [super initWithFrame:frame])) 
    {
        self.movieNames = [NSArray arrayWithObjects:@"mini HD_1800", @"mini key_1800", @"minisquare_1800", nil];
        NSInteger count = [self.movieNames count];
        self.currentMovieID = 0;
        self.movieControllers = [NSMutableArray arrayWithCapacity:count];
        self.scrollView = [[[UIScrollView alloc] initWithFrame:frame] autorelease];
        self.scrollView.contentSize = CGSizeMake(frame.size.width * count, frame.size.height);
        self.scrollView.pagingEnabled = YES;
        self.scrollView.delegate = self;
        [self addSubview:self.scrollView];
    }
    return self;
}

- (void)dealloc 
{
    self.movieNames = nil;
    self.movieControllers = nil;
    self.scrollView = nil;
    [super dealloc];
}

#pragma mark -
#pragma mark UIScrollViewDelegate methods

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger previousMovieID = self.currentMovieID;
    self.currentMovieID = (NSInteger)(self.scrollView.contentOffset.x / self.scrollView.frame.size.width);
    if (self.currentMovieID != previousMovieID)
    {
        [self showCurrentMovie];
    }
}

#pragma mark -
#pragma mark Overridden methods

- (void)setOrientation:(UIInterfaceOrientation)newOrientation
{
    [super setOrientation:newOrientation];
    
    CGRect movieFrame = CGRectMake(0.0, 50.0, 1024.0, 548.0);
    
    if (UIInterfaceOrientationIsPortrait(newOrientation))
    {
        movieFrame = CGRectMake(0.0, 50.0, 768.0, 824.0);
    }
    
    self.scrollView.frame = movieFrame;
    NSInteger count = [self.movieNames count];
    self.scrollView.contentSize = CGSizeMake(movieFrame.size.width * count, movieFrame.size.height);
    CGRect rect = CGRectMake(self.currentMovieID * movieFrame.size.width, 0.0, movieFrame.size.width, movieFrame.size.height);
    NSInteger index = 0;
    for (MPMoviePlayerController *player in self.movieControllers)
    {
        CGRect movieRect = CGRectMake(index * movieFrame.size.width, 0.0, movieFrame.size.width, movieFrame.size.height);
        player.view.frame = movieRect;
        ++index;
    }
    [self.scrollView scrollRectToVisible:rect animated:NO];
}

- (void)minimize
{
    [super minimize];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    for (MPMoviePlayerController *player in self.movieControllers)
    {
        player.currentPlaybackTime = player.duration;
        [player.view removeFromSuperview];
    }
    self.movieControllers = nil;
}

#pragma mark -
#pragma mark NSNotification handlers

- (void)moviePlaybackFinished:(NSNotification *)notification
{
    self.currentMovieID = (self.currentMovieID + 1) % [self.movieNames count];
    [self showCurrentMovie];
}

#pragma mark -
#pragma mark Private methods

- (void)showCurrentMovie
{
    for (MPMoviePlayerController *player in self.movieControllers)
    {
        [player stop];
        player.view.hidden = YES;
    }
    
    MPMoviePlayerController *moviePlayer = nil;
    CGRect rect = CGRectMake(self.currentMovieID * self.scrollView.frame.size.width, 0.0, 
                             self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    
    if ([self.movieControllers count] > self.currentMovieID)
    {
        moviePlayer = [self.movieControllers objectAtIndex:self.currentMovieID];
    }
    
    if (moviePlayer == nil)
    {
        NSString *name = [self.movieNames objectAtIndex:self.currentMovieID];
        NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"mp4"];
        NSURL *url = [NSURL fileURLWithPath:path];
        moviePlayer = [[[MPMoviePlayerController alloc] initWithContentURL:url] autorelease];
        moviePlayer.shouldAutoplay = YES;
        
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        [center addObserver:self 
                   selector:@selector(moviePlaybackFinished:) 
                       name:MPMoviePlayerPlaybackDidFinishNotification
                     object:moviePlayer];
        
        moviePlayer.backgroundView.backgroundColor = [UIColor whiteColor];
        moviePlayer.controlStyle = MPMovieControlModeDefault;
        moviePlayer.view.frame = rect;

        [self.movieControllers insertObject:moviePlayer atIndex:self.currentMovieID];
        [self.scrollView addSubview:moviePlayer.view];
    }
    
    moviePlayer.view.hidden = NO;
    if (moviePlayer.playbackState != MPMoviePlaybackStatePlaying)
    {
        [moviePlayer play];
    }
    [self.scrollView scrollRectToVisible:rect animated:NO];
}

@end
