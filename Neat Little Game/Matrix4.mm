//
//  Matrix4.m
//  iPhoneOpenGL
//
//  Created by Christopher Sierigk on 19.08.12.
//  Copyright (c) 2012 Christopher Sierigk. All rights reserved.
//

#import "Matrix4.h"

@implementation Matrix4

@synthesize m11, m12, m13, m14;
@synthesize m21, m22, m23, m24;
@synthesize m31, m32, m33, m34;
@synthesize m41, m42, m43, m44;

- (id)initWithZeros {
    self = [super init];
    if (self) {
        m11 = 0; m12 = 0; m13 = 0; m14 = 0;
        m21 = 0; m22 = 0; m23 = 0; m24 = 0;
        m31 = 0; m32 = 0; m33 = 0; m34 = 0;
        m41 = 0; m42 = 0; m43 = 0; m44 = 0;
    }
    return self;
}

- (id)initAsIdentity {
    self = [super init];
    if (self) {
        m11 = 1; m12 = 0; m13 = 0; m14 = 0;
        m21 = 0; m22 = 1; m23 = 0; m24 = 0;
        m31 = 0; m32 = 0; m33 = 1; m34 = 0;
        m41 = 0; m42 = 0; m43 = 0; m44 = 1;
    }
    return self;
}

+ (Matrix4*) multiply:(Matrix4*) matrixA With:(Matrix4*) matrixB {
    Matrix4* result = [[Matrix4 alloc] init];
    
    result.m11 = matrixA.m11 * matrixB.m11 + matrixA.m12 * matrixB.m21 + matrixA.m13 * matrixB.m31 + matrixA.m14 * matrixB.m41;
    result.m21 = matrixA.m21 * matrixB.m11 + matrixA.m22 * matrixB.m21 + matrixA.m23 * matrixB.m31 + matrixA.m24 * matrixB.m41;
    result.m31 = matrixA.m31 * matrixB.m11 + matrixA.m32 * matrixB.m21 + matrixA.m33 * matrixB.m31 + matrixA.m34 * matrixB.m41;
    result.m41 = matrixA.m41 * matrixB.m11 + matrixA.m42 * matrixB.m21 + matrixA.m43 * matrixB.m31 + matrixA.m44 * matrixB.m41;
    
    result.m12 = matrixA.m11 * matrixB.m12 + matrixA.m12 * matrixB.m22 + matrixA.m13 * matrixB.m32 + matrixA.m14 * matrixB.m42;
    result.m22 = matrixA.m21 * matrixB.m12 + matrixA.m22 * matrixB.m22 + matrixA.m23 * matrixB.m32 + matrixA.m24 * matrixB.m42;
    result.m32 = matrixA.m31 * matrixB.m12 + matrixA.m32 * matrixB.m22 + matrixA.m33 * matrixB.m32 + matrixA.m34 * matrixB.m42;
    result.m42 = matrixA.m41 * matrixB.m12 + matrixA.m42 * matrixB.m22 + matrixA.m43 * matrixB.m32 + matrixA.m44 * matrixB.m42;
    
    result.m13 = matrixA.m11 * matrixB.m13 + matrixA.m12 * matrixB.m23 + matrixA.m13 * matrixB.m33 + matrixA.m14 * matrixB.m43;
    result.m23 = matrixA.m21 * matrixB.m13 + matrixA.m22 * matrixB.m23 + matrixA.m23 * matrixB.m33 + matrixA.m24 * matrixB.m43;
    result.m33 = matrixA.m31 * matrixB.m13 + matrixA.m32 * matrixB.m23 + matrixA.m33 * matrixB.m33 + matrixA.m34 * matrixB.m43;
    result.m43 = matrixA.m41 * matrixB.m13 + matrixA.m42 * matrixB.m23 + matrixA.m43 * matrixB.m33 + matrixA.m44 * matrixB.m43;
    
    result.m14 = matrixA.m11 * matrixB.m14 + matrixA.m12 * matrixB.m24 + matrixA.m13 * matrixB.m34 + matrixA.m14 * matrixB.m44;
    result.m24 = matrixA.m21 * matrixB.m14 + matrixA.m22 * matrixB.m24 + matrixA.m23 * matrixB.m34 + matrixA.m24 * matrixB.m44;
    result.m34 = matrixA.m31 * matrixB.m14 + matrixA.m32 * matrixB.m24 + matrixA.m33 * matrixB.m34 + matrixA.m34 * matrixB.m44;
    result.m44 = matrixA.m41 * matrixB.m14 + matrixA.m42 * matrixB.m24 + matrixA.m43 * matrixB.m34 + matrixA.m44 * matrixB.m44;
    
    return result;
}

+ (Vector4*) multiplyMatrix:(Matrix4 *)matrix WithVector:(Vector4 *)vector {
    Vector4* result = [[Vector4 alloc] init];
    
    result.x = matrix.m11 * vector.x + matrix.m12 * vector.y + matrix.m13 * vector.z + matrix.m14 * vector.w;
    result.y = matrix.m21 * vector.x + matrix.m22 * vector.y + matrix.m23 * vector.z + matrix.m24 * vector.w;
    result.z = matrix.m31 * vector.x + matrix.m32 * vector.y + matrix.m33 * vector.z + matrix.m34 * vector.w;
    result.w = matrix.m41 * vector.x + matrix.m42 * vector.y + matrix.m43 * vector.z + matrix.m44 * vector.w;
    
    return result;
}

#define DegreesToRadiansFactor 0.017453292519943f
#define RadiansToDegreesFactor 57.29577951308232f
#define DegreesToRadians(D) ((D) * DegreesToRadiansFactor)
#define RadiansToDegrees(R) ((R) * RadiansToDegreesFactor)

