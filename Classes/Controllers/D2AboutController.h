//
//  D2AboutController.h
//  Digital 2.0
//
//  Created by Adrian on 6/21/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

typedef enum {
    D2AboutControllerItemNone = 0,
    D2AboutControllerItemAkosma = 1,
    D2AboutControllerItemMoser = 2,
    D2AboutControllerItemVPS = 3
} D2AboutControllerItem;


@interface D2AboutController : UIViewController <UIScrollViewDelegate>

@property (nonatomic) D2AboutControllerItem item;
@property (nonatomic, retain) IBOutlet UIView *moserView;
@property (nonatomic, retain) IBOutlet UIView *vpsView;
@property (nonatomic, retain) IBOutlet UIView *akosmaView;
@property (nonatomic, retain) IBOutlet UIView *vpsVideoView;
@property (nonatomic, retain) IBOutlet UIScrollView *moserSampleView;

+ (D2AboutController *)controller;

- (IBAction)openWebsite:(id)sender;

@end
