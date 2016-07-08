//
//  RACMVVMNetworkVC.m
//  iOSNote
//
//  Created by wangdong on 16/7/8.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import "RACMVVMRequestVC.h"
#import "AFNetworking.h"
#import "RequestViewModel.h"

@interface RACMVVMRequestVC ()

@property (nonatomic, strong) RequestViewModel *requestVM;

@end

@implementation RACMVVMRequestVC

- (RequestViewModel *)requestVM
{
    if (_requestVM == nil) {
        _requestVM = [[RequestViewModel alloc] init];
    }
    return _requestVM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    https://api.douban.com/v2/book/search
    
    
    
    RACSignal *signal = [self.requestVM.requestCommand execute:nil];
    
    [signal subscribeNext:^(id x) {
        // 模型数组
        NSLog(@"%@", x);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
