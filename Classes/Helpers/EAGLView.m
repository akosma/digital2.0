#import <QuartzCore/QuartzCore.h>
#import <OpenGLES/EAGLDrawable.h>

#import "EAGLView.h"

#define USE_DEPTH_BUFFER	1

#define kInnerCircleRadius	1.0
#define kOuterCircleRadius	1.1

#define kTeapotScale		1.8
#define kCubeScale			0.42
#define kButtonScale		0.1

#define kButtonLeftSpace	1.1

#define	DegreesToRadians(x) ((x) * M_PI / 180.0)
#define	RadiansToDegrees(x) ((x) * 180.0 / M_PI)

@interface EAGLView ()

- (BOOL) createFramebuffer;
- (void) destroyFramebuffer;

@end


@implementation EAGLView

+ (Class)layerClass 
{
    return [CAEAGLLayer class];
}

- (id)initWithFrame:(CGRect)rect 
{
    if ((self = [super initWithFrame:(CGRect)rect])) 
    {
        CAEAGLLayer *eaglLayer = (CAEAGLLayer *)self.layer;
        
        eaglLayer.opaque = NO;
        self.opaque = NO;
        eaglLayer.drawableProperties = [NSDictionary dictionaryWithObjectsAndKeys:
                                        [NSNumber numberWithBool:NO], kEAGLDrawablePropertyRetainedBacking, 
                                        kEAGLColorFormatRGBA8, kEAGLDrawablePropertyColorFormat, nil];
        
        context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
        
        if (!context || ![EAGLContext setCurrentContext:context]) {
            [self release];
            return nil;
        }

        cubeRot = arc4random() % 50;

        animating = FALSE;
		displayLinkSupported = FALSE;
		
		mode = 1;
    }
    return self;
}

# pragma mark Draw

-(void)drawCube
{
	const GLfloat cubeVertices[6][12] = {
		{ 1, 1, 1,  1,-1, 1,  1,-1,-1,  1, 1,-1 },
		{-1, 1,-1, -1, 1, 1,  1, 1, 1,  1, 1,-1 },
		{ 1,-1, 1, -1,-1, 1, -1, 1, 1,  1, 1, 1 },
		{-1, 1, 1, -1,-1, 1, -1,-1,-1, -1, 1,-1 },
		{ 1,-1,-1, -1,-1,-1, -1, 1,-1,  1, 1,-1 },
		{ 1,-1, 1, -1,-1, 1, -1,-1,-1,  1,-1,-1 },
	};
	
	cubeRot += 1;
	
	glPushMatrix();
	glLoadIdentity();
	glTranslatef(cubePos[0], cubePos[1], cubePos[2]);
	glScalef(kCubeScale, kCubeScale, kCubeScale);

	glRotatef(cubeRot, 1, 0, 0);
	glRotatef(cubeRot, 0, 1, 1);
    glEnable(GL_LINE_STRIP);
    glPointSize(1.0);
    glLineWidth(4.0);

	for (int f = 0; f < 6; f++) 
    {
		glVertexPointer(3, GL_FLOAT, 0, cubeVertices[f]);
		glDrawArrays(GL_LINE_STRIP, 0, 4);
	}
	
	glPopMatrix();
	
	glBindTexture(GL_TEXTURE_2D, 0);
}

- (void)drawView 
{
    [EAGLContext setCurrentContext:context];
    
    glBindFramebufferOES(GL_FRAMEBUFFER_OES, viewFramebuffer);
    
    glClearColor(0.0f, 0.0f, 0.0f, 0.0f);
	glClearDepthf(1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
	
	// start drawing 3D objects
	glEnable(GL_DEPTH_TEST);
	glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    glOrthof(-1.0f, 1.0f, -1.5f, 1.5f, -10.0f, 10.0f);
	// tranform the camara for a better view
	glTranslatef(0.0f, 0.0f, 0.0f);
	glRotatef(0.0f, 0.0f, 0.0f, 0.0f);
	glMatrixMode(GL_MODELVIEW);

    const GLfloat zNear = 0.1, zFar = 1000.0, fieldOfView = 50.0;
    GLfloat size;
	
    glEnable(GL_DEPTH_TEST);
    glMatrixMode(GL_PROJECTION);
    size = zNear * tanf(DegreesToRadians(fieldOfView) / 2.0);
	
    CGRect rect = self.bounds;
    glFrustumf(-size, 
               size, 
               -size / (rect.size.width / rect.size.height), 
               size / (rect.size.width / rect.size.height), 
               zNear, 
               zFar);
    glViewport(0, 0, rect.size.width, rect.size.height);
    glClearColor(0.0f, 0.0f, 0.0f, 0.0f);
    
    GLfloat zTransform = -30.0;
    glTranslatef(0.0, 0.0, zTransform);
    
	glEnableClientState(GL_VERTEX_ARRAY);
    glHint(GL_LINE_SMOOTH_HINT, GL_NICEST);
    glEnable(GL_LINE_SMOOTH);
    glEnable(GL_POINT_SMOOTH);

	[self drawCube];
	
    glBindRenderbufferOES(GL_RENDERBUFFER_OES, viewRenderbuffer);
    [context presentRenderbuffer:GL_RENDERBUFFER_OES];
}


- (void)layoutSubviews {
    [EAGLContext setCurrentContext:context];
    [self destroyFramebuffer];
    [self createFramebuffer];
    [self drawView];
}

- (BOOL)createFramebuffer {
    
    glGenFramebuffersOES(1, &viewFramebuffer);
    glGenRenderbuffersOES(1, &viewRenderbuffer);
    
    glBindFramebufferOES(GL_FRAMEBUFFER_OES, viewFramebuffer);
    glBindRenderbufferOES(GL_RENDERBUFFER_OES, viewRenderbuffer);
    [context renderbufferStorage:GL_RENDERBUFFER_OES fromDrawable:(CAEAGLLayer*)self.layer];
    glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_COLOR_ATTACHMENT0_OES, GL_RENDERBUFFER_OES, viewRenderbuffer);
    
    glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_WIDTH_OES, &backingWidth);
    glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_HEIGHT_OES, &backingHeight);
    
    if (USE_DEPTH_BUFFER) {
        glGenRenderbuffersOES(1, &depthRenderbuffer);
        glBindRenderbufferOES(GL_RENDERBUFFER_OES, depthRenderbuffer);
        glRenderbufferStorageOES(GL_RENDERBUFFER_OES, GL_DEPTH_COMPONENT16_OES, backingWidth, backingHeight);
        glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_DEPTH_ATTACHMENT_OES, GL_RENDERBUFFER_OES, depthRenderbuffer);
    }
    
    if(glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES) != GL_FRAMEBUFFER_COMPLETE_OES) {
        NSLog(@"failed to make complete framebuffer object %x", glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES));
        return NO;
    }
	
	glViewport(0, 0, backingWidth, backingHeight);
	
    return YES;
}

- (void)destroyFramebuffer 
{
    glDeleteFramebuffersOES(1, &viewFramebuffer);
    viewFramebuffer = 0;
    glDeleteRenderbuffersOES(1, &viewRenderbuffer);
    viewRenderbuffer = 0;
    
    if(depthRenderbuffer) 
    {
        glDeleteRenderbuffersOES(1, &depthRenderbuffer);
        depthRenderbuffer = 0;
    }
}

- (void)dealloc 
{
    if ([EAGLContext currentContext] == context) 
    {
        [EAGLContext setCurrentContext:nil];
    }
    
    [context release];
	
    [super dealloc];
}

@end
