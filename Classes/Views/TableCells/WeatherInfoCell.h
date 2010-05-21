//
//  WeatherInfoCell.h
//  Digital 2.0
//
//  Created by Adrian on 5/21/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherInfoCell : UITableViewCell 
{
@private
    UILabel *_dateLabel;
    UILabel *_descriptionLabel;
    UILabel *_windLabel;
    UILabel *_temperatureLabel;
    UIImageView *_iconView;
    UIView *_containerView;
}

@property (nonatomic, retain) IBOutlet UILabel *dateLabel;
@property (nonatomic, retain) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, retain) IBOutlet UILabel *windLabel;
@property (nonatomic, retain) IBOutlet UILabel *temperatureLabel;
@property (nonatomic, retain) IBOutlet UIImageView *iconView;
@property (nonatomic, retain) IBOutlet UIView *containerView;

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier;

@end
