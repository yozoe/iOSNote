//
//  CalculateManager.m
//  iOSNote
//
//  Created by wangdong on 2017/2/26.
//  Copyright © 2017年 yozoe. All rights reserved.
//

#import "CalculateManager.h"

@implementation CalculateManager

- (CalculateManager *(^)(int))add
{
    return ^(int value) {
        _result += value;
        return self;
    };
}

@end
