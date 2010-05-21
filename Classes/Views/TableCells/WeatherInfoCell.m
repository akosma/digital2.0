//
//  WeatherInfoCell.m
//  Digital 2.0
//
//  Created by Adrian on 5/21/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import "WeatherInfoCell.h"

@implementation WeatherInfoCell

@synthesize dateLabel = _dateLabel;
@synthesize descriptionLabel = _descriptionLabel;
@synthesize windLabel = _windLabel;
@synthesize temperatureLabel = _temperatureLabel;
@synthesize iconView = _iconView;
@synthesize containerView = _containerView;

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier 
{
    if ((self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier])) 
    {
        [[NSBundle mainBundle] loadNibNamed:@"WeatherInfoCell" 
                                      owner:self 
                                    options:nil];
        
        [self.contentView addSubview:self.containerView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.dateLabel.transform = CGAffineTransformMakeRotation(3.0 * M_PI / 2.0);
    }
    return self;
}

- (void)dealloc 
{
    self.dateLabel = nil;
    self.descriptionLabel = nil;
    self.windLabel = nil;
    self.temperatureLabel = nil;
    self.iconView = nil;
    self.containerView = nil;
    [super dealloc];
}

@end
