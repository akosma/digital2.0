//
//  BoxView.h
//  Digital 2.0
//
//  Created by Adrian on 6/19/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BoxView : UIView 
{
@private
    UILabel *_label;
    UIScrollView *_scrollView;
}

@property (nonatomic, copy) NSString *text;
@property (nonatomic, retain) UIFont *font;
@property (nonatomic) BOOL scrollEnabled;

- (void)updateLayout;

@end
