//
//  Vector4.h
//  iPhoneOpenGL
//
//  Created by Christopher Sierigk on 19.08.12.
//  Copyright (c) 2012 Christopher Sierigk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Vector4 : NSObject {
    float mX, mY, mZ, mW;
    
    float mArray[4];
}

@property (nonatomic, assign) float x;
@property (nonatomic, assign) float y;
@property (nonatomic, assign) float z;
@property (nonatomic, assign) float w;
@property (nonatomic, readonly) float* array;

- initWithX:(float)x Y:(float)y Z:(float)z W:(float)w;

@end
