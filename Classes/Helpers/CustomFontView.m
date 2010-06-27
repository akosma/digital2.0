//
//  CustomFontView.m
//  Digital 2.0
//
//  Created by Adrian on 6/19/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import "CustomFontView.h"

@interface CustomFontView ()

- (CTFontRef)loadFont:(NSString *)name size:(CGFloat)size;
- (void)drawText:(NSString *)text font:(CTFontRef)font position:(CGFloat)position context:(CGContextRef)context;

@end



@implementation CustomFontView

- (id)initWithFrame:(CGRect)frame 
{
    if ((self = [super initWithFrame:frame])) 
    {
        self.backgroundColor = [UIColor clearColor];
        _customFont = [self loadFont:@"YanoneKaffeesatz-Regular" size:20.0];
        _customBoldFont = [self loadFont:@"YanoneKaffeesatz-Bold" size:66.0];
    }
    return self;
}

- (void)dealloc 
{
    CFRelease(_customFont);
    CFRelease(_customBoldFont);
    
    [super dealloc];
}

- (void)drawRect:(CGRect)rect 
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGAffineTransform flip = CGAffineTransformMake(1.0, 0.0, 0.0, -1.0, 0.0, self.frame.size.height);
    CGContextConcatCTM(context, flip);
    [self drawText:@"Dare rich fonts!" font:_customBoldFont position:50.0 context:context];
    [self drawText:@"typeface: Yanone Kaffeesatz" font:_customFont position:80.0 context:context];
}

#pragma mark -
#pragma mark Private methods

- (CTFontRef)loadFont:(NSString *)name size:(CGFloat)size
{
    // Adapted from http://stackoverflow.com/questions/2703085/how-can-you-load-a-font-ttf-from-a-file-using-core-text
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"ttf"];
    CFURLRef url = CFURLCreateWithFileSystemPath(kCFAllocatorDefault, (CFStringRef)path, kCFURLPOSIXPathStyle, false);
    CGDataProviderRef dataProvider = CGDataProviderCreateWithURL(url);
    CGFontRef theCGFont = CGFontCreateWithDataProvider(dataProvider);
    CTFontRef result = CTFontCreateWithGraphicsFont(theCGFont, size, NULL, NULL);
    CFRelease(theCGFont);
    CFRelease(dataProvider);
    CFRelease(url);
    return result;
}

- (void)drawText:(NSString *)text font:(CTFontRef)font position:(CGFloat)position context:(CGContextRef)context
{
    // Initialize string, font, and context
    CFStringRef keys[] = { kCTFontAttributeName, kCTForegroundColorAttributeName };
    CFTypeRef values[] = { font, [UIColor grayColor].CGColor };
    
    CFDictionaryRef attributes =
    CFDictionaryCreate(kCFAllocatorDefault, (const void**)&keys,
                       (const void**)&values, sizeof(keys) / sizeof(keys[0]),
                       &kCFTypeDictionaryKeyCallBacks,
                       &kCFTypeDictionaryValueCallBacks);
    
    CFAttributedStringRef attrString = CFAttributedStringCreate(kCFAllocatorDefault, (CFStringRef)text, attributes);
    CFRelease(attributes);
    
    CTLineRef line = CTLineCreateWithAttributedString(attrString);
    CFRelease(attrString);
    
    // Set text position and draw the line into the graphics context
    CGContextSetTextPosition(context, 0.0, self.frame.size.height - position);
    CTLineDraw(line, context);
    CFRelease(line);
}

@end
