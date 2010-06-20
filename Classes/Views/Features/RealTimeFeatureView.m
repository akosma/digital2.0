//
//  RealTimeFeatureView.m
//  Digital 2.0
//
//  Created by Adrian on 5/21/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import "RealTimeFeatureView.h"
#import "WeatherInfoItem.h"
#import "WeatherInfoManager.h"
#import "WeatherInfoCell.h"
#import "BoxView.h"
#import "StockInfoManager.h"

@interface RealTimeFeatureView ()

@property (nonatomic, retain) UITableView *weatherTableView;
@property (nonatomic, retain) UITableView *stockTableView;
@property (nonatomic, retain) NSArray *weatherItems;
@property (nonatomic, retain) NSArray *stockItems;
@property (nonatomic, retain) BoxView *boxView;

- (UIImage *)iconForWeatherCode:(NSInteger)code;
- (UIImage *)iconForStock:(NSString *)stock;

@end


@implementation RealTimeFeatureView

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
        [[NSBundle mainBundle] loadNibNamed:@"RealTimeFeatureView" 
                                      owner:self 
                                    options:nil];
        
        self.weatherTableView = [[[UITableView alloc] initWithFrame:self.weatherInfoPlaceholder.frame
                                                              style:UITableViewStylePlain] autorelease];
        self.weatherTableView.separatorColor = [UIColor whiteColor];
        self.weatherTableView.rowHeight = 100.0;
        self.weatherTableView.dataSource = self;
        self.weatherTableView.delegate = self;
        
        WeatherInfoManager *weatherInfo = [WeatherInfoManager sharedWeatherInfoManager];
        weatherInfo.delegate = self;
        [weatherInfo retrieveWeatherInformation];
        
        self.stockTableView = [[[UITableView alloc] initWithFrame:self.stockInfoPlaceholder.frame
                                                              style:UITableViewStylePlain] autorelease];
        self.stockTableView.separatorColor = [UIColor whiteColor];
        self.stockTableView.rowHeight = 100.0;
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
        [self addSubview:self.boxView];
        [self addSubview:self.weatherTableView];
        [self addSubview:self.stockTableView];
    }
    return self;
}

- (void)dealloc 
{
    [WeatherInfoManager sharedWeatherInfoManager].delegate = nil;
    self.weatherItems = nil;
    self.stockItems = nil;
    self.weatherTableView.delegate = nil;
    self.weatherTableView.dataSource = nil;
    self.weatherTableView = nil;
    self.stockTableView.delegate = nil;
    self.stockTableView.dataSource = nil;
    self.stockTableView = nil;
    self.mainView = nil;

    self.titleLabel = nil;
    self.descriptionPlaceholder = nil;
    self.weatherInfoPlaceholder = nil;
    self.stockInfoPlaceholder = nil;
    self.stockTitleLabel = nil;
    self.meteoTitleLabel = nil;
    
    self.boxView = nil;
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
    
    WeatherInfoItem *item = [self.weatherItems objectAtIndex:indexPath.row];
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
    
    CGRect titleLabelFrame = CGRectMake(20.0, 20.0, 130.0, 21.0);
    CGRect webLabelFrame = CGRectMake(20.0, 58.0, 253.0, 72.0);
    CGRect webFontViewFrame = CGRectMake(20.0, 138.0, 300.0, 300.0);
    CGRect iPhoneLabelFrame = CGRectMake(352.0, 58.0, 253.0, 72.0);
    CGRect iPhoneFontViewFrame = CGRectMake(352.0, 138.0, 300.0, 300.0);
    CGRect iPadLabelFrame = CGRectMake(684.0, 58.0, 253.0, 72.0);
    CGRect iPadFontViewFrame = CGRectMake(684.0, 138.0, 300.0, 300.0);
    CGRect moreLabelFrame = CGRectMake(20.0, 455.0, 541.0, 66.0);
    CGRect customFontViewFrame = CGRectMake(563.0, 455.0, 421.0, 177.0);
    
    if (UIInterfaceOrientationIsPortrait(newOrientation))
    {
        titleLabelFrame = CGRectMake(57.0, 20.0, 130.0, 21.0);
        webLabelFrame = CGRectMake(57.0, 58.0, 253.0, 72.0);
        webFontViewFrame = CGRectMake(57.0, 138.0, 300.0, 300.0);
        iPhoneLabelFrame = CGRectMake(411.0, 58.0, 253.0, 72.0);
        iPhoneFontViewFrame = CGRectMake(411.0, 138.0, 300.0, 300.0);
        iPadLabelFrame = CGRectMake(57.0, 467.0, 253.0, 72.0);
        iPadFontViewFrame = CGRectMake(57.0, 547.0, 300.0, 300.0);
        moreLabelFrame = CGRectMake(416.0, 528.0, 295.0, 134.0);
        customFontViewFrame = CGRectMake(416.0, 670.0, 295.0, 177.0);
    }
    
//    self.titleLabel.frame = titleLabelFrame;
//    self.webLabel.frame = webLabelFrame;
//    self.webFontView.frame = webFontViewFrame;
//    self.iPhoneLabel.frame = iPhoneLabelFrame;
//    self.iPhoneFontView.frame = iPhoneFontViewFrame;
//    self.iPadLabel.frame = iPadLabelFrame;
//    self.iPadFontView.frame = iPadFontViewFrame;
//    self.moreLabel.frame = moreLabelFrame;
//    
//    self.customView.frame = customFontViewFrame;
//    [self.customView setNeedsDisplay];
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
    if (abs(value) < 0.001)
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
