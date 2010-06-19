//
//  FontFeatureView.m
//  Digital 2.0
//
//  Created by Adrian on 6/19/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import "FontFeatureView.h"
#import "FontView.h"

@interface FontFeatureView ()

@property (nonatomic, retain) FontView *webFontView;
@property (nonatomic, retain) FontView *iPhoneFontView;
@property (nonatomic, retain) FontView *iPadFontView;

@end


@implementation FontFeatureView

@synthesize webFontView = _webFontView;
@synthesize iPhoneFontView = _iPhoneFontView;
@synthesize iPadFontView = _iPadFontView;

@synthesize mainView = _mainView;
@synthesize titleLabel = _titleLabel;
@synthesize webLabel = _webLabel;
@synthesize iPhoneLabel = _iPhoneLabel;
@synthesize iPadLabel = _iPadLabel;
@synthesize moreLabel = _moreLabel;
@synthesize customFontView = _customFontView;
@synthesize webPlaceholder = _webPlaceholder;
@synthesize iPhonePlaceholder = _iPhonePlaceholder;
@synthesize iPadPlaceholder = _iPadPlaceholder;

- (id)initWithFrame:(CGRect)frame 
{
    if ((self = [super initWithFrame:frame])) 
    {
        [[NSBundle mainBundle] loadNibNamed:@"FontFeatureView"
                                      owner:self 
                                    options:nil];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"WebFonts" ofType:@"plist"];
        self.webFontView = [[[FontView alloc] initWithFrame:self.webPlaceholder.frame] autorelease];
        self.webFontView.data = [NSDictionary dictionaryWithContentsOfFile:path];
        
        path = [[NSBundle mainBundle] pathForResource:@"iPhoneFonts" ofType:@"plist"];
        self.iPhoneFontView = [[[FontView alloc] initWithFrame:self.iPhonePlaceholder.frame] autorelease];
        self.iPhoneFontView.data = [NSDictionary dictionaryWithContentsOfFile:path];
        
        path = [[NSBundle mainBundle] pathForResource:@"iPadFonts" ofType:@"plist"];
        self.iPadFontView = [[[FontView alloc] initWithFrame:self.iPadPlaceholder.frame] autorelease];
        self.iPadFontView.data = [NSDictionary dictionaryWithContentsOfFile:path];
        
        self.webPlaceholder.backgroundColor = [UIColor clearColor];
        self.iPhonePlaceholder.backgroundColor = [UIColor clearColor];
        self.iPadPlaceholder.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.mainView];
        [self addSubview:self.webFontView];
        [self addSubview:self.iPadFontView];
        [self addSubview:self.iPhoneFontView];
    }
    return self;
}

- (void)dealloc 
{
    self.webFontView = nil;
    self.iPhoneFontView = nil;
    self.iPadFontView = nil;

    self.mainView = nil;
    self.titleLabel = nil;
    self.webLabel = nil;
    self.iPhoneLabel = nil;
    self.iPadLabel = nil;
    self.moreLabel = nil;
    self.customFontView = nil;
    self.webPlaceholder = nil;
    self.iPhonePlaceholder = nil;
    self.iPadPlaceholder = nil;

    [super dealloc];
}

#pragma mark -
#pragma mark Overridden methods

- (void)setOrientation:(UIInterfaceOrientation)newOrientation
{
    [super setOrientation:newOrientation];

    CGRect titleLabelFrame = CGRectMake(20.0, 20.0, 130.0, 21.0);
    CGRect webLabelFrame = CGRectMake(20.0, 58.0, 253.0, 72.0);
    CGRect webFontViewFrame = CGRectMake(20.0, 138.0, 300.0, 300.0);
    CGRect iPhoneLabelFrame = CGRectMake(352.0, 58.0, 253.0, 72.0);
    CGRect iPhoneFontViewFrame = CGRectMake(352.0, 138.0, 300.0, 300.0);
    CGRect iPadLabelFrame = CGRectMake(684.0, 58.0, 253.0, 72.0);
    CGRect iPadFontViewFrame = CGRectMake(684.0, 138.0, 300.0, 300.0);
    CGRect moreLabelFrame = CGRectMake(20.0, 455.0, 541.0, 126.0);
    CGRect customFontViewFrame = CGRectMake(563.0, 455.0, 421.0, 177.0);
    
    if (UIInterfaceOrientationIsPortrait(newOrientation))
    {
        titleLabelFrame = CGRectMake(57.0, 20.0, 130.0, 21.0);
        webLabelFrame = CGRectMake(57.0, 58.0, 253.0, 72.0);
        webFontViewFrame = CGRectMake(57.0, 138.0, 300.0, 300.0);
        iPhoneLabelFrame = CGRectMake(411.0, 58.0, 253.0, 72.0);
        iPhoneFontViewFrame = CGRectMake(411.0, 138.0, 300.0, 300.0);
        iPadLabelFrame = CGRectMake(57.0, 467.0, 253.0, 72.0);
        iPadFontViewFrame = CGRectMake(57.0, 547.0, 300.0, 300.0);
        moreLabelFrame = CGRectMake(416.0, 528.0, 295.0, 134.0);
        customFontViewFrame = CGRectMake(416.0, 670.0, 295.0, 177.0);
    }
    
    self.titleLabel.frame = titleLabelFrame;
    self.webLabel.frame = webLabelFrame;
    self.webFontView.frame = webFontViewFrame;
    self.iPhoneLabel.frame = iPhoneLabelFrame;
    self.iPhoneFontView.frame = iPhoneFontViewFrame;
    self.iPadLabel.frame = iPadLabelFrame;
    self.iPadFontView.frame = iPadFontViewFrame;
    self.moreLabel.frame = moreLabelFrame;
    self.customFontView.frame = customFontViewFrame;
}

@end
