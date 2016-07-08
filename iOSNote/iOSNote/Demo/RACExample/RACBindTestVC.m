//
//  RACBindTestVC.m
//  iOSNote
//
//  Created by wangdong on 16/7/5.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import "RACBindTestVC.h"
#import "ReactiveCocoa.h"
#import "RACReturnSignal.h"

@interface RACBindTestVC ()

@end

@implementation RACBindTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 1.创建信号
    RACSubject *subject = [RACSubject subject];
    
    
    // 2.绑定信号
    RACSignal *bindSignal = [subject bind:^RACStreamBindBlock{
        return ^RACSignal *(id value, BOOL *stop) {
            
            // block调用:只要源信号发送数据,就会调用block
            // block作用:处理源信号内容
            // value:源信号发送的内容
            NSLog(@"%@", value);
            
            value = [NSString stringWithFormat:@"xmg:%@", value];
            
            // 返回信号,不能传nil,返回空信号
            return [RACReturnSignal return:value];
        };
    }];
    
    // 3.订阅绑定信号
    [bindSignal subscribeNext:^(id x) {
        NSLog(@"接收到绑定信号处理完的信号%@", x);
    }];
    
    // 4.发送数据
    [subject sendNext:@"123"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
