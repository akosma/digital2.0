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
@property (nonatomic, retain) NSArray *texts;
@property (nonatomic, retain) NSArray *titles;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UILabel *textLabel;
@property (nonatomic, retain) UIButton *rightButton;
@property (nonatomic, retain) UIButton *leftButton;

@end


@implementation MovieFeatureView

@synthesize movieControllers = _movieControllers;
@synthesize scrollView = _scrollView;
@synthesize currentMovieID = _currentMovieID;
@synthesize movieNames = _movieNames;
@synthesize texts = _texts;
@synthesize titles = _titles;
@synthesize titleLabel = _titleLabel;
@synthesize textLabel = _textLabel;
@synthesize rightButton = _rightButton;
@synthesize leftButton = _leftButton;

- (id)initWithFrame:(CGRect)frame 
{
    if ((self = [super initWithFrame:frame])) 
    {
        self.texts = [NSArray arrayWithObjects:@"The iPad screen offers very high resolution; it is essential to film in HD for an irreproachable image quality to do the support justice.", 
                      @"Keying is the key to integrating interactive video content into your iPad application.", 
                      @"Video contents, whether displayed in portrait or landscape mode, must adapt to the screen. This is a new way of thinking about image format. Remember... Think square!", nil];
        self.titles = [NSArray arrayWithObjects:@"HD or nothing.", 
                       @"Keying", 
                       @"Think square!", nil];
        self.movieNames = [NSArray arrayWithObjects:@"mini HD_1800", @"mini key_1800", @"minisquare_1800", nil];
        NSInteger count = [self.movieNames count];
        self.currentMovieID = 0;
        self.movieControllers = [NSMutableArray arrayWithCapacity:count];
        self.scrollView = [[[UIScrollView alloc] initWithFrame:frame] autorelease];
        self.scrollView.contentSize = CGSizeMake(frame.size.width * count, frame.size.height);
        self.scrollView.pagingEnabled = YES;
        self.scrollView.delegate = self;
        [self addSubview:self.scrollView];

        self.titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(10.0, 10.0, 150.0, 50.0)] autorelease];
        self.titleLabel.font = [UIFont systemFontOfSize:19.0];
        self.titleLabel.textColor = [UIColor colorWithWhite:0.75 alpha:1.0];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.titleLabel];

        self.textLabel = [[[UILabel alloc] initWithFrame:CGRectMake(10.0, 50.0, 150.0, 250.0)] autorelease];
        self.textLabel.font = [UIFont systemFontOfSize:17.0];
        self.textLabel.numberOfLines = 0;
        self.textLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.textLabel];
        
        self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.rightButton setTitle:@">" forState:UIControlStateNormal];
        [self.rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.rightButton.titleLabel.font = [UIFont boldSystemFontOfSize:30.0];
        self.rightButton.titleLabel.textColor = [UIColor blackColor];
        [self.rightButton addTarget:self 
                             action:@selector(nextMovie:) 
                   forControlEvents:UIControlEventTouchDown];
        [self addSubview:self.rightButton];

        self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.leftButton setTitle:@"<" forState:UIControlStateNormal];
        [self.leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.leftButton.titleLabel.font = [UIFont boldSystemFontOfSize:30.0];
        [self.leftButton addTarget:self 
                            action:@selector(previousMovie:) 
                  forControlEvents:UIControlEventTouchDown];
        [self addSubview:self.leftButton];
    }
    return self;
}

- (void)dealloc 
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    for (MPMoviePlayerController *player in self.movieControllers)
    {
        player.currentPlaybackTime = player.duration;
        [player.view removeFromSuperview];
    }
    self.movieControllers = nil;
    
    self.texts = nil;
    self.movieNames = nil;
    self.movieControllers = nil;
    self.scrollView = nil;
    self.titleLabel = nil;
    self.textLabel = nil;
    self.rightButton = nil;
    self.leftButton = nil;
    [super dealloc];
}

#pragma mark -
#pragma mark IBAction methods

- (IBAction)nextMovie:(id)sender
{
    self.currentMovieID = (self.currentMovieID + 1) % [self.movieNames count];
    [self showCurrentMovie];
}

- (IBAction)previousMovie:(id)sender
{
    self.currentMovieID = (self.currentMovieID - 1) % [self.movieNames count];
    [self showCurrentMovie];
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
    
    NSString *text = [self.texts objectAtIndex:self.currentMovieID];
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:17.0]
                   constrainedToSize:CGSizeMake(660.0, 2000.0)];
    
    CGRect movieFrame = CGRectMake(0.0, 50.0, 1024.0, 500.0);
    CGRect titleLabelFrame = CGRectMake(80.0, 550.0, 150.0, 25.0);
    CGRect textLabelFrame = CGRectMake(240.0, 552.0, 660.0, size.height);
    CGRect rightButtonFrame = CGRectMake(994.0, 550.0, 30.0, 30.0);
    CGRect leftButtonFrame = CGRectMake(0.0, 550.0, 30.0, 30.0);
    
    if (UIInterfaceOrientationIsPortrait(newOrientation))
    {
        size = [text sizeWithFont:[UIFont systemFontOfSize:17.0]
                constrainedToSize:CGSizeMake(500.0, 2000.0)];
        movieFrame = CGRectMake(0.0, 50.0, 768.0, 724.0);
        titleLabelFrame = CGRectMake(50.0, 774.0, 150.0, 25.0);
        textLabelFrame = CGRectMake(200.0, 776.0, 500.0, size.height);
        rightButtonFrame = CGRectMake(738.0, 774.0, 30.0, 30.0);
        leftButtonFrame = CGRectMake(0.0, 774.0, 30.0, 30.0);
    }
    
    self.rightButton.frame = rightButtonFrame;
    self.leftButton.frame = leftButtonFrame;
    self.titleLabel.frame = titleLabelFrame;
    self.textLabel.frame = textLabelFrame;
    self.scrollView.frame = movieFrame;
    NSInteger count = [self.movieNames count];
    self.scrollView.contentSize = CGSizeMake(movieFrame.size.width * count, movieFrame.size.height);
    CGRect rect = CGRectMake(self.currentMovieID * movieFrame.size.width, 0.0, movieFrame.size.width, movieFrame.size.height);
    NSInteger index = 0;
    for (MPMoviePlayerController *player in self.movieControllers)
    {
        CGRect movieRect = CGRectMake(index * movieFrame.size.width, 0.0, movieFrame.size.width, movieFrame.size.height);
        player.view.frame = movieRect;
        player.view.contentMode = UIViewContentModeScaleAspectFit;
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
    for (MPMoviePlayerController *player in self.movieControllers)
    {
        player.currentPlaybackTime = player.duration;
        [player.view removeFromSuperview];
    }
    [self nextMovie:self];
}

#pragma mark -
#pragma mark Private methods

- (void)showCurrentMovie
{
    self.rightButton.hidden = (self.currentMovieID == 2);
    self.leftButton.hidden = (self.currentMovieID == 0);
    
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
    
    self.titleLabel.text = [self.titles objectAtIndex:self.currentMovieID];
    self.textLabel.text = [self.texts objectAtIndex:self.currentMovieID];

    NSString *text = [self.texts objectAtIndex:self.currentMovieID];
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:17.0]
                   constrainedToSize:CGSizeMake(self.textLabel.frame.size.width, 2000.0)];

    self.textLabel.frame = CGRectMake(self.textLabel.frame.origin.x, 
                                      self.textLabel.frame.origin.y, 
                                      self.textLabel.frame.size.width, 
                                      size.height);
}

@end
