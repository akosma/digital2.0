//
//  D2ShopFeatureView.m
//  Digital 2.0
//
//  Created by Adrian on 6/6/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import "D2ShopFeatureView.h"
#import "MPMoviePlayerController+Extensions.h"

typedef enum {
    D2ShopFeatureViewCurrentDressNone = 0,
    D2ShopFeatureViewCurrentDressCity = 1,
    D2ShopFeatureViewCurrentDressBeach = 2,
    D2ShopFeatureViewCurrentDressNight = 3,
    D2ShopFeatureViewCurrentDressGolf = 4
} D2ShopFeatureViewCurrentDress;


@interface D2ShopFeatureView ()

@property (nonatomic) D2ShopFeatureViewCurrentDress currentDress;
@property (nonatomic, assign) UIImageView *currentDressImage;
@property (nonatomic) CGPoint originalDragPoint;
@property (nonatomic) CGPoint lastRegisteredPoint;
@property (nonatomic) CGRect dressCityFrame;
@property (nonatomic) CGRect dressBeachFrame;
@property (nonatomic) CGRect dressNightFrame;
@property (nonatomic) CGRect dressGolfFrame;
@property (nonatomic) BOOL defileMode;
@property (nonatomic, retain) MPMoviePlayerController *moviePlayer;

- (void)loadMovieFromURL:(NSURL *)url;

@end



@implementation D2ShopFeatureView

@synthesize contourCity = _contourCity;
@synthesize dressCity = _dressCity;
@synthesize contourBeach = _contourBeach;
@synthesize dressBeach = _dressBeach;
@synthesize contourNight = _contourNight;
@synthesize dressNight = _dressNight;
@synthesize contourGolf = _contourGolf;
@synthesize dressGolf = _dressGolf;
@synthesize titleLabel = _titleLabel;
@synthesize descriptionLabel = _descriptionLabel;
@synthesize cityPriceLabel = _cityPriceLabel;
@synthesize plagePriceLabel = _plagePriceLabel;
@synthesize nightPriceLabel = _nightPriceLabel;
@synthesize golfPriceLabel = _golfPriceLabel;
@synthesize videoView = _videoView;
@synthesize mainView = _mainView;
@synthesize currentDress = _currentDress;
@synthesize currentDressImage = _currentDressImage;
@synthesize originalDragPoint = _originalDragPoint;
@synthesize lastRegisteredPoint = _lastRegisteredPoint;
@synthesize dressCityFrame = _dressCityFrame;
@synthesize dressBeachFrame = _dressBeachFrame;
@synthesize dressNightFrame = _dressNightFrame;
@synthesize dressGolfFrame = _dressGolfFrame;
@synthesize moviePlayer = _moviePlayer;
@synthesize defileMode = _defileMode;


- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [[NSBundle mainBundle] loadNibNamed:@"D2ShopFeatureView" 
                                      owner:self
                                    options:nil];

        self.shouldBeCached = NO;
        self.defileMode = NO;
        self.videoView.backgroundColor = [UIColor clearColor];
        
        UIPanGestureRecognizer *recognizer1 = [[[UIPanGestureRecognizer alloc] initWithTarget:self 
                                                                                       action:@selector(drag:)] autorelease];
        UIPanGestureRecognizer *recognizer2 = [[[UIPanGestureRecognizer alloc] initWithTarget:self 
                                                                                       action:@selector(drag:)] autorelease];
        UIPanGestureRecognizer *recognizer3 = [[[UIPanGestureRecognizer alloc] initWithTarget:self 
                                                                                       action:@selector(drag:)] autorelease];
        UIPanGestureRecognizer *recognizer4 = [[[UIPanGestureRecognizer alloc] initWithTarget:self 
                                                                                       action:@selector(drag:)] autorelease];
        
        UITapGestureRecognizer *recognizer5 = [[[UITapGestureRecognizer alloc] initWithTarget:self 
                                                                                       action:@selector(tap:)] autorelease];
        UITapGestureRecognizer *recognizer6 = [[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                       action:@selector(tap:)] autorelease];
        UITapGestureRecognizer *recognizer7 = [[[UITapGestureRecognizer alloc] initWithTarget:self 
                                                                                       action:@selector(tap:)] autorelease];
        UITapGestureRecognizer *recognizer8 = [[[UITapGestureRecognizer alloc] initWithTarget:self 
                                                                                       action:@selector(tap:)] autorelease];

        [self.dressCity addGestureRecognizer:recognizer1];
        [self.dressCity addGestureRecognizer:recognizer5];
        
        [self.dressGolf addGestureRecognizer:recognizer2];
        [self.dressGolf addGestureRecognizer:recognizer6];

        [self.dressBeach addGestureRecognizer:recognizer3];
        [self.dressBeach addGestureRecognizer:recognizer7];
        
        [self.dressNight addGestureRecognizer:recognizer4];
        [self.dressNight addGestureRecognizer:recognizer8];
        
        [self addSubview:self.mainView];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [_contourCity release];
    [_dressCity release];
    [_contourBeach release];
    [_dressBeach release];
    [_contourNight release];
    [_dressNight release];
    [_contourGolf release];
    [_dressGolf release];
    [_titleLabel release];
    [_descriptionLabel release];
    [_cityPriceLabel release];
    [_plagePriceLabel release];
    [_nightPriceLabel release];
    [_golfPriceLabel release];
    [_videoView release];
    [_mainView release];
    [_currentDressImage release];

    [super dealloc];
}
                                              
