//
//  CustomFontView.h
//  Digital 2.0
//
//  Created by Adrian on 6/19/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

@interface CustomFontView : UIView 
{
@private
    CTFontRef _customFont;
    CTFontRef _customBoldFont;
}

@end
