//
//  Vector3.m
//  iPhoneOpenGL
//
//  Created by Christopher Sierigk on 19.08.12.
//  Copyright (c) 2012 Christopher Sierigk. All rights reserved.
//

#import "Vector3.h"

@implementation Vector3

@synthesize x = mX;
@synthesize y = mY;
@synthesize z = mZ;

- (id)init {
    self = [super init];
    
    if (self) {
        mX = 0.0f;
        mY = 0.0f;
        mZ = 0.0f;
    }
    
    return self;
}

- (id)initWithX:(float)x Y:(float)y Z:(float)z {
    self = [super init];
    
    if (self) {
        mX = x;
        mY = y;
        mZ = z;
    }
    return self;
}

+ (Vector3*)addVector1:(Vector3 *)vec1 ToVector2:(Vector3 *)vec2 {
    Vector3* vec = [[Vector3 alloc] init];
    
    vec.x = vec1.x + vec2.x;
    vec.y = vec1.y + vec2.y;
    vec.z = vec1.z + vec2.z;
    
    return vec;
}

+ (Vector3*)subVector1:(Vector3 *)vec1 FromVector2:(Vector3 *)vec2 {
    Vector3* vec = [[Vector3 alloc] init];
    
    vec.x = vec1.x - vec2.x;
    vec.y = vec1.y - vec2.y;
    vec.z = vec1.z - vec2.z;
    
    return vec;
}

+ (float)dotProductVector1:(Vector3 *)vec1 Vector2:(Vector3 *)vec2 {
    float dotproduct = vec1.x * vec2.x + vec1.y * vec2.y + vec1.z * vec2.z;
    return dotproduct;
}

+ (Vector3*)crossProductVector1:(Vector3 *)vec1 Vector2:(Vector3 *)vec2 {
    Vector3* crossProduct = [[Vector3 alloc] init];
    crossProduct.x = vec1.y * vec2.z - vec1.z * vec2.y;
    crossProduct.y = vec1.z * vec2.x - vec1.x * vec2.z;
    crossProduct.z = vec1.x * vec2.y - vec1.y * vec2.x;
    
    return crossProduct;
}

+ (float)magnitudeOf:(Vector3 *)vec {
    float magnitude = sqrtf(vec.x * vec.x + vec.y * vec.y + vec.z * vec.z);
    return magnitude;
}

+ (Vector3*)mulVector:(Vector3 *)vec WithScalar:(float)scalar {
    Vector3* scaledVector = [[Vector3 alloc] init];
    scaledVector.x = vec.x * scalar;
    scaledVector.y = vec.y * scalar;
    scaledVector.z = vec.z * scalar;
    return scaledVector;
}

+ (Vector3*)normalizeVector:(Vector3 *)vec {
    Vector3* normalizedVector = [Vector3 mulVector:vec WithScalar: 1 / [Vector3 magnitudeOf:vec]];
    return normalizedVector;
}

- (float*)array {
    mArray[0] = mX;
    mArray[1] = mY;
    mArray[2] = mZ;
    return mArray;
}

-(void)dealloc {
    [super dealloc];
}

@end
