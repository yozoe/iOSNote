//
//  RACConcatTestVC.m
//  iOSNote
//
//  Created by wangdong on 16/7/6.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import "RACConcatTestVC.h"
#import "ReactiveCocoa.h"

@interface RACConcatTestVC ()

@end

@implementation RACConcatTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    
    UITextField *accountField = [[UITextField alloc] initWithFrame:CGRectMake(100, 100, 100, 50)];
    accountField.backgroundColor = [UIColor whiteColor];
    
    UITextField *pwdField = [[UITextField alloc] initWithFrame:CGRectMake(100, 160, 100, 50)];
    pwdField.backgroundColor = [UIColor whiteColor];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    loginBtn.frame = CGRectMake(100, 210, 100, 50);
    [loginBtn setTitle:@"btn" forState:UIControlStateNormal];
    loginBtn.enabled = NO;
    
    [self.view addSubview:accountField];
    [self.view addSubview:pwdField];
    [self.view addSubview:loginBtn];
    
    // 组合
    // 组合哪些信号
    // reduce:聚合
    
    // reduceBlock参数:跟组合的信号有关,一一对应
    RACSignal *combineSignal = [RACSignal combineLatest:@[accountField.rac_textSignal, pwdField.rac_textSignal] reduce:^id (NSString *account, NSString *pwd) {
        // block:只要源信号发送内容就会调用,组合成新一个值
        NSLog(@"%@ %@", account, pwd);
        // 聚合的值就是组合信号的内容
        return @(account.length && pwd.length);
    }];
    
    [combineSignal subscribeNext:^(id x) {
        loginBtn.enabled = [x boolValue];
    }];
}

- (void)zip
{
    // 夫妻关系,两个同时在才能做一些事情
    RACSubject *signalA = [RACSubject subject];
    
    RACSubject *signalB = [RACSubject subject];
    
    // 压缩成一个信号
    // zipWith:当一个界面多个请求的时候,要等所有请求完成才能更新UI
    // zipWith:等所有信号都发送内容的时候才会调用
    RACSignal *zipSignal = [signalA zipWith:signalB];
    
    [zipSignal subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    
    [signalB sendNext:@2];
    [signalA sendNext:@1];
}

// 任意一个信号请求完成都会订阅到
- (void)merge
{
    RACSubject *signalA = [RACSubject subject];
    
    RACSubject *signalB = [RACSubject subject];
    
    // 组合信号
    RACSignal *mergeSignal = [signalA merge:signalB];
    
    // 订阅信号
    [mergeSignal subscribeNext:^(id x) {
        // 任意一个信号发送内容都会来这个个block
        NSLog(@"%@", x);
    }];
    
    [signalB sendNext:@"下部分"];
    [signalA sendNext:@"上部分"];
}

- (void)then
{
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"发送上部分请求");
        [subscriber sendNext:@"上部分数据"];
        
        [subscriber sendCompleted];
        
        return nil;
    }];
    
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"发送下部分请求");
        [subscriber sendNext:@"下部分数据"];
        return nil;
    }];
    
    // 创建组合信号
    RACSignal *thenSignal = [signalA then:^RACSignal *{
        return signalB;
    }];
    
    // 订阅信号
    [thenSignal subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
}

- (void)concat
{
    // 组合
    // concat:皇上驾崩了,皇太子才好使
    // 创建信号A
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"发送上部分请求");
        [subscriber sendNext:@"上部分数据"];
        
        [subscriber sendCompleted];
        
        return nil;
    }];
    
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"发送下部分请求");
        [subscriber sendNext:@"下部分数据"];
        return nil;
    }];
    
    // concat:按顺序去连接
    // 注意:concat,第一个信号必须要调用sendCompleted
    // 创建组合信号
    RACSignal *concatSignal = [signalA concat:signalB];
    
    // 订阅组合信号
    [concatSignal subscribeNext:^(id x) {
        // 即能拿到A信号的值,又能拿到B信号的值
        NSLog(@"%@", x);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
