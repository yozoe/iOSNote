//
//  BDCalculatorManager.h
//  iOSNote
//
//  Created by 王东 on 2016/11/23.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BDCalculatorManager : NSObject

@property (nonatomic, assign) NSInteger result;

- (void)calculator:(NSInteger(^)(NSInteger))calculatorBlock;

@end
