//
//  FontFeatureView.h
//  Digital 2.0
//
//  Created by Adrian on 6/19/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeatureView.h"

@class FontView;
@class CustomFontView;

@interface FontFeatureView : FeatureView
{
@private
    FontView *_webFontView;
    FontView *_iPhoneFontView;
    FontView *_iPadFontView;
    CustomFontView *_customView;
    
    UIView *_mainView;
    UILabel *_titleLabel;
    UILabel *_webLabel;
    UILabel *_iPhoneLabel;
    UILabel *_iPadLabel;
    UILabel *_moreLabel;
    UIView *_customFontView;
    
    UIView *_webPlaceholder;
    UIView *_iPhonePlaceholder;
    UIView *_iPadPlaceholder;
}

@property (nonatomic, retain) IBOutlet UIView *mainView;
@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UILabel *webLabel;
@property (nonatomic, retain) IBOutlet UILabel *iPhoneLabel;
@property (nonatomic, retain) IBOutlet UILabel *iPadLabel;
@property (nonatomic, retain) IBOutlet UILabel *moreLabel;
@property (nonatomic, retain) IBOutlet UIView *customFontView;
@property (nonatomic, retain) IBOutlet UIView *webPlaceholder;
@property (nonatomic, retain) IBOutlet UIView *iPhonePlaceholder;
@property (nonatomic, retain) IBOutlet UIView *iPadPlaceholder;

@end
