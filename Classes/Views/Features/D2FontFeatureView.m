//
//  D2FontFeatureView.m
//  Digital 2.0
//
//  Created by Adrian on 6/19/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import "D2FontFeatureView.h"
#import "D2FontView.h"

@interface D2FontFeatureView ()

@property (nonatomic, retain) D2FontView *webFontView;
@property (nonatomic, retain) D2FontView *iPhoneFontView;
@property (nonatomic, retain) D2FontView *iPadFontView;

@end


@implementation D2FontFeatureView

@synthesize webFontView = _webFontView;
@synthesize iPhoneFontView = _iPhoneFontView;
@synthesize iPadFontView = _iPadFontView;
@synthesize customFontLabelTitle = _customFontLabelTitle;
@synthesize customFontLabelName = _customFontLabelName;
@synthesize mainView = _mainView;
@synthesize titleLabel = _titleLabel;
@synthesize webLabel = _webLabel;
@synthesize iPhoneLabel = _iPhoneLabel;
@synthesize iPadLabel = _iPadLabel;
@synthesize moreLabel = _moreLabel;
@synthesize webPlaceholder = _webPlaceholder;
@synthesize iPhonePlaceholder = _iPhonePlaceholder;
@synthesize iPadPlaceholder = _iPadPlaceholder;

- (id)initWithFrame:(CGRect)frame 
{
    if ((self = [super initWithFrame:frame])) 
    {
        [[NSBundle mainBundle] loadNibNamed:@"D2FontFeatureView"
                                      owner:self 
                                    options:nil];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"WebFonts" ofType:@"plist"];
        self.webFontView = [[[D2FontView alloc] initWithFrame:self.webPlaceholder.frame] autorelease];
        self.webFontView.data = [NSDictionary dictionaryWithContentsOfFile:path];
        
        path = [[NSBundle mainBundle] pathForResource:@"iPhoneFonts" ofType:@"plist"];
        self.iPhoneFontView = [[[D2FontView alloc] initWithFrame:self.iPhonePlaceholder.frame] autorelease];
        self.iPhoneFontView.data = [NSDictionary dictionaryWithContentsOfFile:path];
        
        path = [[NSBundle mainBundle] pathForResource:@"iPadFonts" ofType:@"plist"];
        self.iPadFontView = [[[D2FontView alloc] initWithFrame:self.iPadPlaceholder.frame] autorelease];
        self.iPadFontView.data = [NSDictionary dictionaryWithContentsOfFile:path];
        
        self.webPlaceholder.backgroundColor = [UIColor clearColor];
        self.iPhonePlaceholder.backgroundColor = [UIColor clearColor];
        self.iPadPlaceholder.backgroundColor = [UIColor clearColor];
        self.customFontLabelTitle.backgroundColor = [UIColor clearColor];
        self.customFontLabelName.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.mainView];
        [self addSubview:self.webFontView];
        [self addSubview:self.iPadFontView];
        [self addSubview:self.iPhoneFontView];
        
        self.customFontLabelTitle.text = @"Dare rich fonts!";
        self.customFontLabelTitle.font = [UIFont fontWithName:@"YanoneKaffeesatz-Bold" size:66.0];
        self.customFontLabelTitle.textColor = [UIColor grayColor];
        
        self.customFontLabelName.text = @"typeface: Yanone Kaffeesatz";
        self.customFontLabelName.font = [UIFont fontWithName:@"YanoneKaffeesatz-Regular" size:20.0];
        self.customFontLabelName.textColor = [UIColor grayColor];
    }
    return self;
}

- (void)dealloc 
{
    [_webFontView release];
    [_iPhoneFontView release];
    [_iPadFontView release];
    [_customFontLabelTitle release];
    [_customFontLabelName release];
    [_mainView release];
    [_titleLabel release];
    [_webLabel release];
    [_iPhoneLabel release];
    [_iPadLabel release];
    [_moreLabel release];
    [_webPlaceholder release];
    [_iPhonePlaceholder release];
    [_iPadPlaceholder release];

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
    CGRect moreLabelFrame = CGRectMake(20.0, 455.0, 541.0, 66.0);
    CGRect customFontLabelTitleFrame = CGRectMake(563.0, 455.0, 295.0, 75.0);
    CGRect customFontLabelNameFrame = CGRectMake(563.0, 518.0, 295.0, 31.0);
    
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
        customFontLabelTitleFrame = CGRectMake(416.0, 670.0, 295.0, 75.0);
        customFontLabelNameFrame = CGRectMake(416.0, 733.0, 295.0, 31.0);
    }
    
    self.titleLabel.frame = titleLabelFrame;
    self.webLabel.frame = webLabelFrame;
    self.webFontView.frame = webFontViewFrame;
    self.iPhoneLabel.frame = iPhoneLabelFrame;
    self.iPhoneFontView.frame = iPhoneFontViewFrame;
    self.iPadLabel.frame = iPadLabelFrame;
    self.iPadFontView.frame = iPadFontViewFrame;
    self.moreLabel.frame = moreLabelFrame;
    self.customFontLabelTitle.frame = customFontLabelTitleFrame;
    self.customFontLabelName.frame = customFontLabelNameFrame;
}

@end
