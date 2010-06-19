//
//  FluidFeatureView.m
//  Digital 2.0
//
//  Created by Adrian on 5/20/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import "FluidFeatureView.h"
#import "BoxView.h"

@interface FluidFeatureView ()

@property (nonatomic, retain) UIImageView *photoView1;
@property (nonatomic, retain) UIImageView *photoView2;
@property (nonatomic, retain) BoxView *textView;
@property (nonatomic) BOOL firstImage;

@end


@implementation FluidFeatureView

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
        
        self.textView = [[[BoxView alloc] initWithFrame:CGRectMake(384.0, 400.0, 328.0, 440.0)] autorelease];
        self.textView.text = text;
        self.textView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
        [self addSubview:self.textView];
        
        [self performSelector:@selector(changeImage) 
                   withObject:nil
                   afterDelay:5.0];
    }
    return self;
}

- (void)dealloc 
{
    self.photoView1 = nil;
    self.photoView2 = nil;
    self.textView = nil;
    [super dealloc];
}

- (void)changeImage
{
    self.firstImage = !self.firstImage;
    
    [UIView beginAnimations:nil context:NULL];
    self.photoView2.alpha = (self.firstImage) ? 1.0 : 0.0;
    [UIView commitAnimations];

    [self performSelector:@selector(changeImage) 
               withObject:nil
               afterDelay:5.0];
}

@end
