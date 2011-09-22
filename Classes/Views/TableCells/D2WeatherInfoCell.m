//
//  D2WeatherInfoCell.m
//  Digital 2.0
//
//  Created by Adrian on 5/21/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import "D2WeatherInfoCell.h"

@implementation D2WeatherInfoCell

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
        [[NSBundle mainBundle] loadNibNamed:@"D2WeatherInfoCell" 
                                      owner:self 
                                    options:nil];
        
        [self.contentView addSubview:self.containerView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)dealloc 
{
    [_dateLabel release];
    [_descriptionLabel release];
    [_windLabel release];
    [_temperatureLabel release];
    [_iconView release];
    [_containerView release];
    [super dealloc];
}

@end
