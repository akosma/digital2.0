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

@interface MainMenuController ()

@property (nonatomic, retain) CADisplayLink *displayLink;
@property (nonatomic, retain) UIPopoverController *popover;
@property (nonatomic, retain) SoundManager *soundManager;
@property (nonatomic, retain) FeatureView *featureView;
@property (nonatomic) NSInteger lastTag;

@end


@implementation MainMenuController

@synthesize displayLink = _displayLink;
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
    self.displayLink = nil;
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
    self.mainMenuView.orientation = self.interfaceOrientation;
    self.displayLink = [CADisplayLink displayLinkWithTarget:self.mainMenuView 
                                                   selector:@selector(animate)];
    [self.displayLink setFrameInterval:1];
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    self.soundManager = [SoundManager sharedSoundManager];
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
        [oldFeatureView release];
        [self.featureReferenceView insertSubview:self.featureView 
                                    belowSubview:self.mainMenuView.dockView];
        [self.featureView maximize];
        self.lastTag = tag;
    }
}

@end
