//
//  D2MainMenuController.h
//  Digital 2.0
//
//  Created by Adrian on 5/8/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <MessageUI/MessageUI.h>
#import "D2MainMenuViewDelegate.h"

@class D2MainMenuView;

@interface D2MainMenuController : UIViewController <D2MainMenuViewDelegate, 
                                                    MFMailComposeViewControllerDelegate>

@property (nonatomic, retain) IBOutlet D2MainMenuView *mainMenuView;
@property (nonatomic, retain) IBOutlet UIButton *akosmaInfoButton;
@property (nonatomic, retain) IBOutlet UIButton *moserInfoButton;
@property (nonatomic, retain) IBOutlet UIButton *vpsInfoButton;
@property (nonatomic, retain) IBOutlet UIView *featureReferenceView;

- (IBAction)showInfo:(id)sender;
- (IBAction)backToHome:(id)sender;

@end
