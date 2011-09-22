//
//  D2BoxView.m
//  Digital 2.0
//
//  Created by Adrian on 6/19/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import "D2BoxView.h"
#import <QuartzCore/QuartzCore.h>

@interface D2BoxView ()

@property (nonatomic, retain) UILabel *label;
@property (nonatomic, retain) UIScrollView *scrollView;

@end



@implementation D2BoxView

@synthesize label = _label;
@synthesize scrollView = _scrollView;
@dynamic font;
@dynamic text;
@dynamic scrollEnabled;

- (id)initWithFrame:(CGRect)frame 
{
    if ((self = [super initWithFrame:frame])) 
    {
        CGRect rect = CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height);
        self.scrollView = [[[UIScrollView alloc] initWithFrame:rect] autorelease];
        self.scrollView.backgroundColor = [UIColor clearColor];
        self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;

        UIFont *font = [UIFont systemFontOfSize:17.0];
        
        self.label = [[[UILabel alloc] initWithFrame:rect] autorelease];
        self.label.numberOfLines = 0;
        self.label.backgroundColor = [UIColor clearColor];
        self.label.font = font;
        
        self.layer.cornerRadius = 10.0;
        self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.75];
        self.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;

        [self updateLayout];

        [self.scrollView addSubview:self.label];
        [self addSubview:self.scrollView];
    }
    return self;
}

- (void)dealloc 
{
    [_label release];
    [_scrollView release];
    [super dealloc];
}

#pragma mark -
#pragma mark Dynamic property

- (NSString *)text
{
    return self.label.text;
}

- (void)setText:(NSString *)newText
{
    self.label.text = newText;
    [self updateLayout];
}

- (UIFont *)font
{
    return self.label.font;
}

- (void)setFont:(UIFont *)newFont
{
    self.label.font = newFont;
    [self updateLayout];
}

- (BOOL)scrollEnabled
{
    return self.scrollView.scrollEnabled;
}

- (void)setScrollEnabled:(BOOL)newValue
{
    self.scrollView.scrollEnabled = newValue;
}

#pragma mark -
#pragma mark Private methods

- (void)updateLayout
{
    CGRect rect = CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height);
    self.scrollView.frame = rect;
    CGFloat width = rect.size.width - 40.0;
    CGSize size = [self.label.text sizeWithFont:self.label.font
                              constrainedToSize:CGSizeMake(width, 2900.0)];
    self.label.frame = CGRectMake(20.0, 20.0, width, size.height);
    self.scrollView.contentSize = CGSizeMake(size.width, size.height + 40.0);
}

@end
