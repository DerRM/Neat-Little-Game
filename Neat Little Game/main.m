//
//  main.m
//  Neat Little Game
//
//  Created by Christopher Sierigk on 17.03.12.
//  Copyright (c) 2012 Smart Mobile Factory. All rights reserved.
//

#import "StockHolding.h"

int main(int argc, char *argv[])
{
    @autoreleasepool {
        
        StockHolding *stock1 = [[StockHolding alloc] init];
        StockHolding *stock2 = [[StockHolding alloc] init];
        StockHolding *stock3 = [[StockHolding alloc] init];

        [stock1 setPurchaseSharePrice:2.3];
        [stock1 setCurrentSharePrice:4.5];
        [stock1 setNumberOfShares:40];
        
        [stock2 setPurchaseSharePrice:12.19];
        [stock2 setCurrentSharePrice:10.56];
        [stock2 setNumberOfShares:90];
        
        [stock3 setPurchaseSharePrice:45.10];
        [stock3 setCurrentSharePrice:49.51];
        [stock3 setNumberOfShares:210];
        
        NSMutableArray *stocks = [NSMutableArray array];
        [stocks addObject:stock1];
        [stocks addObject:stock2];
        [stocks addObject:stock3];
        
        for (StockHolding *stock in stocks) {
            float p = [stock costInDollars];
            float c = [stock valueInDollars];
            NSLog(@"%f %f", p, c);
        }
        
    }
    
    return 0;
}
