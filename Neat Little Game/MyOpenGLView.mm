//
//  MyOpenGLView.m
//  Neat Little Game
//
//  Created by Christopher Sierigk on 27.08.12.
//  Copyright (c) 2012 DerRM Productions. All rights reserved.
//

#import "MyOpenGLView.h"

const GLchar* vertexShader =
{
    "#version 150\n"\
    
    "in vec4 in_Position;\n"\
    "uniform vec4 in_Color;\n"\
    "uniform mat4 uMVPMatrix;\n"
    "out vec4 ex_Color;\n"\
    
    "void main(void)\n"\
    "{\n"\
    "   gl_Position = uMVPMatrix * in_Position;\n"\
    "   gl_PointSize = 5;\n"\
    "   ex_Color = in_Color;\n"\
    "}\n"
};

const GLchar* fragmentShader =
{
  "#version 150\n"\
    
    "in vec4 ex_Color;\n"\
    "out vec4 out_Color;\n"\
    
    "void main(void)\n"\
    "{\n"\
    "   out_Color = ex_Color;\n"\
    "}\n"
};

typedef struct {
    GLfloat position[4];
} Vertex;

typedef struct {
    GLfloat color[4];  
} Color;;

const Vertex Vertices[] = {
    {-0.8f,  0.8f, 0.0f, 1.0f},
    { 0.8f,  0.8f, 0.0f, 1.0f},
    {-0.8f, -0.8f, 0.0f, 1.0f},
    { 0.8f, -0.8f, 0.0f, 1.0f}
};

const Color Colors[] = {
    {1.0f, 0.0f, 0.0f, 1.0f},
    {0.0f, 1.0f, 0.0f, 1.0f},
    {0.0f, 0.0f, 1.0f, 1.0f},
    {1.0f, 1.0f, 1.0f, 1.0f},
};

Vertex* vertices2;

@implementation MyOpenGLView

- (id)initWithFrame:(NSRect)frameRect
{
    self = [super initWithFrame:frameRect];
    
    if (self != nil) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mSurfaceNeedsUpdate:) name:NSViewGlobalFrameDidChangeNotification object:self];
    }
        
    return self;
}

- (void)timerCallback:(NSTimer*)timer
{
    [self display];
}

-(void)awakeFromNib
{
    NSTimer* renderTimer = [NSTimer timerWithTimeInterval:0.001 target:self selector:@selector(timerCallback:) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:renderTimer forMode:NSEventTrackingRunLoopMode];
    [[NSRunLoop currentRunLoop] addTimer:renderTimer forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop] addTimer:renderTimer forMode:NSModalPanelRunLoopMode];
}

- (void)createSphere
{
    vertices2 = (Vertex*) malloc(sizeof(Vertex) * (400 + 2));
    
    GLfloat theta;
    GLfloat phi;
    
    GLfloat rx = 1., ry = 1., rz = 1.;
    
    int index = 0;
    
    vertices2[index].position[0] = 0;
    vertices2[index].position[1] = 0;
    vertices2[index].position[2] = rz * 1;
    vertices2[index].position[3] = 1.0f;
    
    index++;
    
    for (int i = 0 ; i < 20; i++)
    {
        phi += M_PI / 20;
        
        for (int j = 0; j < 20; j++)
        {
            theta += (2 * M_PI) / 22;
            
            vertices2[index].position[0] = rx * cosf(theta) * sinf(phi);
            vertices2[index].position[1] = ry * sinf(theta) * sinf(phi);
            vertices2[index].position[2] = rz * cosf(phi);
            vertices2[index].position[3] = 1.0f;
            
            index++;
            //printf("%f\n", vertices2[i].position[0]);
        }
    }
    
    vertices2[index].position[0] = 0;
    vertices2[index].position[1] = 0;
    vertices2[index].position[2] = rz * -1;
    vertices2[index].position[3] = 1.0f;
}

