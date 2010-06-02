//
//  DemoAppDelegate.m
//  Digital 2.0
//
//  Created by Adrian on 5/8/10.
//  Copyright akosma software 2010. All rights reserved.
//

#import "DemoAppDelegate.h"
#import "MainMenuController.h"

@interface DemoAppDelegate ()

@property (nonatomic, retain) MPMoviePlayerController *moviePlayer;

@end


@implementation DemoAppDelegate

@synthesize moviePlayer = _moviePlayer;
@synthesize window = _window;
@synthesize mainMenuController = _mainMenuController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions 
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"tunnel" ofType:@"mp4"];
    NSURL *url = [NSURL fileURLWithPath:path];
    self.moviePlayer = [[[MPMoviePlayerController alloc] initWithContentURL:url] autorelease];
    self.moviePlayer.shouldAutoplay = YES;
    self.moviePlayer.controlStyle = MPMovieControlModeHidden;
    self.moviePlayer.scalingMode = MPMovieScalingModeAspectFit;
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self 
               selector:@selector(moviePlaybackFinished:) 
                   name:MPMoviePlayerPlaybackDidFinishNotification
                 object:self.moviePlayer];
    [center addObserver:self 
               selector:@selector(moviePlaybackFinished:) 
                   name:MPMoviePlayerDidExitFullscreenNotification
                 object:self.moviePlayer];
    [center addObserver:self 
               selector:@selector(moviePlaybackChanged:) 
                   name:MPMoviePlayerPlaybackStateDidChangeNotification
                 object:self.moviePlayer];
    [center addObserver:self 
               selector:@selector(movieReady:) 
                   name:MPMoviePlayerLoadStateDidChangeNotification
                 object:self.moviePlayer];
    
    self.moviePlayer.view.frame = [UIScreen mainScreen].bounds;
    self.moviePlayer.backgroundView.backgroundColor = [UIColor blackColor];
    self.moviePlayer.view.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | 
    UIViewAutoresizingFlexibleTopMargin | 
    UIViewAutoresizingFlexibleLeftMargin | 
    UIViewAutoresizingFlexibleBottomMargin;
    
    [self.window addSubview:self.moviePlayer.view];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)dealloc 
{
    self.moviePlayer = nil;
    self.window = nil;
    [super dealloc];
}

#pragma mark -
#pragma mark NSNotification handlers

- (void)moviePlaybackFinished:(NSNotification *)notification
{
    [self.window insertSubview:self.mainMenuController.view belowSubview:self.moviePlayer.view];
    [UIView beginAnimations:nil context:NULL];
    self.moviePlayer.view.alpha = 0.0;
    [UIView commitAnimations];
}

- (void)moviePlaybackChanged:(NSNotification *)notification
{
}

- (void)movieReady:(NSNotification *)notification
{
    if (self.moviePlayer.loadState == 3)
    {
    }
}

@end
