//
//  RedView.m
//  iOSNote
//
//  Created by wangdong on 16/7/1.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import "RACRedView.h"

@implementation RACRedView

- (RACSubject *)btnClickSignal
{
    if (_btnClickSignal == nil) {
        _btnClickSignal = [RACSubject subject];
    }
    return _btnClickSignal;
}

- (IBAction)btnClick:(id)sender
{
//    NSLog(@"红色的view监听到按钮点击");
    //通知控制器处理
    [self.btnClickSignal sendNext:@"红色按钮被点击"];
}

@end
