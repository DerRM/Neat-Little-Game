//
//  main.m
//  Neat Little Game
//
//  Created by Christopher Sierigk on 17.03.12.
//  Copyright (c) 2012 DerRM Productions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Employee.h"

int main(int argc, char *argv[])
{
    @autoreleasepool {
        
        Employee *person = [[Employee alloc] init];
        
        [person setWeightInKilos:96];
        [person setHeightInMeters:1.8];
        [person setEmployeeID:15];
        
        
    }
    
    return 0;
}
