//
//  D2FluidFeatureView.m
//  Digital 2.0
//
//  Created by Adrian on 5/20/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import "D2FluidFeatureView.h"
#import "BoxView.h"

@interface D2FluidFeatureView ()

@property (nonatomic, retain) UIImageView *photoView1;
@property (nonatomic, retain) UIImageView *photoView2;
@property (nonatomic, retain) BoxView *textView;
@property (nonatomic) BOOL firstImage;

@end


@implementation D2FluidFeatureView

@synthesize photoView1 = _photoView1;
@synthesize photoView2 = _photoView2;
@synthesize textView = _textView;
@synthesize firstImage = _firstImage;

- (id)initWithFrame:(CGRect)frame 
{
    if ((self = [super initWithFrame:frame])) 
    {
        self.firstImage = YES;

        UIImage *image = [UIImage imageNamed:@"agnes_london_53.jpg"];
        self.photoView1 = [[[UIImageView alloc] initWithImage:image] autorelease];
        self.photoView1.frame = frame;
        self.photoView1.contentMode = UIViewContentModeCenter;
        [self addSubview:self.photoView1];

        image = [UIImage imageNamed:@"desert.jpg"];
        self.photoView2 = [[[UIImageView alloc] initWithImage:image] autorelease];
        self.photoView2.frame = frame;
        self.photoView2.contentMode = UIViewContentModeCenter;
        [self addSubview:self.photoView2];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"loremipsum" ofType:@"txt"];
        NSString *text = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        
        self.textView = [[[BoxView alloc] initWithFrame:CGRectMake(384.0, 200.0, 328.0, 640.0)] autorelease];
        self.textView.text = text;
        self.textView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        [self addSubview:self.textView];
        
        [self performSelector:@selector(changeImage) 
                   withObject:nil
                   afterDelay:5.0];
    }
    return self;
}

- (void)dealloc 
{
    [_photoView1 release];
    [_photoView2 release];
    [_textView release];
    [super dealloc];
}

- (void)changeImage
{
    self.firstImage = !self.firstImage;

    [UIView animateWithDuration:0.4 
                     animations:^{
                         self.photoView2.alpha = (self.firstImage) ? 1.0 : 0.0;
                     }];

    [self performSelector:@selector(changeImage) 
               withObject:nil
               afterDelay:5.0];
}

#pragma mark -
#pragma mark Overridden methods

- (void)setOrientation:(UIInterfaceOrientation)newOrientation
{
    [super setOrientation:newOrientation];
    
    CGRect frame = CGRectMake(630.0, 300.0, 328.0, 300.0);
    
    if (UIInterfaceOrientationIsPortrait(newOrientation))
    {
        frame = CGRectMake(384.0, 70.0, 328.0, 770.0);
    }
    
    self.textView.frame = frame;
}

@end
