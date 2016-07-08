//
//  RACFilterTestVC.m
//  iOSNote
//
//  Created by wangdong on 16/7/6.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import "RACFilterTestVC.h"
#import "ReactiveCocoa.h"

@interface RACFilterTestVC ()

@end

@implementation RACFilterTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor grayColor];
    
    RACSubject *subject = [RACSubject subject];
    [[subject skip:2] subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    
    [subject sendNext:@"1"];
    [subject sendNext:@"2"];
    [subject sendNext:@"3"];
}

- (void)distincUntilChanged
{
    // distinctUntilChanged:如果当前的值跟上一个值相同,就不会被订阅
    RACSubject *subject = [RACSubject subject];
    
    [[subject distinctUntilChanged] subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    
    [subject sendNext:@"1"];
    [subject sendNext:@"2"];
}

- (void)take
{
    // 1.创建信号:
    RACSubject *subject = [RACSubject subject];
    
    RACSubject *signal = [RACSubject subject];
    
    // take取前面几个值
    //    [[subject take:2] subscribeNext:^(id x) {
    //        NSLog(@"%@", x);
    //    }];
    //
    // takeLast取后面几个值,必须要发送完成
    //    [[subject takeLast:2] subscribeNext:^(id x) {
    //        NSLog(@"%@", x);
    //    }];
    
    
    // takeUntil:只要传入信号发送完成或者发送任意数据,就不会再接收源信号的内容
    [[subject takeUntil:signal] subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    
    [subject sendNext:@"1"];
    
    //    只要传入信号发送完成或者发送任意数据,就不会再接收源信号的内容
    //    [signal sendNext:@1];
    //    [subject sendCompleted];
    
    // 除了这个
    //    [signal sendError:nil];
    
    [subject sendNext:@"2"];
    [subject sendNext:@"3"];
    //    [subject sendCompleted];
}

- (void)ignore
{
    // ignore:忽略一些值
    
    // 1.创建信号:
    RACSubject *subject = [RACSubject subject];
    
    // 2.忽略一些
    //    RACSignal *ignoreSignal = [subject ignore:@"1"];
    RACSignal *ignoreSignal = [subject ignoreValues];
    
    [ignoreSignal subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    
    // 4.发送数据
    [subject sendNext:@"13"];
    [subject sendNext:@"2"];
    [subject sendNext:@"44"];
}

- (void)filter
{
    // 只有当我们文本框的内容长度大渔5,才想要获取文本框的内容
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(100, 100, 100, 50)];
    textField.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:textField];
    [[textField.rac_textSignal filter:^BOOL(id value) {
        // value:源信号内容
        return [value length] > 5;
    }] subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
