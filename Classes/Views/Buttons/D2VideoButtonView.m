//
//  D2VideoButtonView.m
//  Digital 2.0
//
//  Created by Adrian on 5/11/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import "D2VideoButtonView.h"

@interface D2VideoButtonView ()

@property (nonatomic, retain) UIImageView *movieAnimation;
@property (nonatomic, retain) NSMutableArray *images;
@property (nonatomic, retain) UIImageView *staticImage;

@end


@implementation D2VideoButtonView

@synthesize movieAnimation = _movieAnimation;
@synthesize images = _images;
@synthesize staticImage = _staticImage;

- (void)subclassSetup
{
    self.images = [NSMutableArray arrayWithCapacity:24];
    for (NSInteger index = 0; index <= 23; ++index)
    {
        [self.images addObject:[UIImage imageNamed:[NSString stringWithFormat:@"button_21_%d.png", index]]];
    }
    
    self.movieAnimation = [[[UIImageView alloc] initWithFrame:self.bounds] autorelease];
    self.movieAnimation.contentMode = UIViewContentModeCenter;
    self.movieAnimation.animationImages = self.images;
    self.movieAnimation.animationDuration = 1.0;
    self.movieAnimation.animationRepeatCount = 1;
    self.movieAnimation.hidden = YES;

    self.staticImage = [[[UIImageView alloc] initWithFrame:self.bounds] autorelease];
    self.staticImage.contentMode = UIViewContentModeCenter;
    self.staticImage.image = [UIImage imageNamed:@"button_21_23.png"];
    
    [self addSubview:self.movieAnimation];
    [self addSubview:self.staticImage];
    
    [self initializeTimer];
}

- (void)dealloc 
{
    [_staticImage release];
    [_movieAnimation release];
    [_images release];
    [super dealloc];
}

- (void)animate
{
    NSDate *today = [NSDate date];
    NSCalendar *gregorian = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    NSDateComponents *components = [gregorian components:NSSecondCalendarUnit fromDate:today];
    NSInteger second = [components second];
    
    if (second == self.nextSecondAnimation)
    {
        [self.movieAnimation startAnimating];
        self.movieAnimation.hidden = NO;
        self.staticImage.hidden = YES;
    }
    else
    {
        [self.movieAnimation stopAnimating];
        self.staticImage.hidden = NO;
        self.movieAnimation.hidden = YES;
    }
}

@end
