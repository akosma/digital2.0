//
//  FontView.h
//  Digital 2.0
//
//  Created by Adrian on 6/19/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FontView : UIView <UITableViewDelegate, UITableViewDataSource>
{
@private
    UITableView *_tableView;
    NSDictionary *_data;
    NSArray *_keys;
    CGFloat _fontSize;
}

@property (nonatomic, retain) NSDictionary *data;
@property (nonatomic) CGFloat fontSize;

@end
