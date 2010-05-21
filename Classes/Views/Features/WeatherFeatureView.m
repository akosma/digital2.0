//
//  WeatherFeatureView.m
//  Digital 2.0
//
//  Created by Adrian on 5/21/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import "WeatherFeatureView.h"
#import "WeatherInfoItem.h"
#import "WeatherInfoManager.h"
#import "WeatherInfoCell.h"

@interface WeatherFeatureView ()

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSArray *weatherItems;

- (UIImage *)iconForWeatherCode:(NSInteger)code;

@end


@implementation WeatherFeatureView

@synthesize tableView = _tableView;
@synthesize weatherItems = _weatherItems;

- (id)initWithFrame:(CGRect)frame 
{
    if ((self = [super initWithFrame:frame])) 
    {
        self.tableView = [[[UITableView alloc] initWithFrame:self.frame style:UITableViewStylePlain] autorelease];
        self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | 
        UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | 
        UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
        self.tableView.separatorColor = [UIColor whiteColor];
        self.tableView.rowHeight = 164.0;
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        [self addSubview:self.tableView];
        
        WeatherInfoManager *weatherInfo = [WeatherInfoManager sharedWeatherInfoManager];
        weatherInfo.delegate = self;
        [weatherInfo retrieveWeatherInformation];
    }
    return self;
}

- (void)dealloc 
{
    self.weatherItems = nil;
    self.tableView = nil;
    [super dealloc];
}

#pragma mark -
#pragma mark WeatherInfoManagerDelegate methods

- (void)weatherInfoManager:(WeatherInfoManager *)manager didRetrieveWeatherInfo:(NSArray *)weatherItems
{
    self.weatherItems = weatherItems;
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark UITableView delegate and datasource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.weatherItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    static NSString *CellIdentifier = @"SpecialitiesListCell";
    
    WeatherInfoCell *cell = (WeatherInfoCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) 
    {
        cell = [[[WeatherInfoCell alloc] initWithReuseIdentifier:CellIdentifier] autorelease];
    }
    
    WeatherInfoItem *item = [self.weatherItems objectAtIndex:indexPath.row];
    cell.descriptionLabel.text = item.weatherDescription;
    cell.windLabel.text = [NSString stringWithFormat:@"%d kph %@", item.windSpeedKph, item.windDirection];
    cell.temperatureLabel.text = [NSString stringWithFormat:@"%d˚-%d˚", item.minTempC, item.maxTempC];
    cell.iconView.image = [self iconForWeatherCode:item.weatherCode];

    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:@"cccc d"];
    NSLog(@"date: %@", item.date);
    cell.dateLabel.text = [formatter stringFromDate:item.date];
    
    return cell;
}

#pragma mark -
#pragma mark Private methods

- (UIImage *)iconForWeatherCode:(NSInteger)code
{
    UIImage *image = [UIImage imageNamed:@"weather_sunny.png"];
    switch (code) 
    {
        case 395:
        case 392:
        case 377:
        case 374:
        case 371:
        case 368:
        case 365:
        case 362:
        case 350:
        case 338:
        case 335:
        case 332:
        case 329:
        case 326:
        case 323:
        case 320:
        case 317:
        case 230:
        case 227:
            image = [UIImage imageNamed:@"weather_snowy.png"];
            break;

        case 389:
        case 386:
        case 359:
        case 356:
        case 353:
        case 314:
        case 311:
        case 308:
        case 305:
        case 302:
        case 299:
        case 296:
        case 293:
        case 263:
        case 200:
        case 176:
            image = [UIImage imageNamed:@"weather_rainy.png"];
            break;
            
        case 143:
        case 122:
        case 119:
            image = [UIImage imageNamed:@"weather_cloudy.png"];
            break;
            
        case 116:
            image = [UIImage imageNamed:@"weather_partially_sunny.png"];
            break;

        default:
            break;
    }
    return image;
}

@end
