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

@interface WeatherFeatureView ()

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSArray *weatherItems;

@end


@implementation WeatherFeatureView

@synthesize tableView = _tableView;
@synthesize weatherItems = _weatherItems;

- (id)initWithFrame:(CGRect)frame 
{
    if ((self = [super initWithFrame:frame])) 
    {
        self.tableView = [[[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain] autorelease];
        self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | 
        UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | 
        UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
        self.tableView.separatorColor = [UIColor whiteColor];
        self.tableView.rowHeight = 180.0;
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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) 
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle 
                                       reuseIdentifier:CellIdentifier] autorelease];
    }
    
    WeatherInfoItem *item = [self.weatherItems objectAtIndex:indexPath.row];
    cell.textLabel.text = item.weatherDescription;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"code %d", item.weatherCode];
    return cell;
}

@end
