//
//  Flag.m
//  iOSNote
//
//  Created by wangdong on 16/7/1.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import "RACFlag.h"

@implementation RACFlag

+ (instancetype)flagWithDict:(NSDictionary *)dict
{
    RACFlag *flag = [[self alloc] init];
    [flag setValuesForKeysWithDictionary:dict];
    return flag;
}

@end
