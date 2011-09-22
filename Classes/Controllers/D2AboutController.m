//
//  D2AboutController.m
//  Digital 2.0
//
//  Created by Adrian on 6/21/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import "D2AboutController.h"

static NSInteger NUM_PHOTOS = 8;


@interface D2AboutController ()

@property (nonatomic, retain) NSTimer *timer;
@property (nonatomic) NSInteger moserImageIndex;
@property (nonatomic, retain) MPMoviePlayerController *moviePlayer;

@end



@implementation D2AboutController

@synthesize item = _item;
@synthesize moserView = _moserView;
@synthesize vpsView = _vpsView;
@synthesize akosmaView = _akosmaView;
@synthesize vpsVideoView = _vpsVideoView;
@synthesize moserSampleView = _moserSampleView;
@synthesize timer = _timer;
@synthesize moserImageIndex = _moserImageIndex;
@synthesize moviePlayer = _moviePlayer;

+ (D2AboutController *)controller
{
    return [[[[self class] alloc] init] autorelease];
}

- (void)dealloc 
{
    [_moserView release];
    [_vpsView release];
    [_akosmaView release];
    [_vpsVideoView release];
    [_moserSampleView release];
    [_timer invalidate];
    [_timer release];
    if (_moviePlayer.playbackState == MPMoviePlaybackStatePlaying)
    {
        [_moviePlayer stop];
    }
    [_moviePlayer release];
    [super dealloc];
}

- (void)viewDidLoad 
{
    [super viewDidLoad];
    [self.view addSubview:self.moserView];
    [self.view addSubview:self.akosmaView];
    [self.view addSubview:self.vpsView];
    self.item = D2AboutControllerItemNone;
    
    self.moserSampleView.contentSize = CGSizeMake(205.0 * NUM_PHOTOS, 120.0);
    self.moserSampleView.pagingEnabled = YES;
    self.moserImageIndex = 0;
    for (NSInteger index = 0; index < NUM_PHOTOS; ++index)
    {
        NSString *name = [NSString stringWithFormat:@"photo_moser_00%d.jpg", (index + 1)];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:name]];
        imageView.frame = CGRectMake(index * 205.0, 0.0, 205.0, 120.0);
        [self.moserSampleView addSubview:imageView];
        [imageView release];
    }
}

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    switch (self.item) 
    {
        case D2AboutControllerItemVPS:
        {
            [[NSNotificationCenter defaultCenter] removeObserver:self];
            self.moviePlayer.currentPlaybackTime = self.moviePlayer.duration;
            [self.moviePlayer.view removeFromSuperview];
            self.moviePlayer = nil;
            break;
        }
            
        case D2AboutControllerItemAkosma:
        {
            break;
        }
            
        case D2AboutControllerItemMoser:
        {
            [self.timer invalidate];
            self.timer = nil;
            break;
        }
            
        default:
            break;
    }
}

#pragma mark - NSTimer methods

- (void)changeImage:(NSTimer *)theTimer
{
    self.moserImageIndex = (self.moserImageIndex + 1) % NUM_PHOTOS;
    CGRect rect = CGRectMake(self.moserImageIndex * 205.0, 0.0, 205.0, 120.0);
    [self.moserSampleView scrollRectToVisible:rect animated:YES];
}

#pragma mark - UIScrollViewDelegate methods

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (self.item == D2AboutControllerItemMoser)
    {
        [self.timer invalidate];
        self.timer = nil;
    }
}

#pragma mark - IBAction methods

- (IBAction)openWebsite:(id)sender
{
    switch (self.item) 
    {
        case D2AboutControllerItemVPS:
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.vpsprod.com/"]];
            break;

        case D2AboutControllerItemAkosma:
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://akosma.com/"]];
            break;
            
        case D2AboutControllerItemMoser:
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.moserdesign.ch/"]];
            break;

        default:
            break;
    }
}

#pragma mark - Overridden property

- (D2AboutControllerItem)item
{
    return _item;
}

- (void)setItem:(D2AboutControllerItem)newItem
{
    if (self.item != newItem)
    {
        _item = newItem;
        
        switch (_item) 
        {
            case D2AboutControllerItemVPS:
            {
                [self.view bringSubviewToFront:self.vpsView];
                [self.timer invalidate];
                self.timer = nil;

                NSString *path = [[NSBundle mainBundle] pathForResource:@"PRES_VPS_640x360_1000Kbs - iPhone" ofType:@"m4v"];
                NSURL *url = [NSURL fileURLWithPath:path];
                self.moviePlayer = [[[MPMoviePlayerController alloc] initWithContentURL:url] autorelease];
                self.moviePlayer.shouldAutoplay = YES;
                
                NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
                [center addObserver:self 
                           selector:@selector(moviePlaybackFinished:) 
                               name:MPMoviePlayerPlaybackDidFinishNotification
                             object:self.moviePlayer];
                
                self.moviePlayer.view.frame = self.vpsVideoView.frame;
                self.moviePlayer.view.contentMode = UIViewContentModeScaleAspectFill;
                self.moviePlayer.backgroundView.backgroundColor = [UIColor whiteColor];
                self.moviePlayer.controlStyle = MPMovieControlModeDefault;
                [self.vpsView addSubview:self.moviePlayer.view];
                
                break;
            }
                
            case D2AboutControllerItemAkosma:
            {
                [self.view bringSubviewToFront:self.akosmaView];
                [self.moviePlayer stop];
                [self.timer invalidate];
                self.timer = nil;
                break;
            }
                
            case D2AboutControllerItemMoser:
            {
                [self.view bringSubviewToFront:self.moserView];
                [self.moviePlayer stop];
                CGRect rect = CGRectMake(self.moserImageIndex * 205.0, 0.0, 205.0, 120.0);
                [self.moserSampleView scrollRectToVisible:rect animated:NO];
                [self.timer invalidate];
                self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0
                                                              target:self 
                                                            selector:@selector(changeImage:) 
                                                            userInfo:nil
                                                             repeats:YES];
                break;
            }
                
            default:
                break;
        }
    }
}

#pragma mark - NSNotification handlers

- (void)moviePlaybackFinished:(NSNotification *)notification
{
    [self.moviePlayer play];
}

@end
