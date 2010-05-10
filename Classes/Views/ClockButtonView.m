//
//  ClockButtonView.m
//  Digital 2.0
//
//  Created by Adrian on 5/8/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import "ClockButtonView.h"
#import <QuartzCore/QuartzCore.h>

@interface ClockButtonView ()

@property (nonatomic, retain) UIImageView *secondsHand;
@property (nonatomic, retain) UIImageView *minutesHand;
@property (nonatomic, retain) UIImageView *hoursHand;

@end


@implementation ClockButtonView

@synthesize secondsHand = _secondsHand;
@synthesize minutesHand = _minutesHand;
@synthesize hoursHand = _hoursHand;

- (void)subclassSetup
{
    self.secondsHand = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"button_22_seconds.png"]] autorelease];
    self.secondsHand.layer.anchorPoint = CGPointMake(0.5, 0.5);
    [self addSubview:self.secondsHand];

    self.minutesHand = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"button_22_minutes.png"]] autorelease];
    self.minutesHand.layer.anchorPoint = CGPointMake(0.5, 0.5);
    [self addSubview:self.minutesHand];
    
    self.hoursHand = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"button_22_hours.png"]] autorelease];
    self.hoursHand.layer.anchorPoint = CGPointMake(0.5, 0.5);
    [self addSubview:self.hoursHand];

    [self animate];
}

- (void)dealloc 
{
    self.secondsHand = nil;
    self.minutesHand = nil;
    self.hoursHand = nil;
    [super dealloc];
}

- (void)animate
{
    NSDate *today = [NSDate date];
    NSCalendar *gregorian = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    NSDateComponents *weekdayComponents = [gregorian components:(NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit)
                                                       fromDate:today];
    NSInteger hour = [weekdayComponents hour];
    NSInteger minute = [weekdayComponents minute];
    NSInteger second = [weekdayComponents second];
    
    CGFloat hourAngle = 0.0;
    CGFloat minuteAngle = 0.0;
    CGFloat secondsAngle = 0.0;
    CGFloat minutesContributionAngle = 0.0;
    CGFloat secondsContributionAngle = 0.0;
    if (hour > 12)
    {
        hour = hour - 12;
    }
    if (hour < 6)
    {
        hourAngle = hour * M_PI / 6.0;
    }
    else 
    {
        hourAngle = -1.0 * (12 - hour) * M_PI / 6.0;
    }
    minutesContributionAngle = minute * M_PI / 360.0;
    hourAngle += minutesContributionAngle;
    
    if (minute < 30)
    {
        minuteAngle = minute * M_PI / 30.0;
    }
    else
    {
        minuteAngle = -1.0 * (60.0 - minute) * M_PI / 30.0;
    }
    secondsContributionAngle = second * M_PI / 1800.0;
    minuteAngle += secondsContributionAngle;
    
    if (second < 30)
    {
        secondsAngle = second * M_PI / 30.0;
    }
    else 
    {
        secondsAngle = -1.0 * (60.0 - second) * M_PI / 30.0;
    }
    
    self.hoursHand.transform = CGAffineTransformMakeRotation(hourAngle);
    self.minutesHand.transform = CGAffineTransformMakeRotation(minuteAngle);
    self.secondsHand.transform = CGAffineTransformMakeRotation(secondsAngle);
}

@end
