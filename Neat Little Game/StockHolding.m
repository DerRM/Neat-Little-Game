//
//  StockHolding.m
//  Neat Little Game
//
//  Created by Christopher Sierigk on 17.03.12.
//  Copyright (c) 2012 Smart Mobile Factory. All rights reserved.
//

#import "StockHolding.h"

@implementation StockHolding

@synthesize currentSharePrice, purchaseSharePrice, numberOfShares;

-(float)costInDollars
{
    return [self purchaseSharePrice] * [self numberOfShares];
}

-(float)valueInDollars
{
    return [self currentSharePrice] * [self numberOfShares];
}

@end
