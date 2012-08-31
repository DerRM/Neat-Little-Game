//
//  Matrix4.h
//  iPhoneOpenGL
//
//  Created by Christopher Sierigk on 19.08.12.
//  Copyright (c) 2012 Christopher Sierigk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Math.h"

@class Vector3;

@interface Matrix4 : NSObject {
    float m11, m21, m31, m41;
    float m12, m22, m32, m42;
    float m13, m23, m33, m43;
    float m14, m24, m34, m44;
    
    float mArray[16];
}

@property (nonatomic, assign) float m11, m21, m31, m41;
@property (nonatomic, assign) float m12, m22, m32, m42;
@property (nonatomic, assign) float m13, m23, m33, m43;
@property (nonatomic, assign) float m14, m24, m34, m44;
@property (nonatomic, readonly) float* array;

- (id)initWithZeros;
- (id)initAsIdentity;
+ (Matrix4*)multiply:(Matrix4*) matrixA With:(Matrix4*) matrixB;
+ (Vector4*)multiplyMatrix:(Matrix4 *)matrix WithVector:(Vector4*)vector;
+ (Matrix4*)rotateByYXZwithX:(float)x Y:(float)y Z:(float)z;
+ (Matrix4*)rotateByYXZwith:(Vector3*) vec;
+ (Matrix4*)frustumWithLeft:(float)left Right:(float)right Top:(float)top Bottom:(float)bottom Near:(float)near Far:(float)far;
+ (Matrix4*)translationMatrix:(Matrix4*)matrix WithX:(float)x Y:(float)y Z:(float)z;
+ (Matrix4*)translationMatrix:(Matrix4*)matrix With:(Vector3*)vec;
+ (Matrix4*)lookAtEyeX:(float)eyeX EyeY:(float)eyeY EyeZ:(float)eyeZ CenterX:(float)centerX CenterY:(float)centerY CenterZ:(float)centerZ UpX:(float)upX UpY:(float)upY UpZ:(float)upZ;
+ (Matrix4*)lookAtEye:(Vector3*)eyeVec CenterVec:(Vector3*)centerVec UpVec:(Vector3*)upVec;

@end
