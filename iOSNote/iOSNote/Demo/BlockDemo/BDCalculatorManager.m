//
//  BDCalculatorManager.m
//  iOSNote
//
//  Created by 王东 on 2016/11/23.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import "BDCalculatorManager.h"

@implementation BDCalculatorManager

- (void)calculator:(NSInteger (^)(NSInteger))calculatorBlock
{
    if (calculatorBlock) {
        _result = calculatorBlock(_result);
    }
}

@end
