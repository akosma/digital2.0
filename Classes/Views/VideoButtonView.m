//
//  VideoButtonView.m
//  Digital 2.0
//
//  Created by Adrian on 5/11/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import "VideoButtonView.h"

@interface VideoButtonView ()

@property (nonatomic, retain) UIImageView *movieAnimation;

@end


@implementation VideoButtonView

@synthesize movieAnimation = _movieAnimation;

- (void)subclassSetup
{
    self.movieAnimation = [[[UIImageView alloc] initWithFrame:self.bounds] autorelease];
    self.movieAnimation.contentMode = UIViewContentModeCenter;
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:24];
    for (NSInteger index = 0; index <= 23; ++index)
    {
        [images addObject:[UIImage imageNamed:[NSString stringWithFormat:@"button_21_%d.png", index]]];
    }
    self.movieAnimation.animationImages = images;
    [self.movieAnimation startAnimating];
    [self addSubview:self.movieAnimation];
}

- (void)dealloc 
{
    self.movieAnimation = nil;
    [super dealloc];
}


@end
