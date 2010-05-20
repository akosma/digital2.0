//
//  MainMenuViewDelegate.h
//  Digital 2.0
//
//  Created by Adrian on 5/10/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainMenuView;

@protocol MainMenuViewDelegate <NSObject>

@optional
- (void)mainMenu:(MainMenuView *)menu didSelectButtonWithTag:(NSInteger)tag;

@end
