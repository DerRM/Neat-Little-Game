//
//  Matrix3.m
//  iPhoneOpenGL
//
//  Created by Christopher Sierigk on 19.08.12.
//  Copyright (c) 2012 Christopher Sierigk. All rights reserved.
//

#import "Matrix3.h"

@implementation Matrix3

@synthesize m11, m12, m13;
@synthesize m21, m22, m23;
@synthesize m31, m32, m33;

-(float*)array {
    mArray[0] = m11;
    mArray[1] = m21;
    mArray[2] = m31;
    
    mArray[3] = m12;
    mArray[4] = m22;
    mArray[5] = m32;
    
    mArray[6] = m13;
    mArray[7] = m23;
    mArray[8] = m33;
    
    return mArray;
}

- (void)dealloc
{
    [super dealloc];
}

@end