#pragma mark -
#pragma mark Gesture recognizer methods

- (void)tap:(UIGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateEnded)
    {
        self.currentDressImage = (UIImageView *)recognizer.view;
        if (self.currentDressImage == self.dressCity)
        {
            self.currentDress = D2ShopFeatureViewCurrentDressCity;
        }
        else if (self.currentDressImage == self.dressBeach)
        {
            self.currentDress = D2ShopFeatureViewCurrentDressBeach;
        }
        else if (self.currentDressImage == self.dressNight)
        {
            self.currentDress = D2ShopFeatureViewCurrentDressNight;
        }
        else if (self.currentDressImage == self.dressGolf)
        {
            self.currentDress = D2ShopFeatureViewCurrentDressGolf;
        }
    }
}

- (void)drag:(UIGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateBegan)
    {
        self.currentDressImage = (UIImageView *)recognizer.view;
        [self.mainView bringSubviewToFront:self.currentDressImage];
        // Change the dress for its contour
        if (self.currentDressImage == self.dressCity)
        {
            self.contourCity.hidden = NO;
        }
        else if (self.currentDressImage == self.dressBeach)
        {
            self.contourBeach.hidden = NO;
        }
        else if (self.currentDressImage == self.dressNight)
        {
            self.contourNight.hidden = NO;
        }
        else if (self.currentDressImage == self.dressGolf)
        {
            self.contourGolf.hidden = NO;
        }
        self.originalDragPoint = [recognizer locationInView:self.currentDressImage];
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged)
    {
        // Move the dress around
        self.lastRegisteredPoint = [recognizer locationInView:self];
        CGFloat x = self.lastRegisteredPoint.x - self.originalDragPoint.x;
        CGFloat y = self.lastRegisteredPoint.y - self.originalDragPoint.y;
        self.currentDressImage.frame = CGRectMake(x, y, 
                                             self.currentDressImage.frame.size.width, 
                                             self.currentDressImage.frame.size.height);
        
        if (CGRectContainsPoint(self.videoView.frame, self.lastRegisteredPoint))
        {
            self.videoView.backgroundColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.2];
        }
        else
        {
            self.videoView.backgroundColor = [UIColor clearColor];
        }
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded)
    {
        // Either restore the dress to its place, or change the video, 
        // depending on where the gesture ended
        self.videoView.backgroundColor = [UIColor clearColor];
        if (CGRectContainsPoint(self.videoView.frame, self.lastRegisteredPoint))
        {
            if (self.currentDressImage == self.dressCity)
            {
                self.currentDress = D2ShopFeatureViewCurrentDressCity;
            }
            else if (self.currentDressImage == self.dressBeach)
            {
                self.currentDress = D2ShopFeatureViewCurrentDressBeach;
            }
            else if (self.currentDressImage == self.dressNight)
            {
                self.currentDress = D2ShopFeatureViewCurrentDressNight;
            }
            else if (self.currentDressImage == self.dressGolf)
            {
                self.currentDress = D2ShopFeatureViewCurrentDressGolf;
            }
        }
        else
        {
            [UIView animateWithDuration:0.4 
                             animations:^{
                                 if (self.currentDressImage == self.dressCity)
                                 {
                                     self.contourCity.hidden = YES;
                                     self.dressCity.frame = self.dressCityFrame;
                                 }
                                 else if (self.currentDressImage == self.dressBeach)
                                 {
                                     self.contourBeach.hidden = YES;
                                     self.dressBeach.frame = self.dressBeachFrame;
                                 }
                                 else if (self.currentDressImage == self.dressNight)
                                 {
                                     self.contourNight.hidden = YES;
                                     self.dressNight.frame = self.dressNightFrame;
                                 }
                                 else if (self.currentDressImage == self.dressGolf)
                                 {
                                     self.contourGolf.hidden = YES;
                                     self.dressGolf.frame = self.dressGolfFrame;
                                 }
                             }];
        }
    }
}

