//
//  Vector3.h
//  iPhoneOpenGL
//
//  Created by Christopher Sierigk on 19.08.12.
//  Copyright (c) 2012 Christopher Sierigk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Math.h"

@interface Vector3 : NSObject {
    float mX, mY, mZ;
    
    float mArray[3];
}

@property (nonatomic, assign) float x;
@property (nonatomic, assign) float y;
@property (nonatomic, assign) float z;
@property (nonatomic, readonly) float* array;

- initWithX:(float)x Y:(float)y Z:(float)z;
+ (Vector3*)addVector1:(Vector3*)vec1 ToVector2:(Vector3*)vec2;
+ (Vector3*)subVector1:(Vector3*)vec1 FromVector2:(Vector3*)vec2;
+ (float)dotProductVector1:(Vector3*)vec1 Vector2:(Vector3*)vec2;
+ (Vector3*)crossProductVector1:(Vector3*)vec1 Vector2:(Vector3*)vec2;
+ (Vector3*)mulVector:(Vector3*)vec WithScalar:(float)scalar;
+ (Vector3*)normalizeVector:(Vector3*)vec;
+ (float)magnitudeOf:(Vector3*)vec;

@end
