//
//  D2MainMenuController.m
//  Digital 2.0
//
//  Created by Adrian on 5/8/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import "D2MainMenuController.h"
#import "D2MainMenuView.h"
#import "D2SoundManager.h"
#import "D2FeatureView.h"
#import "D2FluidFeatureView.h"
#import "D2MovieFeatureView.h"
#import "D2RealTimeFeatureView.h"
#import "D2MakingOfFeatureView.h"
#import "D2MapFeatureView.h"
#import "D2FontFeatureView.h"
#import "D2ShopFeatureView.h"
#import "D2AppDelegate.h"
#import "D2AboutController.h"
#import "D2SimulationFeatureView.h"
#import "D2ConnectivityFeatureView.h"
#import "MPMoviePlayerController+Extensions.h"

@interface D2MainMenuController ()

@property (nonatomic, retain) MPMoviePlayerController *moviePlayer;
@property (nonatomic, retain) UIPopoverController *popover;
@property (nonatomic, retain) D2SoundManager *soundManager;
@property (nonatomic, retain) D2FeatureView *featureView;
@property (nonatomic) NSInteger lastTag;
@property (nonatomic, retain) NSMutableDictionary *viewCache;
@property (nonatomic, retain) D2AboutController *aboutController;

- (void)restoreMenu;
- (void)shareViaEmail;
- (void)showCurrentFeatureInStandardScreen;
- (void)minimizeCurrentFeatureView;

@end


@implementation D2MainMenuController

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
    [_moviePlayer fullStop];
    [_moviePlayer release];
    [_mainMenuView release];
    [_vpsInfoButton release];
    [_moserInfoButton release];
    [_akosmaInfoButton release];
    [_popover release];
    [_soundManager release];
    [_featureView release];
    [_featureReferenceView release];
    [_aboutController release];
    [_viewCache release];

    [super dealloc];
}

- (void)viewDidLoad 
{
    [super viewDidLoad];
    self.viewCache = [NSMutableDictionary dictionaryWithCapacity:9];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    self.soundManager = [D2SoundManager sharedD2SoundManager];

    [center addObserver:self 
               selector:@selector(externalScreenAvailabilityChanged:) 
                   name:UIScreenDidConnectNotification 
                 object:nil];

    [center addObserver:self 
               selector:@selector(externalScreenAvailabilityChanged:) 
                   name:UIScreenDidDisconnectNotification
                 object:nil];
    
    [center addObserver:self 
               selector:@selector(shareViaEmail) 
                   name:D2ConnectivityFeatureViewOpenShareByEmailNotification 
                 object:nil];
    
    [center addObserver:self 
               selector:@selector(restoreMenu)
                   name:D2FeatureViewShouldMinimizeNotification 
                 object:nil];
    
#ifndef CONFIGURATION_Debug
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"tunnel_final2_8MB" ofType:@"mp4"];
    NSURL *url = [NSURL fileURLWithPath:path];
    self.moviePlayer = [[[MPMoviePlayerController alloc] init] autorelease];
    
    [center addObserver:self 
               selector:@selector(movieReady:) 
                   name:MPMoviePlayerLoadStateDidChangeNotification
                 object:self.moviePlayer];
    [center addObserver:self 
               selector:@selector(moviePlaybackFinished:) 
                   name:MPMoviePlayerPlaybackDidFinishNotification
                 object:self.moviePlayer];

    self.moviePlayer.backgroundView.backgroundColor = [UIColor blackColor];
    self.moviePlayer.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.moviePlayer.scalingMode = MPMovieScalingModeAspectFill;
    self.moviePlayer.controlStyle = MPMovieControlModeDefault;

    self.moviePlayer.contentURL = url;
    self.moviePlayer.view.frame = [D2AppDelegate sharedAppDelegate].window.frame;
    [self.view addSubview:self.moviePlayer.view];
    self.view.alpha = 0.0;
    
#endif
}

#pragma mark - Private methods

- (void)minimizeCurrentFeatureView
{
    [self.featureView minimize];
    self.featureReferenceView.backgroundColor = [UIColor whiteColor];
}

- (void)restoreMenu
{
    [self minimizeCurrentFeatureView];
    self.lastTag = -1;
    self.mainMenuView.minimized = NO;
    self.featureReferenceView.backgroundColor = [UIColor whiteColor];
}

- (void)shareViaEmail
{
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *composer = [[[MFMailComposeViewController alloc] init] autorelease];
        composer.mailComposeDelegate = self;
        
        NSString *title = NSLocalizedString(@"MAIN_MENU_CONTROLLER_EMAIL_SUBJECT", @"Subject line in the e-mail to share the application");
        NSString *path = [[NSBundle mainBundle] pathForResource:@"email" ofType:@"html"];
        NSString *body = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        [composer setSubject:title];
        [composer setMessageBody:body isHTML:YES];
        
        [self presentModalViewController:composer animated:YES];
    }
}

- (void)showCurrentFeatureInStandardScreen
{
    [self.featureReferenceView insertSubview:self.featureView 
                                belowSubview:self.mainMenuView.dockView];
    [self.featureView maximize];
    
    // This *must* be the last instruction!
    self.featureView.orientation = self.interfaceOrientation;
}

