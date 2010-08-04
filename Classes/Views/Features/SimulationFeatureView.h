//
//  EAGLView.h
//  Lorenz
//
//  Created by Adrian Kosmaczewski on 03/11/09.
//  Copyright akosma software 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import "FeatureView.h"

@class BoxView;

@interface SimulationFeatureView : FeatureView
{
@private
    GLint backingWidth;
    GLint backingHeight;
    
    EAGLContext *context;
    
    GLuint viewRenderbuffer, viewFramebuffer;
    
    GLuint depthRenderbuffer;
    
    NSTimeInterval animationInterval;
    BOOL _animating;

    GLfloat rotationAngles[3];
    GLfloat zTransform;
    CGPoint startTouchPosition;
    CGPoint startTouchPosition2;
    
    GLenum drawMode;
    
    BoxView *_box;
}

- (void)startAnimation;
- (void)stopAnimation;
- (void)drawView;

- (void)setupView;
- (void)checkGLError:(BOOL)visibleCheck;

@end
