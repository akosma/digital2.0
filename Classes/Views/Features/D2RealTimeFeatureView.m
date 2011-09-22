//
//  D2RealTimeFeatureView.m
//  Digital 2.0
//
//  Created by Adrian on 5/21/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import "D2RealTimeFeatureView.h"
#import "D2WeatherInfoItem.h"
#import "WeatherInfoManager.h"
#import "WeatherInfoCell.h"
#import "BoxView.h"
#import "StockInfoManager.h"

@interface D2RealTimeFeatureView ()

@property (nonatomic, retain) UITableView *weatherTableView;
@property (nonatomic, retain) UITableView *stockTableView;
@property (nonatomic, retain) NSArray *weatherItems;
@property (nonatomic, retain) NSArray *stockItems;
@property (nonatomic, retain) BoxView *boxView;

- (UIImage *)iconForWeatherCode:(NSInteger)code;
- (UIImage *)iconForStock:(NSString *)stock;

@end


@implementation D2RealTimeFeatureView

@synthesize weatherTableView = _weatherTableView;
@synthesize weatherItems = _weatherItems;
@synthesize stockItems = _stockItems;
@synthesize stockTableView = _stockTableView;

@synthesize titleLabel = _titleLabel;
@synthesize descriptionPlaceholder = _descriptionPlaceholder;
@synthesize weatherInfoPlaceholder = _weatherInfoPlaceholder;
@synthesize stockInfoPlaceholder = _stockInfoPlaceholder;
@synthesize stockTitleLabel = _stockTitleLabel;
@synthesize meteoTitleLabel = _meteoTitleLabel;
@synthesize mainView = _mainView;
@synthesize boxView = _boxView;

- (id)initWithFrame:(CGRect)frame 
{
    if ((self = [super initWithFrame:frame])) 
    {
        self.requiresNetwork = YES;

        [[NSBundle mainBundle] loadNibNamed:@"D2RealTimeFeatureView" 
                                      owner:self 
                                    options:nil];
        
        self.weatherTableView = [[[UITableView alloc] initWithFrame:self.weatherInfoPlaceholder.frame
                                                              style:UITableViewStylePlain] autorelease];
        self.weatherTableView.separatorColor = [UIColor whiteColor];
        self.weatherTableView.rowHeight = 81.0;
        self.weatherTableView.dataSource = self;
        self.weatherTableView.delegate = self;
        
        WeatherInfoManager *weatherInfo = [WeatherInfoManager sharedWeatherInfoManager];
        weatherInfo.delegate = self;
        [weatherInfo retrieveWeatherInformation];
        
        self.stockTableView = [[[UITableView alloc] initWithFrame:self.stockInfoPlaceholder.frame
                                                              style:UITableViewStylePlain] autorelease];
        self.stockTableView.separatorColor = [UIColor whiteColor];
        self.stockTableView.rowHeight = 81.0;
        self.stockTableView.dataSource = self;
        self.stockTableView.delegate = self;

        StockInfoManager *stockInfo = [StockInfoManager sharedStockInfoManager];
        stockInfo.delegate = self;
        [stockInfo retrieveStockInformation];

        NSString *path = [[NSBundle mainBundle] pathForResource:@"realtime" ofType:@"txt"];
        NSString *text = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];

        self.descriptionPlaceholder.backgroundColor = [UIColor clearColor];
        self.weatherInfoPlaceholder.backgroundColor = [UIColor clearColor];
        self.stockInfoPlaceholder.backgroundColor = [UIColor clearColor];
        self.boxView = [[[BoxView alloc] initWithFrame:self.descriptionPlaceholder.frame] autorelease];
        self.boxView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.25];
        self.boxView.text = text;
        
        [self addSubview:self.mainView];
        [self addSubview:self.weatherTableView];
        [self addSubview:self.stockTableView];
        [self addSubview:self.boxView];
    }
    return self;
}

- (void)dealloc 
{
    [WeatherInfoManager sharedWeatherInfoManager].delegate = nil;
    [_weatherItems release];
    [_stockItems release];
    _weatherTableView.delegate = nil;
    _weatherTableView.dataSource = nil;
    [_weatherTableView release];
    _stockTableView.delegate = nil;
    _stockTableView.dataSource = nil;
    [_stockTableView release];
    [_mainView release];

    [_titleLabel release];
    [_descriptionPlaceholder release];
    [_weatherInfoPlaceholder release];
    [_stockInfoPlaceholder release];
    [_stockTitleLabel release];
    [_meteoTitleLabel release];
    
    [_boxView release];
    [super dealloc];
}

#pragma mark -
#pragma mark WeatherInfoManagerDelegate methods

- (void)weatherInfoManager:(WeatherInfoManager *)manager didRetrieveWeatherInfo:(NSArray *)weatherItems
{
    self.weatherItems = weatherItems;
    [self.weatherTableView reloadData];
}

