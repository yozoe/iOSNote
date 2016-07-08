//
//  RACMapTestVC.m
//  iOSNote
//
//  Created by wangdong on 16/7/6.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import "RACMapTestVC.h"
#import "ReactiveCocoa.h"
#import "RACReturnSignal.h"

@interface RACMapTestVC ()

@end

@implementation RACMapTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    RACSubject *signalOfSignals = [RACSubject subject];
    RACSubject *signal = [RACSubject subject];
    
    // 订阅信号
//    [signalOfSignals subscribeNext:^(RACSignal *x) {
//        [x subscribeNext:^(id x) {
//            NSLog(@"%@", x);
//        }];
//    }];
    
//    RACSignal *bindSignal = [signalOfSignals flattenMap:^RACStream *(id value) {
//        // 源信号发送内容
//        return value;
//    }];
//    
//    [bindSignal subscribeNext:^(id x) {
//        NSLog(@"%@", x);
//    }];
    
    [[signalOfSignals flattenMap:^RACStream *(id value) {
        return value;
    }] subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];;
    
    // 发送信号
    [signalOfSignals sendNext:signal];
    [signal sendNext:@"213"];
}

- (void)map
{
    RACSubject *subject = [RACSubject subject];
    
    RACSignal *bindSignal = [subject map:^id(id value) {
        
        // 返回的类型,就是你要映射的值
        
        return [NSString stringWithFormat:@"xmg:%@", value];
        
    }];
    
    [bindSignal subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    
    [subject sendNext:@"123"];
    [subject sendNext:@"321"];
}

// 用于信号中的信号
- (void)flattenMap
{
    RACSubject *subject = [RACSubject subject];
    
    RACSignal *bindSignal = [subject flattenMap:^RACStream *(id value) {
        // block:只要源信号发送内容就会调用
        // value:就是元信号发送内容
        // 返回信号用来包装成修改内容值
        
        value = [NSString stringWithFormat:@"xmg:%@", value];
        
        return [RACReturnSignal return:value];
    }];
    
    // 绑定信号中返回的是什么信号,订阅的就是什么信号
    
    // 订阅信号
    [bindSignal subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    
    [subject sendNext:@123];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
