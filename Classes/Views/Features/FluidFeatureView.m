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

@property (nonatomic, retain) UIImageView *photoView;
@property (nonatomic, retain) BoxView *textView;

@end


@implementation FluidFeatureView

@synthesize photoView = _photoView;
@synthesize textView = _textView;

- (id)initWithFrame:(CGRect)frame 
{
    if ((self = [super initWithFrame:frame])) 
    {
        UIImage *image = [UIImage imageNamed:@"agnes_london_53.jpg"];
        self.photoView = [[[UIImageView alloc] initWithImage:image] autorelease];
        self.photoView.frame = frame;
        self.photoView.contentMode = UIViewContentModeCenter;
        [self addSubview:self.photoView];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"loremipsum" ofType:@"txt"];
        NSString *text = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        
        self.textView = [[[BoxView alloc] initWithFrame:CGRectMake(384.0, 100.0, 328.0, 700.0)] autorelease];
        self.textView.text = text;
        [self addSubview:self.textView];
    }
    return self;
}

- (void)dealloc 
{
    self.photoView = nil;
    self.textView = nil;
    [super dealloc];
}

@end