#pragma mark - Overridden methods

- (void)minimize
{
    [self.moviePlayer fullStop];
    self.moviePlayer = nil;
    [super minimize];
}

- (void)maximize
{
    [super maximize];
    self.currentDress = D2ShopFeatureViewCurrentDressCity;
}

- (void)setOrientation:(UIInterfaceOrientation)newOrientation
{
    [super setOrientation:newOrientation];

    self.dressCityFrame = CGRectMake(591.0, 20.0, 150.0, 230.0);
    self.dressBeachFrame = CGRectMake(816.0, 20.0, 150.0, 230.0);
    self.dressNightFrame = CGRectMake(558.0, 331.0, 150.0, 230.0);
    self.dressGolfFrame = CGRectMake(789.0, 331.0, 150.0, 230.0);
    
    CGRect contourCityFrame = CGRectMake(591.0, 20.0, 150.0, 230.0);
    CGRect contourBeachFrame = CGRectMake(816.0, 20.0, 150.0, 230.0);
    CGRect contourNightFrame = CGRectMake(558.0, 331.0, 150.0, 230.0);
    CGRect contourGolfFrame = CGRectMake(789.0, 331.0, 150.0, 230.0);
    CGRect titleLabelFrame = CGRectMake(20.0, 478.0, 455.0, 35.0);
    CGRect descriptionLabelFrame = CGRectMake(20.0, 521.0, 404.0, 95.0);
    CGRect cityPriceLabelFrame = CGRectMake(542.0, 258.0, 121.0, 47.0);
    CGRect plagePriceLabelFrame = CGRectMake(756.0, 258.0, 121.0, 47.0);
    CGRect nightPriceLabelFrame = CGRectMake(542.0, 569.0, 121.0, 47.0);
    CGRect golfPriceLabelFrame = CGRectMake(756.0, 569.0, 121.0, 47.0);
    CGRect videoViewFrame = CGRectMake(55.0, 20.0, 450.0, 450.0);
    
    if (UIInterfaceOrientationIsPortrait(newOrientation))
    {
        contourCityFrame = CGRectMake(20.0, 22.0, 201.0, 300.0);
        self.dressCityFrame = CGRectMake(49.0, 22.0, 143.0, 300.0);
        contourBeachFrame = CGRectMake(207.0, 22.0, 205.0, 300.0);
        self.dressBeachFrame = CGRectMake(244.0, 22.0, 130.0, 300.0);
        contourNightFrame = CGRectMake(372.0, 22.0, 251.0, 300.0);
        self.dressNightFrame = CGRectMake(423.0, 22.0, 149.0, 300.0);
        contourGolfFrame = CGRectMake(585.0, 22.0, 201.0, 300.0);
        self.dressGolfFrame = CGRectMake(624.0, 22.0, 124.0, 300.0);
        titleLabelFrame = CGRectMake(525.0, 637.0, 223.0, 51.0);
        descriptionLabelFrame = CGRectMake(525.0, 696.0, 223.0, 168.0);
        cityPriceLabelFrame = CGRectMake(0.0, 345.0, 121.0, 47.0);
        plagePriceLabelFrame = CGRectMake(184.0, 345.0, 121.0, 47.0);
        nightPriceLabelFrame = CGRectMake(354.0, 345.0, 121.0, 47.0);
        golfPriceLabelFrame = CGRectMake(567.0, 345.0, 121.0, 47.0);
        videoViewFrame = CGRectMake(39.0, 400.0, 470.0, 470.0);
    }
    
    self.contourCity.frame = contourCityFrame;
    self.dressCity.frame = self.dressCityFrame;
    self.contourBeach.frame = contourBeachFrame;
    self.dressBeach.frame = self.dressBeachFrame;
    self.contourNight.frame = contourNightFrame;
    self.dressNight.frame = self.dressNightFrame;
    self.contourGolf.frame = contourGolfFrame;
    self.dressGolf.frame = self.dressGolfFrame;
    self.titleLabel.frame = titleLabelFrame;
    self.descriptionLabel.frame = descriptionLabelFrame;
    self.cityPriceLabel.frame = cityPriceLabelFrame;
    self.plagePriceLabel.frame = plagePriceLabelFrame;
    self.nightPriceLabel.frame = nightPriceLabelFrame;
    self.golfPriceLabel.frame = golfPriceLabelFrame;
    self.videoView.frame = videoViewFrame;
    self.moviePlayer.view.frame = videoViewFrame;
}

#pragma mark - NSNotification handlers

