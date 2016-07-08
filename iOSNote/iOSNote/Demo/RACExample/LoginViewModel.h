//
//  LoginViewModel.h
//  iOSNote
//
//  Created by wangdong on 16/7/7.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"

@interface LoginViewModel : NSObject

// 保存登录界面的帐号和密码
@property (nonatomic, strong) NSString *account;
@property (nonatomic, strong) NSString *pwd;

// 处理登录按钮是否允许点击
@property (nonatomic, strong, readonly) RACSignal *loginEnablesignal;

// 登录按钮命令
@property (nonatomic, strong) RACCommand *loginCommand;

@end
