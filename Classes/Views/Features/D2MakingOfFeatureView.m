//
//  D2MakingOfFeatureView.m
//  Digital 2.0
//
//  Created by Adrian on 6/6/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import "D2MakingOfFeatureView.h"
#import "MPMoviePlayerController+Extensions.h"

@interface D2MakingOfFeatureView ()

@property (nonatomic, retain) MPMoviePlayerController *moviePlayer;
@property (nonatomic, retain) UILabel *label;

@end


@implementation D2MakingOfFeatureView

@synthesize moviePlayer = _moviePlayer;
@synthesize label = _label;

- (id)initWithFrame:(CGRect)frame 
{
    if ((self = [super initWithFrame:frame])) 
    {
        self.shouldBeCached = NO;
        self.backgroundColor = [UIColor blackColor];
        
        self.label = [[[UILabel alloc] initWithFrame:CGRectMake(10.0, 10.0, 350.0, 60.0)] autorelease];
        self.label.text = @"Making of";
        self.label.font = [UIFont systemFontOfSize:38.0];
        self.label.textColor = [UIColor colorWithWhite:0.75 alpha:1.0];
        self.label.backgroundColor = [UIColor clearColor];
        [self addSubview:self.label];
    }
    return self;
}

- (void)dealloc 
{
    [_moviePlayer release];
    [super dealloc];
}

- (void)fadeLabel
{
    [UIView animateWithDuration:0.4 
                     animations:^{
                         self.label.alpha = 0.0;
                     }];
}

#pragma mark - Overridden methods

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

- (void)maximize
{
    [super maximize];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"making_of_final" ofType:@"mp4"];
    NSURL *url = [NSURL fileURLWithPath:path];
    self.moviePlayer.contentURL = url;
    self.moviePlayer.controlStyle = MPMovieControlModeDefault;
}

- (void)minimize
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.moviePlayer fullStop];
    self.moviePlayer = nil;
    [super minimize];
}

#pragma mark - Overridden getters

- (MPMoviePlayerController *)moviePlayer
{
    if (_moviePlayer == nil)
    {
        _moviePlayer = [[MPMoviePlayerController alloc] init];
        _moviePlayer.shouldAutoplay = YES;

        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        [center addObserver:self 
                   selector:@selector(moviePlaybackFinished:) 
                       name:MPMoviePlayerPlaybackDidFinishNotification
                     object:_moviePlayer];
        [center addObserver:self 
                   selector:@selector(movieReady:) 
                       name:MPMoviePlayerLoadStateDidChangeNotification
                     object:_moviePlayer];
        
        _moviePlayer.backgroundView.backgroundColor = [UIColor blackColor];
        [self addSubview:_moviePlayer.view];
    }
    return _moviePlayer;
}

#pragma mark - NSNotification handlers

- (void)moviePlaybackFinished:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] postNotificationName:FeatureViewShouldMinimizeNotification 
                                                        object:self];
}

- (void)movieReady:(NSNotification *)notification
{
    if (self.moviePlayer.loadState == 3)
    {
        self.moviePlayer.scalingMode = MPMovieScalingModeAspectFit;
        self.moviePlayer.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.moviePlayer.view.contentMode = UIViewContentModeScaleAspectFit;

        [self performSelector:@selector(fadeLabel) 
                   withObject:nil
                   afterDelay:3.0];
    }
}

@end
