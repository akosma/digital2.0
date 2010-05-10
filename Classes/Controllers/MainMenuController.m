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

@end


@implementation MainMenuController

@synthesize displayLink = _displayLink;
@synthesize mainMenuView = _mainMenuView;

- (void)dealloc 
{
    self.displayLink = nil;
    self.mainMenuView = nil;
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
                                                                                     action:@selector(toggleMinimized)] autorelease];
    [self.view addGestureRecognizer:tapRecognizer];
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
#pragma mark MainMenuViewDelegate methods

- (void)mainMenu:(MainMenuView *)menu didSelectButtonWithTag:(NSInteger)tag
{
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
