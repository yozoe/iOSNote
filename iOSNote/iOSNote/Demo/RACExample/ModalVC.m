//
//  ModalVC.m
//  iOSNote
//
//  Created by wangdong on 16/7/4.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import "ModalVC.h"
#import "ReactiveCocoa.h"

@interface ModalVC ()

@property (nonatomic, strong) RACSignal *signal;

@end

@implementation ModalVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    @weakify(self);
    
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        NSLog(@"%@", self);
        return nil;
    }];
    
    _signal = signal;
}

- (IBAction)dismiss:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc
{
    NSLog(@"%s", __func__);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
