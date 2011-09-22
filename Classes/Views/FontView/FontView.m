//
//  FontView.m
//  Digital 2.0
//
//  Created by Adrian on 6/19/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import "FontView.h"
#import <QuartzCore/QuartzCore.h>

@interface FontView ()

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSArray *keys;

@end


@implementation FontView

@synthesize tableView = _tableView;
@synthesize keys = _keys;
@dynamic fontSize;
@dynamic data;

#pragma mark -
#pragma mark Init and dealloc

- (id)initWithFrame:(CGRect)frame 
{
    if ((self = [super initWithFrame:frame])) 
    {
        self.fontSize = 19.0;

        CGRect rect = CGRectMake(10.0, 10.0, self.frame.size.width - 10.0, self.frame.size.height - 10.0);
        self.tableView = [[[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain] autorelease];
        self.tableView.backgroundColor = [UIColor clearColor];
        self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        self.layer.cornerRadius = 10.0;
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.25];
        
        [self addSubview:self.tableView];
    }
    return self;
}

- (void)dealloc 
{
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
    self.tableView = nil;
    self.data = nil;
    self.keys = nil;
    [super dealloc];
}

#pragma mark -
#pragma mark UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FontCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) 
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                       reuseIdentifier:CellIdentifier] autorelease];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryView = UITableViewCellAccessoryNone;
    }
    
    NSString *fontName = [self.keys objectAtIndex:indexPath.row];
    UIFont *font = [UIFont fontWithName:[self.data objectForKey:fontName] size:self.fontSize];
    cell.textLabel.font = font;
    cell.textLabel.text = fontName;

    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *fontName = [self.keys objectAtIndex:indexPath.row];
    UIFont *font = [UIFont fontWithName:[self.data objectForKey:fontName] size:self.fontSize];
    return [fontName sizeWithFont:font].height + 5.0;
}

#pragma mark -
#pragma mark Dynamic property

- (NSDictionary *)data
{
    return _data;
}

- (void)setData:(NSDictionary *)newData
{
    if (self.data != newData)
    {
        [_data release];
        _data = [newData retain];
        
        self.keys = [[self.data allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        
        [self.tableView reloadData];
    }
}

- (CGFloat)fontSize
{
    return _fontSize;
}

- (void)setFontSize:(CGFloat)newFontSize
{
    if (newFontSize != self.fontSize)
    {
        _fontSize = newFontSize;
        [self.tableView reloadData];
    }
}

@end