- (void)prepareOpenGL
{
    glEnable(GL_PROGRAM_POINT_SIZE);
    
    GLint swapInt = 1;
    [[self openGLContext] setValues:&swapInt forParameter:NSOpenGLCPSwapInterval];
    
    mView = [Matrix4 lookAtEyeX:0.0f EyeY:0.0f EyeZ:-0.5f CenterX:0.0f CenterY:0.0f CenterZ:-5.0f UpX:0.0f UpY:1.0f UpZ:0.0f];
    mRotation = [Matrix4 rotateByYXZwithX:90.0f Y:0.0f Z:0.0f];
    mModel = [[Matrix4 alloc] initAsIdentity];
    mModel = [Matrix4 translationMatrix:mModel WithX:0.0f Y:0.0f Z:-1.0f];
   
    [self createSphere];
    
    [self createShaders];
    [self createVBO];
}

- (GLuint)compileShader: (const GLchar*)shaderString withType:(GLenum)shaderType {
    
    GLuint shaderHandle = glCreateShader(shaderType);
    
    glShaderSource(shaderHandle, 1, &shaderString, NULL);
    
    glCompileShader(shaderHandle);
    
    GLint compileSuccess;
    glGetShaderiv(shaderHandle, GL_COMPILE_STATUS, &compileSuccess);
    
    if (compileSuccess == GL_FALSE) {
        GLchar messages[256];
        glGetShaderInfoLog(shaderHandle, sizeof(messages), 0, &messages[0]);
        NSString *messageString = [NSString stringWithUTF8String:messages];
        NSLog(@"%@", messageString);
        exit(1);
    }
    
    return shaderHandle;
}


- (void)createShaders
{
    GLenum errorCheckValues = glGetError();
    
    vertexShaderId = [self compileShader:vertexShader withType:GL_VERTEX_SHADER];
    fragmentShaderId = [self compileShader:fragmentShader withType:GL_FRAGMENT_SHADER];
    
    programId = glCreateProgram();
    glAttachShader(programId, vertexShaderId);
    glAttachShader(programId, fragmentShaderId);
    glLinkProgram(programId);
    glUseProgram(programId);
    
    errorCheckValues = glGetError();
    if (errorCheckValues != GL_NO_ERROR) {
        NSLog(@"ERROR: Could not create the shaders: %s \n", gluErrorString(errorCheckValues));
        exit(EXIT_FAILURE);
    }
}

- (void)createVBO
{
    GLenum errorCheckValues = glGetError();
    
    glGenVertexArrays(1, &vaoId);
    glBindVertexArray(vaoId);
    
    glGenBuffers(1, &vboId);
    glBindBuffer(GL_ARRAY_BUFFER, vboId);
    glBufferData(GL_ARRAY_BUFFER, (400 + 2) * 4 * 4, vertices2, GL_STATIC_DRAW);
    vecLoc = glGetAttribLocation(programId, "in_Position");
    glVertexAttribPointer(vecLoc, 4, GL_FLOAT, GL_FALSE, 0, 0);
    glEnableVertexAttribArray(vecLoc);

    colLoc = glGetUniformLocation(programId, "in_Color");
    mMVPHandle = glGetUniformLocation(programId, "uMVPMatrix");
    
    glUniform4f(colLoc, 1.0f, 0.0f, 0.0f, 0.0f);
    
    errorCheckValues = glGetError();
    if (errorCheckValues != GL_NO_ERROR) {
        NSLog(@"ERROR: Could not create VBO: %s \n", gluErrorString(errorCheckValues));
        exit(EXIT_FAILURE);
    }
}

- (void) mSurfaceNeedsUpdate:(NSNotification*)notification
{
    NSOpenGLContext* glContext = [self openGLContext];
    [glContext update];
    [self reshape];
}

