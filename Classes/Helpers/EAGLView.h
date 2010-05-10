#import <UIKit/UIKit.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

#define kCircleSegments     36

@interface EAGLView : UIView 
{
@private
    GLint backingWidth;
    GLint backingHeight;
    
    EAGLContext *context;
    
    GLuint viewRenderbuffer, viewFramebuffer;
    GLuint depthRenderbuffer;
    
    BOOL animating;
	BOOL displayLinkSupported;

	GLuint mode;
	
	GLfloat cubePos[3];
	GLfloat cubeRot;
}

- (void)drawView;

@end
