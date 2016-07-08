//
//  LoginViewModel.m
//  iOSNote
//
//  Created by wangdong on 16/7/7.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import "LoginViewModel.h"

@implementation LoginViewModel

- (instancetype)init
{
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

//初始化操作
- (void)setup
{
    _loginEnablesignal = [RACSignal combineLatest:@[RACObserve(self, account), RACObserve(self, pwd)] reduce:^id(NSString *account, NSString *pwd) {
        return @(account.length && pwd.length);
    }];
    
    // 处理登录点击命令
    _loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        // block:执行命令就会调用
        // block作用:事件处理
        // 发送登录请求
        NSLog(@"发送登录请求");
        
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            // 发送数据
            [subscriber sendNext:@"请求登录的数据"];
            [subscriber sendCompleted];
            return nil;
        }];
    }];
    
    // 处理登录的请求返回的结果
    // 获取命令中信号源
    [_loginCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    
    // 监听命令执行过程
    [[_loginCommand.executing skip:1] subscribeNext:^(id x) {
        if ([x boolValue] == YES) {
            //正在执行
            NSLog(@"正在执行");
            //显示蒙版
//            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        } else {
            // 执行完成
            NSLog(@"执行完成");
            // 显示蒙版
//            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
    }];
    
    
}

@end
