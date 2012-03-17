//
//  Test.h
//  Neat Little Game
//
//  Created by Christopher Sierigk on 17.03.12.
//  Copyright (c) 2012 Smart Mobile Factory. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
{
    float heightInMeters;
    int weightInKilos;
}

@property float heightInMeters;
@property int weightInKilos;

- (float)bodyMassIndex;

@end
