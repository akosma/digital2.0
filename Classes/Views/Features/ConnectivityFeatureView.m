//
//  ConnectivityFeatureView.m
//  Digital 2.0
//
//  Created by Adrian on 6/21/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import "ConnectivityFeatureView.h"


@implementation ConnectivityFeatureView


- (id)initWithFrame:(CGRect)frame 
{
    if ((self = [super initWithFrame:frame])) 
    {
        self.requiresNetwork = YES;
    }
    return self;
}

- (void)dealloc 
{
    [super dealloc];
}


@end
