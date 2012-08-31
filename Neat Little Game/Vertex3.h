//
//  Vertex.h
//  iPhoneOpenGL
//
//  Created by Christopher Sierigk on 20.08.12.
//  Copyright (c) 2012 Christopher Sierigk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Vertex3 : NSObject {
    int index;
    GLushort posIndex;
    GLushort normalIndex;
    GLushort texCoordIndex;
}

@property (nonatomic, assign) GLushort posIndex, normalIndex, texCoordIndex;
@property (nonatomic, assign) int index;

@end
