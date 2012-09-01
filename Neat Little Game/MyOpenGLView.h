//
//  MyOpenGLView.h
//  Neat Little Game
//
//  Created by Christopher Sierigk on 27.08.12.
//  Copyright (c) 2012 DerRM Productions. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <OpenGL/glu.h>
#undef __gl_h_ //stupid hack to get rid of gl3.h warning
#import <OpenGL/gl3.h>
#include <vector>
#import "Math.h"

@interface MyOpenGLView : NSView
{
    @private
    NSOpenGLContext* mOpenGLContext;
    NSOpenGLPixelFormat* mPixelFormat;
    GLuint
    vertexShaderId,
    fragmentShaderId,
    programId,
    vaoId,
    vboId,
    iboId,
    colorBufferId,
    vecLoc,
    colLoc;
    Matrix4* mView;
    Matrix4* mProjection;
    Matrix4* mModel;
    Matrix4* mRotation;
    Matrix4* mModelViewProjection;
    GLuint mMVPHandle;
    float mCurrentRotation;
    CVDisplayLinkRef mDisplayLink;
}

- (CVReturn)getFrameForTime:(const CVTimeStamp*)outputTime;
//- (void)timerCallback:(NSTimer*)timer;
- (id)initWithFrame:(NSRect)frameRect;
- (NSOpenGLContext*)openGLContext;
- (void)prepareOpenGL;
- (void)reshape;

@end
