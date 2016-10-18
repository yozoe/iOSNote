//
//  RACBookSearchVC.m
//  iOSNote
//
//  Created by wangdong on 16/7/23.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import "RACBookSearchVC.h"
#import "RACBookSearchVM.h"
#import "RACBookListVC.h"
#import "MBProgressHUD.h"

@interface RACBookSearchVC ()

@property (weak, nonatomic) IBOutlet UITextField *searchtTextField;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (strong, nonatomic) RACBookSearchVM *viewModel;
@property (strong, nonnull) id<RACSubscriber> sub;

@end

@implementation RACBookSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self bindViewModel];
    
    
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//        self.sub = subscriber;
        [subscriber sendNext:@"1"];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"disposable");
        }];
    }];
    
    [[signal subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }] dispose];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)bindViewModel
{
    self.viewModel = [RACBookSearchVM new];
    
    RAC(self.viewModel, searchText) = self.searchtTextField.rac_textSignal;
    
    @weakify(self);
    [[_searchButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [[self.viewModel.executeSearch execute:nil] subscribeNext:^(id x) {
            RACBookListVC *vc = [[RACBookListVC alloc] initWithData:x];
            [self.navigationController pushViewController:vc animated:YES];
        }];
    }];
}

@end