+ (Matrix4*)rotateByYXZwithX:(float)x Y:(float)y Z:(float)z {
    Matrix4* rotation = [[Matrix4 alloc] initAsIdentity];
    
    float xRadians = DegreesToRadians(x);
    float yRadians = DegreesToRadians(y);
    float zRadians = DegreesToRadians(z);
    
    float cx = cosf(xRadians);
    float cy = cosf(yRadians);
    float cz = cosf(zRadians);
    
    float sx = sinf(xRadians);
    float sy = sinf(yRadians);
    float sz = sinf(zRadians);
    
    rotation.m11 = (cy * cz) + (sx * sy * sz);
    rotation.m21 = cx * sz;
    rotation.m31 = (cy * sx * sz) - (cz * sy);
    
    rotation.m12 = (cz * sx * sy) - (cy * sz);
    rotation.m22 = cx * cz;
    rotation.m32 = (cy * cz * sx) + (sy * sz);
    
    rotation.m13 = cx * sy;
    rotation.m23 = -sx;
    rotation.m33 = cx * cy;
    
    return rotation;
}

+ (Matrix4*)rotateByYXZwith:(Vector3*) vec {
    Matrix4* rotation = [Matrix4 rotateByYXZwithX:vec.x Y:vec.y Z:vec.z];
    return rotation;
}

+ (Matrix4*)frustumWithLeft: (float)left Right:(float)right Top:(float)top Bottom:(float)bottom Near:(float)near Far:(float)far {
    
    Matrix4* projection = [[Matrix4 alloc] initWithZeros];
    projection.m11 = (2.0f * near) / (right - left);
    
    projection.m22 = (2.0f * near) / (top - bottom);
    
    projection.m13 = (right + left) / (right - left);
    projection.m23 = (top + bottom) / (top - bottom);
    projection.m33 = -(far + near) / (far - near);
    projection.m43 = -1.0f;
    
    projection.m34 = -(2.0f * far * near) / (far - near);
    
    return projection;
}

+ (Matrix4*)translationMatrix:(Matrix4*)matrix WithX:(float)x Y:(float)y Z:(float)z {
    
    Matrix4* translation = [[Matrix4 alloc] initAsIdentity];
    
    translation.m14 = x * matrix.m11 + y * matrix.m12 + z * matrix.m13 + matrix.m14;
    translation.m24 = x * matrix.m21 + y * matrix.m22 + z * matrix.m23 + matrix.m24;
    translation.m34 = x * matrix.m31 + y * matrix.m32 + z * matrix.m33 + matrix.m34;
    translation.m44 = x * matrix.m41 + y * matrix.m42 + z * matrix.m43 + matrix.m44;
    
    return translation;
}

+ (Matrix4*)translationMatrix:(Matrix4*)matrix With:(Vector3*)vec {
    Matrix4* translation = [Matrix4 translationMatrix:matrix WithX:vec.x Y:vec.y Z:vec.z];
    return translation;
}

+ (Matrix4*)lookAtEyeX:(float)eyeX EyeY:(float)eyeY EyeZ:(float)eyeZ CenterX:(float)centerX CenterY:(float)centerY CenterZ:(float)centerZ UpX:(float)upX UpY:(float)upY UpZ:(float)upZ {
    
    Vector3* eye = [[Vector3 alloc] initWithX:eyeX Y:eyeY Z:eyeZ];
    Vector3* center = [[Vector3 alloc] initWithX:centerX Y:centerY Z:centerZ];
    Vector3* up = [[Vector3 alloc] initWithX:upX Y:upY Z:upZ];
    
    Matrix4* lookAt = [Matrix4 lookAtEye:eye CenterVec:center UpVec:up];
    return lookAt;
}

+ (Matrix4*)lookAtEye:(Vector3 *)eyeVec CenterVec:(Vector3 *)centerVec UpVec:(Vector3 *)upVec {
    
    Vector3* fNorm = [Vector3 normalizeVector:[Vector3 subVector1:centerVec FromVector2:eyeVec]];
    //Vector3* upNorm = [Vector3 normalizeVector:upVec];
    Vector3* sNorm = [Vector3 normalizeVector:[Vector3 crossProductVector1:fNorm Vector2:upVec]];
    Vector3* uNorm = [Vector3 normalizeVector:[Vector3 crossProductVector1:sNorm Vector2:fNorm]];
    
    Matrix4* lookAt = [[Matrix4 alloc] initAsIdentity];
    
    lookAt.m11 = sNorm.x;
    lookAt.m21 = uNorm.x;
    lookAt.m31 = -fNorm.x;
    
    lookAt.m12 = sNorm.y;
    lookAt.m22 = uNorm.y;
    lookAt.m32 = -fNorm.y;
    
    lookAt.m13 = sNorm.z;
    lookAt.m23 = uNorm.z;
    lookAt.m33 = -fNorm.z;
    
    return lookAt;
}

- (float*)array{
    mArray[0] = m11;
    mArray[1] = m21;
    mArray[2] = m31;
    mArray[3] = m41;
    
    mArray[4] = m12;
    mArray[5] = m22;
    mArray[6] = m32;
    mArray[7] = m42;
    
    mArray[8] = m13;
    mArray[9] = m23;
    mArray[10] = m33;
    mArray[11] = m43;
    
    mArray[12] = m14;
    mArray[13] = m24;
    mArray[14] = m34;
    mArray[15] = m44;
    
    return mArray;
}

- (void)dealloc
{
    [super dealloc];
}

@end
