//
//  RACMacroTestVC.m
//  iOSNote
//
//  Created by wangdong on 16/7/4.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import "RACMacroTestVC.h"
#import "ReactiveCocoa.h"
#import "RACModalVC.h"

@interface RACMacroTestVC ()

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation RACMacroTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 只要这个对象的属性一改变就会产生信号
//    [RACObserve(self.view, frame) subscribeNext:^(id x) {
//        NSLog(@"%@", x);
//    }];
    
    // 包装元组
    RACTuple *tuple = RACTuplePack(@1, @2);
    NSLog(@"%@", tuple);
    
    [self RAC];
}

- (IBAction)goModalVC:(id)sender
{
    RACModalVC *vc = [RACModalVC new];
    [self presentViewController:vc animated:YES completion:nil];  
}

- (void)RAC
{
    // 监听文本框内容
    [_textField.rac_textSignal subscribeNext:^(id x) {
        _label.text = x;
    }];
    
    // 用来给某个对象的某个属性绑定信号,只要产生信号内容,就会把内容给属性赋值
    RAC(_label, text) = _textField.rac_textSignal;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
