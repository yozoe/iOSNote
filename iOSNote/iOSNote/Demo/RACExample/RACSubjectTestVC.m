//
//  RACSubjectTestVC.m
//  iOSNote
//
//  Created by wangdong on 16/7/1.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import "RACSubjectTestVC.h"
#import "ReactiveCocoa.h"

@implementation RACSubjectTestVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self RACSubject];
}

- (void)RACReplaySubject
{
    // 1.创建信号
    RACReplaySubject *subject = [RACReplaySubject subject];
    
    // 3.发送信号
    [subject sendNext:@1];
    
    // 2.订阅信号
    [subject subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    // 遍历所有的值,拿到当前订阅者去发送数据
    
    // RACReplaySubject发送数据
    // 1.保存值
    // 2.遍历所有的订阅者,发送数据
    
    // RACReplaySubject:可以先发送数据,在订阅信号
}

- (void)RACSubject
{
    // 1.创建信号
    RACSubject *subject = [RACSubject subject];
    
    // 2.订阅信号
    
    // 不同型号订阅的方式不一样
    // RACSubject处理订阅:仅仅是保存订阅者
    [subject subscribeNext:^(id x) {
        NSLog(@"订阅者1接收到的数据:%@", x);
    }];
    [subject subscribeNext:^(id x) {
        NSLog(@"订阅者2接收到的数据:%@", x);
    }];
    // 保存订阅者
    
    // 3.发送数据
    [subject sendNext:@1];
    //底层实现:遍历所有的订阅者,调用nextBLock
    
    // 执行流程
    
    // RACSubject被订阅,仅仅是保存订阅者
    // RACSubject发送数据,便利所有的订阅,调用他们的nextBlock
}

@end