#pragma mark - MFMailComposeViewControllerDelegate methods

- (void)mailComposeController:(MFMailComposeViewController*)controller 
          didFinishWithResult:(MFMailComposeResult)result 
                        error:(NSError*)error
{
    [controller dismissModalViewControllerAnimated:YES];
}

#pragma mark - UIViewController methods

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

#pragma mark - IBAction methods

- (IBAction)showInfo:(id)sender
{
    if (self.aboutController == nil)
    {
        self.aboutController = [D2AboutController controller];
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
        self.aboutController.item = D2AboutControllerItemAkosma;
    }
    else if (sender == self.moserInfoButton)
    {
        self.aboutController.item = D2AboutControllerItemMoser;
    }
    else if (sender == self.vpsInfoButton)
    {
        self.aboutController.item = D2AboutControllerItemVPS;
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

#pragma mark - MainMenuViewDelegate methods

- (void)mainMenu:(D2MainMenuView *)menu didSelectButtonWithTag:(NSInteger)tag
{
    self.featureReferenceView.backgroundColor = [UIColor whiteColor];
    if (self.lastTag == tag)
    {
        [self minimizeCurrentFeatureView];
        self.lastTag = -1;
        self.mainMenuView.minimized = NO;
    }
    else
    {
        NSNumber *key = [NSNumber numberWithInt:tag];
        D2FeatureView *nextFeatureView = [self.viewCache objectForKey:key];
        SoundEffect *sound = nil;
        switch (tag) 
        {
            case 11:
            {
                sound = self.soundManager.sound11;
                if (nextFeatureView == nil)
                {
                    nextFeatureView = [D2FluidFeatureView featureViewWithOrientation:self.interfaceOrientation];
                }
                break;
            }

            case 12:
            {
                sound = self.soundManager.sound12;
                if (nextFeatureView == nil)
                {
                    nextFeatureView = [D2FontFeatureView featureViewWithOrientation:self.interfaceOrientation];
                }
                break;
            }

            case 13:
            {
                sound = self.soundManager.sound13;
                if (nextFeatureView == nil)
                {
                    nextFeatureView = [D2ShopFeatureView featureViewWithOrientation:self.interfaceOrientation];
                }
                break;
            }
                
            case 21:
            {
                sound = self.soundManager.sound21;
                if (nextFeatureView == nil)
                {
                    nextFeatureView = [D2MovieFeatureView featureViewWithOrientation:self.interfaceOrientation];
                }
                break;
            }
                
            case 22:
            {
                sound = self.soundManager.sound22;
                if (nextFeatureView == nil)
                {
                    nextFeatureView = [D2RealTimeFeatureView featureViewWithOrientation:self.interfaceOrientation];
                }
                break;
            }
                
            case 23:
            {
                sound = self.soundManager.sound23;
                if (nextFeatureView == nil)
                {
                    nextFeatureView = [D2SimulationFeatureView featureViewWithOrientation:self.interfaceOrientation];
                }
                break;
            }
                
            case 31:
            {
                sound = self.soundManager.sound31;
                if (nextFeatureView == nil)
                {
                    nextFeatureView = [D2MapFeatureView featureViewWithOrientation:self.interfaceOrientation];
                }
                break;
            }
                
            case 32:
            {
                sound = self.soundManager.sound32;
                if (nextFeatureView == nil)
                {
                    nextFeatureView = [D2ConnectivityFeatureView featureViewWithOrientation:self.interfaceOrientation];
                }
                break;
            }
                
            case 33:
            {
                sound = self.soundManager.sound33;
                if (nextFeatureView == nil)
                {
                    nextFeatureView = [D2MakingOfFeatureView featureViewWithOrientation:self.interfaceOrientation];
                    self.featureReferenceView.backgroundColor = [UIColor blackColor];
                }
                break;
            }
                
            default:
                break;
        }
        
        if (nextFeatureView.shouldBeCached)
        {
            [self.viewCache setObject:nextFeatureView forKey:key];
        }

        if (nextFeatureView.requiresNetwork && ![D2AppDelegate sharedAppDelegate].connectionAvailable)
        {
            NSString *message = NSLocalizedString(@"MAIN_MENU_CONTROLLER_REQUIRES_NETWORK", @"Message shown for features requiring a network connection");
            UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:nil
                                                             message:message 
                                                            delegate:nil
                                                   cancelButtonTitle:@"OK" 
                                                   otherButtonTitles:nil] autorelease];
            [alert show];
        }
        else
        {
            [self minimizeCurrentFeatureView];

            self.featureView = nextFeatureView;
            self.lastTag = tag;
            self.mainMenuView.minimized = YES;
            
            [self showCurrentFeatureInStandardScreen];
            [sound play];
        }
    }
}

#pragma mark - NSNotification handlers

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
    self.lastTag = -1;
    self.mainMenuView.alpha = 1.0;

    [UIView animateWithDuration:0.4 
                     animations:^{
                         self.moviePlayer.view.alpha = 0.0;
                     }];
    
    [[D2AppDelegate sharedAppDelegate].locationManager startUpdatingLocation];
    [[D2AppDelegate sharedAppDelegate].locationManager startUpdatingHeading];
}

@end
