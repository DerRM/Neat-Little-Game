//
//  Test.m
//  Neat Little Game
//
//  Created by Christopher Sierigk on 17.03.12.
//  Copyright (c) 2012 DerRM Productions. All rights reserved.
//

#import "Person.h"

@implementation Person

@synthesize heightInMeters, weightInKilos;

- (float)bodyMassIndex
{
    float h = [self heightInMeters];
    return [self weightInKilos] / (h * h);
}

@end
