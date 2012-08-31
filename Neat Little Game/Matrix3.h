//
//  Matrix3.h
//  iPhoneOpenGL
//
//  Created by Christopher Sierigk on 19.08.12.
//  Copyright (c) 2012 Christopher Sierigk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Math.h"

@interface Matrix3 : NSObject {
    float m11, m21, m31;
    float m12, m22, m32;
    float m13, m23, m33;
    
    float mArray[9];
}

@property (nonatomic, assign) float m11, m21, m31;
@property (nonatomic, assign) float m12, m22, m32;
@property (nonatomic, assign) float m13, m23, m33;
@property (nonatomic, readonly) float* array;

@end
