//
//  RACCommandTestVC.m
//  iOSNote
//
//  Created by wangdong on 16/7/4.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import "RACCommandTestVC.h"
#import "ReactiveCocoa.h"

@interface RACCommandTestVC ()

@end

@implementation RACCommandTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 当前命令内部发送数据完成,一定要主动发送完成
    // 1.创建命令
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        // input:执行命令传入参数
        // block调用:执行命令的时候就会调用
//        NSLog(@"%@", input);
        
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            // 发送数据
            [subscriber sendNext:@"从网络获取的数据"];
            
            // 发送完成
            [subscriber sendCompleted];
            
            return nil;
        }];
    }];
    
    // 监听事件有没有完成
    [command.executing subscribeNext:^(id x) {
        if ([x boolValue] == YES) { // 当前正在执行
            NSLog(@"当前正在执行");
        } else {
            // 执行完成/没有执行
            NSLog(@"执行完成/没有执行");
        }
    }];
    
    // 2.执行命令
    [[command execute:@1] subscribeNext:^(id x) {
        NSLog(@"-->%@", x);
    }];
}

- (void)switchToLatest
{
    // swichToLastest
    
    // 创建信号中信号
    RACSubject *signalOfSignals = [RACSubject subject];
    RACSubject *signalA = [RACSubject subject];
    RACSubject *signalB = [RACSubject subject];
    
    // 订阅信号
    //    [signalOfSignals subscribeNext:^(RACSignal *x) {
    //        [x subscribeNext:^(id x) {
    //            NSLog(@"%@", x);
    //        }];
    //    }];
    
    // switchToLatest:获取信号中信号发送的最新信号
    [signalOfSignals.switchToLatest subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    
    [signalOfSignals sendNext:signalA];
    
    //发送信号
    [signalA sendNext:@1];
    [signalB sendNext:@"BB"];
    [signalA sendNext:@"11"];
}

- (void)executionSignals
{
    // 1.创建命令
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        // input:执行命令传入参数
        // block调用:执行命令的时候就会调用
        NSLog(@"%@", input);
        
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            //发送数据
            [subscriber sendNext:@"执行命令产生的一些数据"];
            
            return nil;
        }];
    }];
    
    // 订阅信号
    // 注意:必须要在执行命令前订阅
    // executionSignals:信号源,信号中的信号,signalOfsignals:信号:发送的数据就是信号
    //    [command.executionSignals subscribeNext:^(RACSignal *x) {
    //        [x subscribeNext:^(id x) {
    //            NSLog(@"%@", x);
    //        }];
    //    }];
    
    // switchToLatest:获取最新发送的信号,只能用于信号中信号
    [command.executionSignals.switchToLatest subscribeNext:^(id x) {
        [x subscribeNext:^(id x) {
            NSLog(@"%@", x);
        }];
    }];
    
    // 2.执行命令
    [command execute:@1];
}

- (void)command
{
    // RACCommand:处理事件
    // RACCommand:不能返回一个空的信号
    
    // 1.创建命令
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        // input:执行命令传入参数
        // block调用:执行命令的时候就会调用
        NSLog(@"%@", input);
        
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            //发送数据
            [subscriber sendNext:@"执行命令产生的一些数据"];
            
            return nil;
        }];
    }];
    
    // 如何拿到执行命令中产生的数据
    // 订阅命令内部的信号
    // 1.方式一:直接订阅执行命令返回的信号
    
    // 2.执行命令
    RACSignal *signal = [command execute:@1];
    
    // 3.订阅信号
    [signal subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
