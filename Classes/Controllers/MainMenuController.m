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
@property (nonatomic, retain) NSMutableDictionary *viewCache;

- (void)restoreMenu;
- (void)shareViaEmail;

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
@synthesize viewCache = _viewCache;

- (void)dealloc 
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.moviePlayer stop];
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
    self.viewCache = nil;

    [super dealloc];
}

- (void)viewDidLoad 
{
    [super viewDidLoad];
    self.viewCache = [NSMutableDictionary dictionaryWithCapacity:9];
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
               selector:@selector(shareViaEmail) 
                   name:ConnectivityFeatureViewOpenShareByEmailNotification 
                 object:nil];
    
    
    [center addObserver:self 
               selector:@selector(restoreMenu)
                   name:FeatureViewShouldMinimizeNotification 
                 object:nil];
}

#pragma mark -
#pragma mark Private methods

- (void)restoreMenu
{
    [self.featureView minimize];
    self.featureView = nil;
    self.lastTag = -1;
    self.mainMenuView.minimized = NO;
    self.featureReferenceView.backgroundColor = [UIColor whiteColor];
}

- (void)shareViaEmail
{
    MFMailComposeViewController *composer = [[MFMailComposeViewController alloc] init];
    composer.mailComposeDelegate = self;
    
    NSString *title = @"Check out Digital 2.0";
    NSString *body = @"Check out this great iPad app!";
    [composer setSubject:title];
    [composer setMessageBody:body isHTML:NO];
    
    [self presentModalViewController:composer animated:YES];
    [composer release];
}

#pragma mark -
#pragma mark MFMailComposeViewControllerDelegate methods

- (void)mailComposeController:(MFMailComposeViewController*)controller 
          didFinishWithResult:(MFMailComposeResult)result 
                        error:(NSError*)error
{
    [controller dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark UIViewController methods

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
    [self.viewCache removeAllObjects];
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

- (IBAction)backToHome:(id)sender
{
    [self restoreMenu];
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
        NSNumber *key = [NSNumber numberWithInt:tag];
        FeatureView *nextFeatureView = [self.viewCache objectForKey:key];
        SoundEffect *sound = nil;
        switch (tag) 
        {
            case 11:
            {
                sound = self.soundManager.sound11;
                if (nextFeatureView == nil)
                {
                    nextFeatureView = [FluidFeatureView featureViewWithOrientation:self.interfaceOrientation];
                    [self.viewCache setObject:nextFeatureView forKey:key];
                }
                break;
            }

            case 12:
            {
                sound = self.soundManager.sound12;
                if (nextFeatureView == nil)
                {
                    nextFeatureView = [FontFeatureView featureViewWithOrientation:self.interfaceOrientation];
                    [self.viewCache setObject:nextFeatureView forKey:key];
                }
                break;
            }

            case 13:
            {
                sound = self.soundManager.sound13;
                if (nextFeatureView == nil)
                {
                    nextFeatureView = [ShopFeatureView featureViewWithOrientation:self.interfaceOrientation];
                    [self.viewCache setObject:nextFeatureView forKey:key];
                }
                break;
            }
                
            case 21:
            {
                sound = self.soundManager.sound21;
                if (nextFeatureView == nil)
                {
                    nextFeatureView = [MovieFeatureView featureViewWithOrientation:self.interfaceOrientation];
                    [self.viewCache setObject:nextFeatureView forKey:key];
                }
                break;
            }
                
            case 22:
            {
                sound = self.soundManager.sound22;
                if (nextFeatureView == nil)
                {
                    nextFeatureView = [RealTimeFeatureView featureViewWithOrientation:self.interfaceOrientation];
                    [self.viewCache setObject:nextFeatureView forKey:key];
                }
                break;
            }
                
            case 23:
            {
                sound = self.soundManager.sound23;
                // For performance reasons, this view has a special treatment,
                // and is not kept in cache...!
                nextFeatureView = [SimulationFeatureView featureViewWithOrientation:self.interfaceOrientation];
                break;
            }
                
            case 31:
            {
                sound = self.soundManager.sound31;
                if (nextFeatureView == nil)
                {
                    nextFeatureView = [MapFeatureView featureViewWithOrientation:self.interfaceOrientation];
                    [self.viewCache setObject:nextFeatureView forKey:key];
                }
                break;
            }
                
            case 32:
            {
                sound = self.soundManager.sound32;
                if (nextFeatureView == nil)
                {
                    nextFeatureView = [ConnectivityFeatureView featureViewWithOrientation:self.interfaceOrientation];
                    [self.viewCache setObject:nextFeatureView forKey:key];
                }
                break;
            }
                
            case 33:
            {
                sound = self.soundManager.sound33;
                if (nextFeatureView == nil)
                {
                    nextFeatureView = [MakingOfFeatureView featureViewWithOrientation:self.interfaceOrientation];
                    self.featureReferenceView.backgroundColor = [UIColor blackColor];
                    [self.viewCache setObject:nextFeatureView forKey:key];
                }
                break;
            }
                
            default:
                break;
        }

        if (nextFeatureView.requiresNetwork && ![DemoAppDelegate sharedAppDelegate].connectionAvailable)
        {
            NSString *message = @"This feature requires a network connection.";
            UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:nil
                                                             message:message 
                                                            delegate:nil
                                                   cancelButtonTitle:@"OK" 
                                                   otherButtonTitles:nil] autorelease];
            [alert show];
        }
        else
        {
            [sound play];

            [self.featureView minimize];
            [self.featureView removeFromSuperview];
            self.featureView = nextFeatureView;
            [self.featureReferenceView insertSubview:self.featureView 
                                        belowSubview:self.mainMenuView.dockView];
            self.featureView.orientation = self.interfaceOrientation;
            [self.featureView maximize];
            self.lastTag = tag;
            self.mainMenuView.minimized = YES;
        }
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
    
    [[DemoAppDelegate sharedAppDelegate].locationManager startUpdatingLocation];
    [[DemoAppDelegate sharedAppDelegate].locationManager startUpdatingHeading];
}

@end
