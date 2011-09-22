//
//  D2FontFeatureView.h
//  Digital 2.0
//
//  Created by Adrian on 6/19/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import "D2FeatureView.h"


@interface D2FontFeatureView : D2FeatureView

@property (nonatomic, retain) IBOutlet UIView *mainView;
@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UILabel *webLabel;
@property (nonatomic, retain) IBOutlet UILabel *iPhoneLabel;
@property (nonatomic, retain) IBOutlet UILabel *iPadLabel;
@property (nonatomic, retain) IBOutlet UILabel *moreLabel;
@property (nonatomic, retain) IBOutlet UILabel *customFontLabelTitle;
@property (nonatomic, retain) IBOutlet UILabel *customFontLabelName;
@property (nonatomic, retain) IBOutlet UIView *webPlaceholder;
@property (nonatomic, retain) IBOutlet UIView *iPhonePlaceholder;
@property (nonatomic, retain) IBOutlet UIView *iPadPlaceholder;

@end
