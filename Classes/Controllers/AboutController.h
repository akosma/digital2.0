//
//  AboutController.h
//  Digital 2.0
//
//  Created by Adrian on 6/21/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

typedef enum {
    AboutControllerItemNone = 0,
    AboutControllerItemAkosma = 1,
    AboutControllerItemMoser = 2,
    AboutControllerItemVPS = 3
} AboutControllerItem;

@interface AboutController : UIViewController <UIScrollViewDelegate>
{
@private
    AboutControllerItem _item;
    UIView *_moserView;
    UIView *_vpsView;
    UIView *_akosmaView;
    UIView *_vpsVideoView;
    UIScrollView *_moserSampleView;
    NSTimer *_timer;
    NSInteger _moserImageIndex;
    MPMoviePlayerController *_moviePlayer;
}

@property (nonatomic) AboutControllerItem item;
@property (nonatomic, retain) IBOutlet UIView *moserView;
@property (nonatomic, retain) IBOutlet UIView *vpsView;
@property (nonatomic, retain) IBOutlet UIView *akosmaView;
@property (nonatomic, retain) IBOutlet UIView *vpsVideoView;
@property (nonatomic, retain) IBOutlet UIScrollView *moserSampleView;

+ (AboutController *)controller;

- (IBAction)openWebsite:(id)sender;

@end
