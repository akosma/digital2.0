//
//  D2SimulationFeatureView.h
//  Lorenz
//
//  Created by Adrian Kosmaczewski on 03/11/09.
//  Copyright akosma software 2009. All rights reserved.
//

#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import "D2FeatureView.h"

@class BoxView;

@interface D2SimulationFeatureView : D2FeatureView
{
@private
    GLint backingWidth;
    GLint backingHeight;
    EAGLContext *context;
    GLuint viewRenderbuffer, viewFramebuffer;
    GLuint depthRenderbuffer;
    NSTimeInterval animationInterval;
    GLfloat rotationAngles[3];
    GLfloat zTransform;
    CGPoint startTouchPosition;
    CGPoint startTouchPosition2;
    GLenum drawMode;
}

@end
