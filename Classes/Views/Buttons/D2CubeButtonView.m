//
//  D2CubeButtonView.m
//  Digital 2.0
//
//  Created by Adrian on 5/8/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import "D2CubeButtonView.h"
#import "EAGLView.h"

@interface D2CubeButtonView ()

@property (nonatomic, retain) EAGLView *eaglView;

@end


@implementation D2CubeButtonView

@synthesize eaglView = _eaglView;

- (void)subclassSetup
{
    self.clipsToBounds = YES;
    self.eaglView = [[[EAGLView alloc] initWithFrame:CGRectMake(0.0, 0.0, 175.0, 175.0)] autorelease];
    self.eaglView.userInteractionEnabled = NO;
    self.eaglView.exclusiveTouch = NO;
    [self initializeTimer];
    [self addSubview:self.eaglView];
}

- (void)animate
{
    NSDate *today = [NSDate date];
    NSCalendar *gregorian = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    NSDateComponents *components = [gregorian components:NSSecondCalendarUnit fromDate:today];
    NSInteger second = [components second];
    
    if (second > self.nextSecondAnimation && second < (self.nextSecondAnimation + 5))
    {
        [self.eaglView drawView];
    }
}

- (void)dealloc 
{
    [_eaglView release];
    [super dealloc];
}

@end
