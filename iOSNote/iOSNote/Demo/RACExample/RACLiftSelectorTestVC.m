//
//  RACLiftSelectorTestVC.m
//  iOSNote
//
//  Created by wangdong on 16/7/4.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import "RACLiftSelectorTestVC.h"
#import "ReactiveCocoa.h"

@interface RACLiftSelectorTestVC ()

@end

@implementation RACLiftSelectorTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    // 当一个界面有多次请求时候,需要保证全部都请求完成,才搭建界面
    
    // 请求热销模块
    RACSignal *hotSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        // 请求数据
        NSLog(@"请求数据热销模块");
        NSLog(@"%@", [NSThread currentThread]);
        [subscriber sendNext:@"热销模块的数据"];
        return nil;
    }];
    
    // 请求最新模块
    RACSignal *newSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"请求最新模块");
        [subscriber sendNext:@"最新模块数据"];
        return nil;
    }];
    
    // 数组:存放信号
    // 当数组中的所有信号都发送数据的时候,才会执行Selector
    // 方法的参数:必须跟数组的信号一一对应
    [self rac_liftSelector:@selector(updateUIWithHotData:newData:) withSignalsFromArray:@[hotSignal, newSignal]];
}

- (void)updateUIWithHotData:(NSString *)hotData newData:(NSString *)newData
{
    // 拿到请求数据
    NSLog(@"更新UI %@ %@", hotData, newData);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
