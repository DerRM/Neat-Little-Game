//
//  Vector4.m
//  iPhoneOpenGL
//
//  Created by Christopher Sierigk on 19.08.12.
//  Copyright (c) 2012 Christopher Sierigk. All rights reserved.
//

#import "Vector4.h"

@implementation Vector4

@synthesize x = mX;
@synthesize y = mY;
@synthesize z = mZ;
@synthesize w = mW;

- (id)init {
    self = [super init];
    
    if (self) {
        mX = 0.0f;
        mY = 0.0f;
        mZ = 0.0f;
        mW = 0.0f;
    }
    
    return self;
}

- (id)initWithX:(float)x Y:(float)y Z:(float)z W:(float)w{
    self = [super init];
    
    if (self) {
        mX = x;
        mY = y;
        mZ = z;
        mW = w;
    }
    return self;
}

- (float*)array {
    mArray[0] = mX;
    mArray[1] = mY;
    mArray[2] = mZ;
    mArray[3] = mW;
    return mArray;
}

-(void)dealloc {
    [super dealloc];
}

@end
