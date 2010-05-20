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
#import "FluidFeatureView.h"

@interface MainMenuController ()

@property (nonatomic, retain) CADisplayLink *displayLink;
@property (nonatomic, retain) UIPopoverController *popover;
@property (nonatomic, retain) MPMoviePlayerController *moviePlayer;
@property (nonatomic, retain) SoundManager *soundManager;
@property (nonatomic, retain) FluidFeatureView *fluidFeatureView;

@end


@implementation MainMenuController

@synthesize displayLink = _displayLink;
@synthesize mainMenuView = _mainMenuView;
@synthesize akosmaInfoButton = _akosmaInfoButton;
@synthesize moserInfoButton = _moserInfoButton;
@synthesize vpsInfoButton = _vpsInfoButton;
@synthesize touchableView = _touchableView;
@synthesize popover = _popover;
@synthesize moviePlayer = _moviePlayer;
@synthesize soundManager = _soundManager;
@synthesize fluidFeatureView = _fluidFeatureView;

- (void)dealloc 
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.displayLink = nil;
    self.mainMenuView = nil;
    self.touchableView = nil;
    self.vpsInfoButton = nil;
    self.moserInfoButton = nil;
    self.akosmaInfoButton = nil;
    self.popover = nil;
    self.moviePlayer = nil;
    self.soundManager = nil;
    self.fluidFeatureView = nil;
    [super dealloc];
}

- (void)viewDidLoad 
{
    [super viewDidLoad];
    self.mainMenuView.orientation = self.interfaceOrientation;
    self.displayLink = [CADisplayLink displayLinkWithTarget:self.mainMenuView 
                                                   selector:@selector(animate)];
    [self.displayLink setFrameInterval:1];
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    self.soundManager = [SoundManager sharedSoundManager];
    
    UITapGestureRecognizer *tapRecognizer = [[[UITapGestureRecognizer alloc] initWithTarget:self.mainMenuView
                                                                                     action:@selector(backToMenu)] autorelease];
    [self.touchableView addGestureRecognizer:tapRecognizer];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{
    return YES;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration
{
    [super willAnimateRotationToInterfaceOrientation:interfaceOrientation duration:duration];
    [self.fluidFeatureView willAnimateRotationToInterfaceOrientation:interfaceOrientation duration:duration];
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
    switch (tag) 
    {
        case 11:
            [self.soundManager.sound11 play];
            
            if (self.fluidFeatureView == nil)
            {
                self.fluidFeatureView = [[[FluidFeatureView alloc] initWithFrame:CGRectMake(0.0, 0.0, 768.0, 1004.0)] autorelease];
                self.fluidFeatureView.orientation = self.interfaceOrientation;
                self.fluidFeatureView.transform = CGAffineTransformMakeScale(0.1, 0.1);
            }
            [self.view addSubview:self.fluidFeatureView];
            [UIView beginAnimations:nil context:NULL];
            self.fluidFeatureView.transform = CGAffineTransformIdentity;
            [UIView commitAnimations];
            break;

        case 12:
            [self.soundManager.sound12 play];
            break;

        case 13:
            [self.soundManager.sound13 play];
            break;
            
        case 21:
        {
            [self.soundManager.sound21 play];
            if (self.moviePlayer == nil)
            {
                NSString *path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"mp4"];
                NSURL *url = [NSURL fileURLWithPath:path];
                self.moviePlayer = [[[MPMoviePlayerController alloc] initWithContentURL:url] autorelease];
                self.moviePlayer.shouldAutoplay = YES;
                self.moviePlayer.view.frame = CGRectInset(self.view.bounds, 100.0, 100.0);
                self.moviePlayer.view.transform = CGAffineTransformMakeScale(0.1, 0.1);
                self.moviePlayer.backgroundView.backgroundColor = [UIColor whiteColor];
                
                [[NSNotificationCenter defaultCenter] addObserver:self 
                                                         selector:@selector(moviePlaybackFinished:) 
                                                             name:MPMoviePlayerPlaybackDidFinishNotification 
                                                           object:self.moviePlayer];
                [[NSNotificationCenter defaultCenter] addObserver:self 
                                                         selector:@selector(moviePlaybackFinished:) 
                                                             name:MPMoviePlayerDidExitFullscreenNotification
                                                           object:self.moviePlayer];
            }
            [self.view addSubview:self.moviePlayer.view];
            [UIView beginAnimations:nil context:NULL];
            self.moviePlayer.view.transform = CGAffineTransformIdentity;
            [UIView commitAnimations];
            break;
        }
            
        case 22:
            [self.soundManager.sound22 play];
            break;
            
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
}

#pragma mark -
#pragma mark NSNotification handlers

- (void)moviePlaybackFinished:(id)sender
{
    [self.moviePlayer.view removeFromSuperview];
    self.moviePlayer.view.transform = CGAffineTransformMakeScale(0.1, 0.1);
    [self.mainMenuView backToMenu];
}

@end
