//
//  D2FontView.h
//  Digital 2.0
//
//  Created by Adrian on 6/19/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface D2FontView : UIView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) NSDictionary *data;
@property (nonatomic) CGFloat fontSize;

@end
