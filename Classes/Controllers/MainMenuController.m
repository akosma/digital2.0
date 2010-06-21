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
#import "RealTimeFeatureView.h"
#import "MakingOfFeatureView.h"
#import "MapFeatureView.h"
#import "FontFeatureView.h"
#import "ShopFeatureView.h"
#import "DemoAppDelegate.h"
#import "AboutController.h"
#import "SimulationFeatureView.h"
#import "ConnectivityFeatureView.h"

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
@synthesize aboutController = _aboutController;

- (void)dealloc 
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.moviePlayer = nil;
    self.mainMenuView = nil;
    self.vpsInfoButton = nil;
    self.moserInfoButton = nil;
    self.akosmaInfoButton = nil;
    self.popover = nil;
    self.soundManager = nil;
    self.featureView = nil;
    self.featureReferenceView = nil;
    self.aboutController = nil;
    [super dealloc];
}

- (void)viewDidLoad 
{
    [super viewDidLoad];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
#ifndef CONFIGURATION_Debug
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"tunnel_final2_8MB" ofType:@"mp4"];
    NSURL *url = [NSURL fileURLWithPath:path];
    self.moviePlayer = [[[MPMoviePlayerController alloc] initWithContentURL:url] autorelease];
    
    [center addObserver:self 
               selector:@selector(movieReady:) 
                   name:MPMoviePlayerLoadStateDidChangeNotification
                 object:self.moviePlayer];
    [center addObserver:self 
               selector:@selector(moviePlaybackFinished:) 
                   name:MPMoviePlayerPlaybackDidFinishNotification
                 object:self.moviePlayer];
    
    self.moviePlayer.view.frame = [DemoAppDelegate sharedAppDelegate].window.frame;
    self.moviePlayer.backgroundView.backgroundColor = [UIColor blackColor];
    self.moviePlayer.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.moviePlayer.scalingMode = MPMovieScalingModeAspectFill;
    self.moviePlayer.controlStyle = MPMovieControlModeDefault;

    [self.view addSubview:self.moviePlayer.view];
    self.view.alpha = 0.0;
    
#endif
    
    [center addObserver:self 
               selector:@selector(restoreMenu)
                   name:FeatureViewShouldMinimizeNotification 
                 object:nil];
}

- (void)restoreMenu
{
    [self.featureView minimize];
    self.featureView = nil;
    self.lastTag = -1;
    self.mainMenuView.minimized = NO;
    [self.mainMenuView backToMenu];
    self.featureReferenceView.backgroundColor = [UIColor whiteColor];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{
    return YES;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration
{
    [super willAnimateRotationToInterfaceOrientation:interfaceOrientation duration:duration];
    [self.popover dismissPopoverAnimated:YES];
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
    if (self.aboutController == nil)
    {
        self.aboutController = [AboutController controller];
    }

    if (self.popover == nil)
    {
        UIViewController *controller = [[[UIViewController alloc] init] autorelease];
        self.popover = [[[UIPopoverController alloc] initWithContentViewController:controller] autorelease];
        self.popover.popoverContentSize = CGSizeMake(245.0, 558.0);
        self.popover.contentViewController = self.aboutController;
    }

    if (sender == self.akosmaInfoButton)
    {
        self.aboutController.item = AboutControllerItemAkosma;
    }
    else if (sender == self.moserInfoButton)
    {
        self.aboutController.item = AboutControllerItemMoser;
    }
    else if (sender == self.vpsInfoButton)
    {
        self.aboutController.item = AboutControllerItemVPS;
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
    self.featureReferenceView.backgroundColor = [UIColor whiteColor];
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
                self.featureView = [FontFeatureView featureViewWithOrientation:self.interfaceOrientation];
                break;

            case 13:
                [self.soundManager.sound13 play];
                self.featureView = [ShopFeatureView featureViewWithOrientation:self.interfaceOrientation];
                break;
                
            case 21:
            {
                [self.soundManager.sound21 play];
                MovieFeatureView *view = [MovieFeatureView featureViewWithOrientation:self.interfaceOrientation];
                [view showCurrentMovie];
                self.featureView = view;
                break;
            }
                
            case 22:
            {
                [self.soundManager.sound22 play];
                self.featureView = [RealTimeFeatureView featureViewWithOrientation:self.interfaceOrientation];
                break;
            }
                
            case 23:
                [self.soundManager.sound23 play];
                self.featureView = [SimulationFeatureView featureViewWithOrientation:self.interfaceOrientation];
                break;
                
            case 31:
            {
                [self.soundManager.sound31 play];
                self.featureView = [MapFeatureView featureViewWithOrientation:self.interfaceOrientation];
            }
                break;
                
            case 32:
                [self.soundManager.sound32 play];
                self.featureView = [ConnectivityFeatureView featureViewWithOrientation:self.interfaceOrientation];
                break;
                
            case 33:
                [self.soundManager.sound33 play];
                self.featureView = [MakingOfFeatureView featureViewWithOrientation:self.interfaceOrientation];
                self.featureReferenceView.backgroundColor = [UIColor blackColor];
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
