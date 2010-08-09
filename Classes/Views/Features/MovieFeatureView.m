//
//  MovieFeatureView.m
//  Digital 2.0
//
//  Created by Adrian on 5/20/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import "MovieFeatureView.h"
#import "MPMoviePlayerController+Extensions.h"

@interface MovieFeatureView ()

@property (nonatomic, retain) MPMoviePlayerController *movieController;
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

@synthesize movieController = _movieController;
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
        self.shouldBeCached = NO;

        NSString *path = [[NSBundle mainBundle] pathForResource:@"MovieFeatureViewTexts" ofType:@"plist"];
        self.texts = [NSArray arrayWithContentsOfFile:path];
        path = [[NSBundle mainBundle] pathForResource:@"MovieFeatureViewTitles" ofType:@"plist"];
        self.titles = [NSArray arrayWithContentsOfFile:path];
        path = [[NSBundle mainBundle] pathForResource:@"MovieFeatureMovieNames" ofType:@"plist"];
        self.movieNames = [NSArray arrayWithContentsOfFile:path];
        self.currentMovieID = 0;

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
    [self.movieController fullStop];
    self.movieController = nil;
    
    self.texts = nil;
    self.movieNames = nil;
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
    self.movieController.view.frame = movieFrame;
    self.movieController.view.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)removeFromSuperview
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.currentMovieID = 0;
    [self.movieController fullStop];
    self.movieController = nil;
    
    // When FeatureViews are minimized, they are animated, which might trigger
    // a replay of the embedded video; in feature views with video, we
    // remove the video first, then remove the view from the hierarchy. 
    // This way, you don't get the audio going on without the video...!
    [super removeFromSuperview];
}

- (void)maximize
{
    [super maximize];
    self.currentMovieID = 0;
    [self showCurrentMovie];
}

#pragma mark -
#pragma mark NSNotification handlers

- (void)moviePlaybackFinished:(NSNotification *)notification
{
    [self nextMovie:self];
}

#pragma mark -
#pragma mark Overridden getter

- (MPMoviePlayerController *)movieController
{
    if (_movieController == nil)
    {
        _movieController = [[MPMoviePlayerController alloc] init];
        _movieController.shouldAutoplay = YES;
        
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        [center addObserver:self 
                   selector:@selector(moviePlaybackFinished:) 
                       name:MPMoviePlayerPlaybackDidFinishNotification
                     object:_movieController];
        
        _movieController.backgroundView.backgroundColor = [UIColor whiteColor];
        _movieController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _movieController.view.contentMode = UIViewContentModeScaleAspectFit;
        [self insertSubview:_movieController.view belowSubview:self.titleLabel];
    }
    return _movieController;
}

#pragma mark -
#pragma mark Private methods

- (void)showCurrentMovie
{
    self.rightButton.hidden = (self.currentMovieID == 2);
    self.leftButton.hidden = (self.currentMovieID == 0);
    
    NSString *name = [self.movieNames objectAtIndex:self.currentMovieID];
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"mp4"];
    NSURL *url = [NSURL fileURLWithPath:path];
    self.movieController.contentURL = url;
    self.movieController.controlStyle = MPMovieControlModeDefault;

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
