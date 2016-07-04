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
    // 2.方式二:
    
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
