//
//  MainMenuController.h
//  Digital 2.0
//
//  Created by Adrian on 5/8/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <MessageUI/MessageUI.h>
#import "MainMenuViewDelegate.h"

@class MainMenuView;
@class SoundManager;
@class FeatureView;
@class AboutController;

@interface MainMenuController : UIViewController <MainMenuViewDelegate, 
                                                  MFMailComposeViewControllerDelegate>
{
@private
    MPMoviePlayerController *_moviePlayer;
    MainMenuView *_mainMenuView;
    
    UIButton *_akosmaInfoButton;
    UIButton *_moserInfoButton;
    UIButton *_vpsInfoButton;
    
    UIPopoverController *_popover;
    UIView *_featureReferenceView;
    
    SoundManager *_soundManager;
    FeatureView *_featureView;
    NSInteger _lastTag;
    AboutController *_aboutController;
    
    NSMutableDictionary *_viewCache;
    BOOL _externalScreenAvailable;
}

@property (nonatomic, retain) IBOutlet MainMenuView *mainMenuView;
@property (nonatomic, retain) IBOutlet UIButton *akosmaInfoButton;
@property (nonatomic, retain) IBOutlet UIButton *moserInfoButton;
@property (nonatomic, retain) IBOutlet UIButton *vpsInfoButton;
@property (nonatomic, retain) IBOutlet UIView *featureReferenceView;
@property (nonatomic, retain) AboutController *aboutController;

- (IBAction)showInfo:(id)sender;
- (IBAction)backToHome:(id)sender;

@end