- (void)moviePlaybackFinished:(NSNotification *)notification
{
    if (self.defileMode)
    {
        self.defileMode = NO;
        switch (self.currentDress) 
        {
            case D2ShopFeatureViewCurrentDressBeach:
            {
                NSString *path = [[NSBundle mainBundle] pathForResource:@"beach1" ofType:@"mp4"];
                NSURL *url = [NSURL fileURLWithPath:path];
                [self loadMovieFromURL:url];
                break;
            }
                
            case D2ShopFeatureViewCurrentDressGolf:
            {
                NSString *path = [[NSBundle mainBundle] pathForResource:@"golf1" ofType:@"mp4"];
                NSURL *url = [NSURL fileURLWithPath:path];
                [self loadMovieFromURL:url];
                break;
            }
                
            case D2ShopFeatureViewCurrentDressNight:
            {
                NSString *path = [[NSBundle mainBundle] pathForResource:@"night1" ofType:@"mp4"];
                NSURL *url = [NSURL fileURLWithPath:path];
                [self loadMovieFromURL:url];
                break;
            }
                
            default:
                break;
        }
    }
    else
    {
        [self.moviePlayer play];
    }
}

#pragma mark - Private methods

- (void)setCurrentDress:(D2ShopFeatureViewCurrentDress)dress
{
    if (dress != self.currentDress)
    {
        _currentDress = dress;

        if (self.currentDress != D2ShopFeatureViewCurrentDressNone)
        {
            self.contourCity.hidden = (self.currentDress != D2ShopFeatureViewCurrentDressCity);
            self.contourBeach.hidden = (self.currentDress != D2ShopFeatureViewCurrentDressBeach);
            self.contourNight.hidden = (self.currentDress != D2ShopFeatureViewCurrentDressNight);
            self.contourGolf.hidden = (self.currentDress != D2ShopFeatureViewCurrentDressGolf);

            self.dressCity.hidden = !self.contourCity.hidden;
            self.dressBeach.hidden = !self.contourBeach.hidden;
            self.dressNight.hidden = !self.contourNight.hidden;
            self.dressGolf.hidden = !self.contourGolf.hidden;
            
            self.dressCity.frame = self.dressCityFrame;
            self.dressBeach.frame = self.dressBeachFrame;
            self.dressNight.frame = self.dressNightFrame;
            self.dressGolf.frame = self.dressGolfFrame;

            switch (self.currentDress) 
            {
                case D2ShopFeatureViewCurrentDressBeach:
                {
                    self.defileMode = YES;
                    NSString *path = [[NSBundle mainBundle] pathForResource:@"beach2" ofType:@"mp4"];
                    NSURL *url = [NSURL fileURLWithPath:path];
                    [self loadMovieFromURL:url];
                    break;
                }
                    
                case D2ShopFeatureViewCurrentDressCity:
                {
                    self.defileMode = NO;
                    NSString *path = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"mp4"];
                    NSURL *url = [NSURL fileURLWithPath:path];
                    [self loadMovieFromURL:url];
                    break;
                }
                    
                case D2ShopFeatureViewCurrentDressGolf:
                {
                    self.defileMode = YES;
                    NSString *path = [[NSBundle mainBundle] pathForResource:@"golf2" ofType:@"mp4"];
                    NSURL *url = [NSURL fileURLWithPath:path];
                    [self loadMovieFromURL:url];
                    break;
                }
                    
                case D2ShopFeatureViewCurrentDressNight:
                {
                    self.defileMode = YES;
                    NSString *path = [[NSBundle mainBundle] pathForResource:@"night2" ofType:@"mp4"];
                    NSURL *url = [NSURL fileURLWithPath:path];
                    [self loadMovieFromURL:url];
                    break;
                }
                    
                default:
                    break;
            }
        }
    }
}

- (void)loadMovieFromURL:(NSURL *)url
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self
                      name:MPMoviePlayerPlaybackDidFinishNotification 
                    object:self.moviePlayer];

    [self.moviePlayer.view removeFromSuperview];
    [self.moviePlayer stop];
    self.moviePlayer = [[[MPMoviePlayerController alloc] init] autorelease];
    self.moviePlayer.shouldAutoplay = YES;
    self.moviePlayer.view.frame = self.videoView.frame;
    self.moviePlayer.contentURL = url;
    self.moviePlayer.controlStyle = MPMovieControlModeDefault;
    [self.mainView insertSubview:self.moviePlayer.view belowSubview:self.videoView];

    [center addObserver:self 
               selector:@selector(moviePlaybackFinished:) 
                   name:MPMoviePlayerPlaybackDidFinishNotification
                 object:self.moviePlayer];
}

@end
