//
//  RequestViewModel.h
//  iOSNote
//
//  Created by wangdong on 16/7/8.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"

@interface RequestViewModel : NSObject

@property (nonatomic, strong, readonly) RACCommand *requestCommand;

@end
