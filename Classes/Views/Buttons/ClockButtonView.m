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

@property (nonatomic, retain) UIImageView *minutesHand;
@property (nonatomic, retain) UIImageView *hoursHand;
@property (nonatomic) CGFloat hourAngle;
@property (nonatomic) CGFloat minuteAngle;

@end


@implementation ClockButtonView

@synthesize minutesHand = _minutesHand;
@synthesize hoursHand = _hoursHand;
@synthesize minuteAngle = _minuteAngle;
@synthesize hourAngle = _hourAngle;

- (void)subclassSetup
{
    self.minutesHand = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"button_22_minutes.png"]] autorelease];
    self.minutesHand.layer.anchorPoint = CGPointMake(0.5, 0.5);
    [self addSubview:self.minutesHand];
    
    self.hoursHand = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"button_22_hours.png"]] autorelease];
    self.hoursHand.layer.anchorPoint = CGPointMake(0.5, 0.5);
    [self addSubview:self.hoursHand];

    self.hourAngle = 0.0;
    self.minuteAngle = 0.0;
 
    [self initializeTimer];
    [self animate];
}

- (void)dealloc 
{
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
    
    CGFloat newMinuteAngle = 0.0;
    CGFloat minutesContributionAngle = 0.0;
    if (hour > 12)
    {
        hour = hour - 12;
    }
    if (hour < 6)
    {
        self.hourAngle = hour * M_PI / 6.0;
    }
    else 
    {
        self.hourAngle = -1.0 * (12 - hour) * M_PI / 6.0;
    }
    minutesContributionAngle = minute * M_PI / 360.0;
    self.hourAngle += minutesContributionAngle;
    
    if (minute < 30)
    {
        newMinuteAngle = minute * M_PI / 30.0;
    }
    else
    {
        newMinuteAngle = -1.0 * (60.0 - minute) * M_PI / 30.0;
    }
    
    if (newMinuteAngle != self.minuteAngle)
    {
        self.minuteAngle = newMinuteAngle;
        self.hoursHand.transform = CGAffineTransformMakeRotation(self.hourAngle);
        self.minutesHand.transform = CGAffineTransformMakeRotation(self.minuteAngle);
    }
}

@end
