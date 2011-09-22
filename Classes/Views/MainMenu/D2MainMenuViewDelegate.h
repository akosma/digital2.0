//
//  D2MainMenuViewDelegate.h
//  Digital 2.0
//
//  Created by Adrian on 5/10/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import <UIKit/UIKit.h>

@class D2MainMenuView;

@protocol D2MainMenuViewDelegate <NSObject>

@optional
- (void)mainMenu:(D2MainMenuView *)menu didSelectButtonWithTag:(NSInteger)tag;

@end
