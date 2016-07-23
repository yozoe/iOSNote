//
//  RACMulticastConnectionTestVC.m
//  iOSNote
//
//  Created by wangdong on 16/7/4.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import "RACMulticastConnectionTestVC.h"
#import "ReactiveCocoa.h"

@interface RACMulticastConnectionTestVC ()

@end

@implementation RACMulticastConnectionTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    // 每次订阅不要都请求一次,只想请求一次,每次订阅只要拿到数据
    // 不管订阅多少次信号,就会请求一次
    // RACMulticastConnection:必须要有信号
    
    // 1.创建信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"发送热门模块的请求");
        [subscriber sendNext:@"热门模块的数据"];
        return nil;
    }];
    
    // 2.把型号转换成连接类
    RACMulticastConnection *connection = [signal publish];
   
    // 3.订阅连接类信号
    [connection.signal subscribeNext:^(id x) {
        NSLog(@"订阅者一:%@", x);
    }];
    
    [connection.signal subscribeNext:^(id x) {
        NSLog(@"订阅者一:%@", x);
    }];
    
    [connection.signal subscribeNext:^(id x) {
        NSLog(@"订阅者一:%@", x);
    }];
    
    // 4.连接
    [connection connect];
}

- (void)requestBug
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"发送热门模块的请求");
        [subscriber sendNext:@1];
        return nil;
    }];
    
    [signal subscribeNext:^(id x) {
        NSLog(@"订阅者一%@", x);
    }];
    
    [signal subscribeNext:^(id x) {
        NSLog(@"订阅者二%@", x);
    }];
    
    //发送一次就行, 不用重复发送请求
    
    //发送热门请求
    //订阅者一
    //发送热门请求
    //订阅者二
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
