//
//  FluidFeatureView.m
//  Digital 2.0
//
//  Created by Adrian on 5/20/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import "FluidFeatureView.h"
#import <QuartzCore/QuartzCore.h>

@interface FluidFeatureView ()

@property (nonatomic, retain) UIImageView *photoView;
@property (nonatomic, retain) UIView *textView;

@end


@implementation FluidFeatureView

@synthesize photoView = _photoView;
@synthesize textView = _textView;

- (id)initWithFrame:(CGRect)frame 
{
    if ((self = [super initWithFrame:frame])) 
    {
        self.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
        self.contentMode = UIViewContentModeScaleToFill;

        UIImage *image = [UIImage imageNamed:@"agnes_london_53.jpg"];
        self.photoView = [[[UIImageView alloc] initWithImage:image] autorelease];
        self.photoView.frame = frame;
        self.photoView.contentMode = UIViewContentModeCenter;
        [self addSubview:self.photoView];
        
        CGRect rect = CGRectMake(0.0, 0.0, 328.0, 777.0);
        UIScrollView *scrollView = [[[UIScrollView alloc] initWithFrame:rect] autorelease];
        scrollView.backgroundColor = [UIColor clearColor];
        scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"loremipsum" ofType:@"txt"];
        NSString *text = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        
        UIFont *font = [UIFont systemFontOfSize:17.0];
        
        CGSize size = [text sizeWithFont:font constrainedToSize:CGSizeMake(288.0, 2900.0)];
        
        UILabel *label = [[[UILabel alloc] initWithFrame:rect] autorelease];
        label.frame = CGRectMake(20.0, 20.0, 288.0, size.height);
        label.numberOfLines = 0;
        label.backgroundColor = [UIColor clearColor];
        label.text = text;
        label.font = font;

        self.textView = [[[UIView alloc] initWithFrame:CGRectMake(384.0, 117.0, 328.0, 777.0)] autorelease];
        self.textView.layer.cornerRadius = 10.0;
        self.textView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.75];
        self.textView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
        
        scrollView.contentSize = CGSizeMake(size.width, size.height + 40.0);
        [scrollView addSubview:label];
        [self.textView addSubview:scrollView];
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
