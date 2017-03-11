//
//  CalculateManager.h
//  iOSNote
//
//  Created by wangdong on 2017/2/26.
//  Copyright © 2017年 yozoe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculateManager : NSObject

@property (nonatomic, assign) int result;

- (CalculateManager *(^)(int))add;

@end
