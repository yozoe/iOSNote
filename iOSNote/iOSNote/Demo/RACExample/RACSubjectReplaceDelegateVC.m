//
//  RACSubjectReplaceDelegateVC.m
//  iOSNote
//
//  Created by wangdong on 16/7/1.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import "RACSubjectReplaceDelegateVC.h"
#import "RACRedView.h"
#import "ReactiveCocoa.h"
#import "NSObject+RACKVOWrapper.h"

@interface RACSubjectReplaceDelegateVC ()

@property (weak, nonatomic) IBOutlet RACRedView *redView;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation RACSubjectReplaceDelegateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 2.代替KVO
    [_redView rac_observeKeyPath:@"frame" options:NSKeyValueObservingOptionNew observer:nil block:^(id value, NSDictionary *change, BOOL causedByDealloc, BOOL affectedOnlyLastComponent) {
        //
        
    }];
    
    [[_redView rac_valuesForKeyPath:@"frame" observer:nil] subscribeNext:^(id x) {
        // x:修改的值
        NSLog(@"%@", x);
    }];
    
    [_redView rac_observeKeyPath:@"bounds" options:NSKeyValueObservingOptionNew observer:nil block:^(id value, NSDictionary *change, BOOL causedByDealloc, BOOL affectedOnlyLastComponent) {
        //
        
    }];
    
    // 3.监听事件
    [[_btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"按钮点击");
    }];
    
    // 4.代替通知
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification object:nil] subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    
    // 5.监听文本框
    [[_textField rac_textSignal] subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
}

- (void)subject
{
    // 订阅信号
    [_redView.btnClickSignal subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
}

- (void)delegate
{
    // 1.代替delegates
    // 把控制器调用didReceiveMemoryWarning转换成信号
    // rac_signalForSelector:监听某对象有没有调用方法
    [[self rac_signalForSelector:@selector(didReceiveMemoryWarning)] subscribeNext:^(id x) {
        NSLog(@"控制器调用didReceiveMemoryWarning");
    }];
    
    // 只要传值,就必须使用RACSubject
    [[_redView rac_signalForSelector:@selector(btnClick:)] subscribeNext:^(id x) {
        NSLog(@"控制器知道按钮被店家");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    _redView.frame = CGRectMake(50, 50, 200, 200);
}

@end
