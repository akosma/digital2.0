//
//  MainMenuController.m
//  Digital 2.0
//
//  Created by Adrian on 5/8/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import "MainMenuController.h"
#import "MainMenuView.h"
#import "SoundManager.h"
#import "FeatureView.h"
#import "FluidFeatureView.h"
#import "MovieFeatureView.h"
#import "WeatherFeatureView.h"

@interface MainMenuController ()

@property (nonatomic, retain) MPMoviePlayerController *moviePlayer;
@property (nonatomic, retain) UIPopoverController *popover;
@property (nonatomic, retain) SoundManager *soundManager;
@property (nonatomic, retain) FeatureView *featureView;
@property (nonatomic) NSInteger lastTag;

@end


@implementation MainMenuController

@synthesize moviePlayer = _moviePlayer;
@synthesize mainMenuView = _mainMenuView;
@synthesize akosmaInfoButton = _akosmaInfoButton;
@synthesize moserInfoButton = _moserInfoButton;
@synthesize vpsInfoButton = _vpsInfoButton;
@synthesize popover = _popover;
@synthesize soundManager = _soundManager;
@synthesize featureView = _featureView;
@synthesize featureReferenceView = _featureReferenceView;
@synthesize lastTag = _lastTag;

- (void)dealloc 
{
    self.moviePlayer = nil;
    self.mainMenuView = nil;
    self.vpsInfoButton = nil;
    self.moserInfoButton = nil;
    self.akosmaInfoButton = nil;
    self.popover = nil;
    self.soundManager = nil;
    self.featureView = nil;
    self.featureReferenceView = nil;
    [super dealloc];
}

- (void)viewDidLoad 
{
    [super viewDidLoad];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"tunnel" ofType:@"mp4"];
    NSURL *url = [NSURL fileURLWithPath:path];
    self.moviePlayer = [[[MPMoviePlayerController alloc] initWithContentURL:url] autorelease];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self 
               selector:@selector(movieReady:) 
                   name:MPMoviePlayerLoadStateDidChangeNotification
                 object:self.moviePlayer];
    [center addObserver:self 
               selector:@selector(moviePlaybackFinished:) 
                   name:MPMoviePlayerPlaybackDidFinishNotification
                 object:self.moviePlayer];
    
    self.moviePlayer.view.frame = [UIScreen mainScreen].bounds;
    self.moviePlayer.backgroundView.backgroundColor = [UIColor blackColor];
    self.moviePlayer.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.view addSubview:self.moviePlayer.view];
    self.view.alpha = 0.0;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{
    return YES;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration
{
    [super willAnimateRotationToInterfaceOrientation:interfaceOrientation duration:duration];
    [self.featureView willAnimateRotationToInterfaceOrientation:interfaceOrientation duration:duration];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    self.mainMenuView.orientation = self.interfaceOrientation;
}

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark IBAction methods

- (IBAction)showInfo:(id)sender
{
    if (sender == self.akosmaInfoButton)
    {
    }
    else if (sender == self.moserInfoButton)
    {
    }
    else if (sender == self.vpsInfoButton)
    {
    }

    if (self.popover == nil)
    {
        UIViewController *controller = [[[UIViewController alloc] init] autorelease];
        self.popover = [[[UIPopoverController alloc] initWithContentViewController:controller] autorelease];
        self.popover.popoverContentSize = CGSizeMake(200.0, 400.0);
    }
    [self.popover presentPopoverFromRect:[sender frame] 
                                  inView:self.view 
                permittedArrowDirections:UIPopoverArrowDirectionAny 
                                animated:YES];
}

#pragma mark -
#pragma mark MainMenuViewDelegate methods

- (void)mainMenu:(MainMenuView *)menu didSelectButtonWithTag:(NSInteger)tag
{
    if (self.lastTag == tag)
    {
        [self.featureView minimize];
        self.featureView = nil;
        self.lastTag = -1;
        self.mainMenuView.minimized = NO;
    }
    else
    {
        FeatureView *oldFeatureView = [self.featureView retain];
        [oldFeatureView minimize];
        self.featureView = nil;
        switch (tag) 
        {
            case 11:
            {
                [self.soundManager.sound11 play];
                self.featureView = [FluidFeatureView featureViewWithOrientation:self.interfaceOrientation];
                break;
            }

            case 12:
                [self.soundManager.sound12 play];
                break;

            case 13:
                [self.soundManager.sound13 play];
                break;
                
            case 21:
            {
                [self.soundManager.sound21 play];
                self.featureView = [MovieFeatureView featureViewWithOrientation:self.interfaceOrientation];
                break;
            }
                
            case 22:
            {
                [self.soundManager.sound22 play];
                self.featureView = [WeatherFeatureView featureViewWithOrientation:self.interfaceOrientation];
                break;
            }
                
            case 23:
                [self.soundManager.sound23 play];
                break;
                
            case 31:
                [self.soundManager.sound31 play];
                break;
                
            case 32:
                [self.soundManager.sound32 play];
                break;
                
            case 33:
                [self.soundManager.sound33 play];
                break;
                
            default:
                break;
        }
        [oldFeatureView release];
        [self.featureReferenceView insertSubview:self.featureView 
                                    belowSubview:self.mainMenuView.dockView];
        [self.featureView maximize];
        self.lastTag = tag;
    }
}

#pragma mark -
#pragma mark NSNotification handlers

- (void)movieReady:(NSNotification *)notification
{
    if (self.moviePlayer.loadState == 3)
    {
        self.view.alpha = 1.0;
        self.moviePlayer.scalingMode = MPMovieScalingModeAspectFit;
        self.moviePlayer.controlStyle = MPMovieControlModeDefault;
        [self.moviePlayer play];
    }
}

- (void)moviePlaybackFinished:(NSNotification *)notification
{
    self.mainMenuView.orientation = self.interfaceOrientation;
    self.soundManager = [SoundManager sharedSoundManager];
    self.lastTag = -1;
    self.mainMenuView.alpha = 1.0;

    [UIView beginAnimations:nil context:NULL];
    self.moviePlayer.view.alpha = 0.0;
    [UIView commitAnimations];
}

@end