#pragma mark -
#pragma mark StockInfoManagerDelegate methods

- (void)stockInfoManager:(StockInfoManager *)manager didRetrieveStockInfo:(NSArray *)stockItems
{
    self.stockItems = stockItems;
    [self.stockTableView reloadData];
}

#pragma mark -
#pragma mark UITableView delegate and datasource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.stockTableView)
    {
        return [self.stockItems count];
    }
    return [self.weatherItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    if (tableView == self.stockTableView)
    {
        NSString *CellIdentifier = @"StockCell";
        
        WeatherInfoCell *cell = (WeatherInfoCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) 
        {
            cell = [[[WeatherInfoCell alloc] initWithReuseIdentifier:CellIdentifier] autorelease];
        }
        
        NSDictionary *item = [self.stockItems objectAtIndex:indexPath.row];
        cell.windLabel.text = [item objectForKey:@"el_cur"];
        cell.temperatureLabel.text = [NSString stringWithFormat:@"%1.2f", [[item objectForKey:@"ec"] floatValue]];
        cell.iconView.image = [self iconForStock:[item objectForKey:@"ec"]];
        cell.dateLabel.text = [item objectForKey:@"t"];
        cell.descriptionLabel.text = @"";
        
        return cell;
    }
    
    NSString *CellIdentifier = @"WeatherCell";
    
    WeatherInfoCell *cell = (WeatherInfoCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) 
    {
        cell = [[[WeatherInfoCell alloc] initWithReuseIdentifier:CellIdentifier] autorelease];
    }
    
    D2WeatherInfoItem *item = [self.weatherItems objectAtIndex:indexPath.row];
    cell.descriptionLabel.text = item.weatherDescription;
    cell.windLabel.text = [NSString stringWithFormat:@"%d kph %@", item.windSpeedKph, item.windDirection];
    cell.temperatureLabel.text = [NSString stringWithFormat:@"%d˚-%d˚", item.minTempC, item.maxTempC];
    cell.iconView.image = [self iconForWeatherCode:item.weatherCode];
    
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:@"cccc d"];
    cell.dateLabel.text = [formatter stringFromDate:item.date];
    
    return cell;
}

#pragma mark -
#pragma mark Overridden methods

- (void)setOrientation:(UIInterfaceOrientation)newOrientation
{
    [super setOrientation:newOrientation];
    
    CGRect titleLabelFrame = CGRectMake(164.0, 6.0, 178.0, 21.0);
    CGRect descriptionLabelFrame = CGRectMake(164.0, 35.0, 696.0, 229.0);
    CGRect stockTitleLabelFrame = CGRectMake(164.0, 272.0, 100.0, 21.0);
    CGRect weatherTableViewFrame = CGRectMake(530.0, 301.0, 330.0, 300.0);
    CGRect weatherTitleLabelFrame = CGRectMake(530.0, 272.0, 145.0, 21.0);
    CGRect stockTableViewFrame = CGRectMake(164.0, 301.0, 330.0, 300.0);
    
    if (UIInterfaceOrientationIsPortrait(newOrientation))
    {
        titleLabelFrame = CGRectMake(37.0, 73.0, 178.0, 21.0);
        descriptionLabelFrame = CGRectMake(37.0, 102.0, 330.0, 697.0);
        stockTitleLabelFrame = CGRectMake(403.0, 73.0, 100.0, 21.0);
        weatherTableViewFrame = CGRectMake(403.0, 469.0, 330.0, 300.0);
        weatherTitleLabelFrame = CGRectMake(403.0, 440.0, 145.0, 21.0);
        stockTableViewFrame = CGRectMake(403.0, 102.0, 330.0, 300.0);
    }
    
    self.titleLabel.frame = titleLabelFrame;
    self.descriptionPlaceholder.frame = descriptionLabelFrame;
    self.boxView.frame = descriptionLabelFrame;
    self.stockTitleLabel.frame = stockTitleLabelFrame;
    self.weatherInfoPlaceholder.frame = weatherTableViewFrame;
    self.weatherTableView.frame = weatherTableViewFrame;
    self.meteoTitleLabel.frame = weatherTitleLabelFrame;
    self.stockInfoPlaceholder.frame = stockTableViewFrame;
    self.stockTableView.frame = stockTableViewFrame;
    
    [self.boxView updateLayout];
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

- (UIImage *)iconForStock:(NSString *)stock
{
    float value = [stock floatValue];
    if (value == 0.0)
    {
        return [UIImage imageNamed:@"stock_same.png"];
    }
    if (value < 0.0)
    {
        return [UIImage imageNamed:@"stock_down.png"];
    }
    return [UIImage imageNamed:@"stock_up.png"];
}

@end
