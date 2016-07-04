//
//  RACSignalTestVC.m
//  iOSNote
//
//  Created by wangdong on 16/7/1.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import "RACSignalTestVC.h"
#import "ReactiveCocoa.h"

@interface RACSignalTestVC()

@property (nonatomic, strong) id<RACSubscriber> subscriber;

@end

@implementation RACSignalTestVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // RACSignal:有数据产生的时候,就使用 RACSignal
    // RACSignal使用步骤: 1.创建信号 2.订阅信号 3.发送信号
    
    RACDisposable *(^didSubscribe)(id<RACSubscriber> subscriber) = ^RACDisposable *(id<RACSubscriber> subscriber) {
        
        // didSubscribe调用:只要一个信号被订阅就会调用
        // didSubscribe作用:发送数据
        // 3.发送数据
        
        _subscriber = subscriber;
        
        NSLog(@"信号被订阅");
        
        [subscriber sendNext:@1];
        
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"取消订阅");
        }];
    };
    
    // 1.创建信号,默认是冷信号
    RACSignal *signal = [RACSignal createSignal:didSubscribe];
    
    // 2.订阅信号(热信号)
    RACDisposable * disposable = [signal subscribeNext:^(id x) {
        
        // nextBlock调用:只要订阅者发送数据就会被调用
        // nextBlock作用:处理数据,展示到UI上面
        // x:信号发送的内容
        NSLog(@"%@", x);
    }];
    
    // 只要订阅者调用sendNext,就会执行nextBlock
    // 只要信号被订阅,就会执行didSubscribe
    // 前提条件是RACDynamicSignal,不同类型的订阅,处理订阅的事情不一样
    // 默认一个信号发送数据完毕就会主动取消订阅.
    // 只要订阅者在,就不会自动取消信号订阅

    // 取消订阅号
    [disposable dispose];
}

@end
