//
//  RACMVVMLoginVC.m
//  iOSNote
//
//  Created by wangdong on 16/7/7.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import "RACMVVMLoginVC.h"
#import "ReactiveCocoa.h"
#import "MBProgressHUD.h"
#import "LoginViewModel.h"

@interface RACMVVMLoginVC ()

@property (weak, nonatomic) IBOutlet UITextField *accountField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (nonatomic, strong) LoginViewModel *loginVM;

@end

@implementation RACMVVMLoginVC

- (LoginViewModel *)loginVM
{
    if (_loginVM == nil) {
        _loginVM = [[LoginViewModel alloc] init];
    }
    return _loginVM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // MVVM:先创建VM模型,把整个界面的一些业务逻辑处理完
    // 回到控制器
    // VM:视图模型,处理界面上所有业务逻辑
    
    // 每一个控制器对应一个VM模型
    // VM:最好不要包括视图V
    
    [self bindViewModel];
    
    // 1.处理文本框业务逻辑
//    RACSignal *loginEnableSignal = [RACSignal combineLatest:@[_accountField.rac_textSignal, _pwdField.rac_textSignal] reduce:^id(NSString *account, NSString *pwd) {
//        return @(account.length && pwd.length);
//    }];
    
    // 设置按钮能否点击
//    RAC(_loginBtn, enabled) = loginEnableSignal;
    [self loginEvent];
    
    
}

// 绑定viewModel
- (void)bindViewModel
{
    // 1.给视图模型的帐号和密码绑定信号
    RAC(self.loginVM, account) = _accountField.rac_textSignal;
    RAC(self.loginVM, pwd) = _pwdField.rac_textSignal;
}

// 登录事件
- (void)loginEvent
{
    // 1.处理文本框业务逻辑
    RAC(_loginBtn, enabled) = _loginVM.loginEnablesignal;
    
    [[_loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"点击登录按钮");
        //处理登录事件
        [self.loginVM.loginCommand execute:nil];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