- (NSOpenGLContext*)openGLContext
{
    if (!mOpenGLContext) {
        NSOpenGLPixelFormatAttribute attr[] = {
            NSOpenGLPFAOpenGLProfile, NSOpenGLProfileVersion3_2Core,
            NSOpenGLPFADoubleBuffer,
            NSOpenGLPFADepthSize, 24,
            NSOpenGLPFAColorSize, 24,
            NSOpenGLPFAAlphaSize, 8,
            NSOpenGLPFAAccelerated,
            0
        };
        
        NSOpenGLPixelFormat* pixelFormat = [[NSOpenGLPixelFormat alloc] initWithAttributes:attr];
        
        if (!pixelFormat) {
            NSLog(@"Unable to create windowed pixel format");
            return nil;
        }
        
        mOpenGLContext = [[NSOpenGLContext alloc] initWithFormat:pixelFormat shareContext:nil];
        
        if (mOpenGLContext) {
            [mOpenGLContext setView:self];
        } else {
            NSLog(@"Failed to create the OpenGL Context object.");
        }
        [pixelFormat release];
    }
    return mOpenGLContext;
}

- (void)reshape
{
    NSRect frame = [self frame];
    glViewport(0, 0, (GLsizei)frame.size.width, (GLsizei)frame.size.height);
    float ratio = self.frame.size.width / self.frame.size.height;
    mProjection = [Matrix4 frustumWithLeft:-ratio Right:ratio Top:1.0f Bottom:-1.0f Near:1.0f Far:1000.0f];

}

//- (BOOL)isOpaque
//{
//    return YES;
//}

- (void)lockFocus
{
    [super lockFocus];

    NSOpenGLContext* context = [self openGLContext];
    
    [context makeCurrentContext];
}

- (void)drawRect:(NSRect)rect
{    
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glClearColor(0.0, 0.0, 0.0, 1.0);
    
    mCurrentRotation += 1;

    mRotation = [Matrix4 rotateByYXZwithX:-90.0f Y:mCurrentRotation Z:0.0f];
    mModel = [[Matrix4 alloc] initAsIdentity];
    mModel = [Matrix4 translationMatrix:mModel WithX:0.0f Y:0.0f Z:-2.0f];
    
    mModel = [Matrix4 multiply:mModel With:mRotation];
    mModelViewProjection = [Matrix4 multiply:mView With:mModel];
    mModelViewProjection = [Matrix4 multiply:mProjection With:mModelViewProjection];
    
    glUniformMatrix4fv(mMVPHandle, 1, GL_FALSE, mModelViewProjection.array);

    //glPointSize(5);
    glDrawArrays(GL_LINE_STRIP, 0, 400 + 2);
    
    [[self openGLContext] flushBuffer];
}

- (void)destroyShaders
{
    GLenum errorCheckValues = glGetError();
    
    glUseProgram(0);
    
    glDetachShader(programId, vertexShaderId);
    glDetachShader(programId, fragmentShaderId);
    
    glDeleteShader(fragmentShaderId);
    glDeleteShader(vertexShaderId);
    
    glDeleteProgram(programId);
        
    errorCheckValues = glGetError();
    if (errorCheckValues != GL_NO_ERROR) {
        NSLog(@"ERROR: Could not destroy the shaders: %s \n", gluErrorString(errorCheckValues));
        exit(-1);
    }
}

- (void)destroyVBO
{
    GLenum errorCheckValues = glGetError();
    
    glDisableVertexAttribArray(colLoc);
    glDisableVertexAttribArray(vecLoc);
    
    glBindBuffer(GL_ARRAY_BUFFER, 0);
    
    glDeleteBuffers(1, &colorBufferId);
    glDeleteBuffers(1, &vboId);
    
    glBindVertexArray(0);
    glDeleteVertexArrays(1, &vaoId);
    
    errorCheckValues = glGetError();
    if (errorCheckValues != GL_NO_ERROR) {
        NSLog(@"ERROR: Could not destroy the VBO: %s \n", gluErrorString(errorCheckValues));
        exit(-1);
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSViewGlobalFrameDidChangeNotification object:self];
    [self destroyShaders];
    [self destroyVBO];
    
    [mOpenGLContext release];
    [super dealloc];
}

@end
