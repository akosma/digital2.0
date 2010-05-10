//
//  MainMenuController.m
//  Digital 2.0
//
//  Created by Adrian on 5/8/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import "MainMenuController.h"
#import "MainMenuView.h"

@interface MainMenuController ()

@property (nonatomic, retain) CADisplayLink *displayLink;
@property (nonatomic, retain) UIPopoverController *popover;

@end


@implementation MainMenuController

@synthesize displayLink = _displayLink;
@synthesize mainMenuView = _mainMenuView;
@synthesize akosmaInfoButton = _akosmaInfoButton;
@synthesize moserInfoButton = _moserInfoButton;
@synthesize vpsInfoButton = _vpsInfoButton;
@synthesize touchableView = _touchableView;
@synthesize popover = _popover;

- (void)dealloc 
{
    self.displayLink = nil;
    self.mainMenuView = nil;
    self.touchableView = nil;
    self.vpsInfoButton = nil;
    self.moserInfoButton = nil;
    self.akosmaInfoButton = nil;
    self.popover = nil;
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
    
    UITapGestureRecognizer *tapRecognizer = [[[UITapGestureRecognizer alloc] initWithTarget:self.mainMenuView
                                                                                     action:@selector(backToMenu)] autorelease];
    [self.touchableView addGestureRecognizer:tapRecognizer];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{
    return YES;
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
    NSLog(@"current tag: %d", tag);
    switch (tag) 
    {
        case 11:
            break;

        case 12:
            break;

        case 13:
            break;
            
        case 21:
            break;
            
        case 22:
            break;
            
        case 23:
            break;
            
        case 31:
            break;
            
        case 32:
            break;
            
        case 33:
            break;
            
        default:
            break;
    }
}

@end
