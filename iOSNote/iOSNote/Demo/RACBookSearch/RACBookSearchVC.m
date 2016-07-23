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

@interface RACBookSearchVC ()

@property (weak, nonatomic) IBOutlet UITextField *searchtTextField;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (strong, nonatomic) RACBookSearchVM *viewModel;

@end

@implementation RACBookSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self bindViewModel];
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
            [self goNextPageWithData:x];
        }];
    }];
}

- (void)goNextPageWithData:(NSArray *)data
{
    RACBookListVC *vc = [[RACBookListVC alloc] initWithData:data];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
