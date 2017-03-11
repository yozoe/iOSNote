//
//  MasonryDemoVCViewController.m
//  iOSNote
//
//  Created by wangdong on 2017/2/26.
//  Copyright © 2017年 yozoe. All rights reserved.
//

#import "MasonryDemoVCViewController.h"
#import <Masonry.h>

@interface MasonryDemoVCViewController ()

@property (nonatomic, strong, readonly) MasonryDemoVCViewController *hehe;
@property (nonatomic, strong, readonly) MasonryDemoVCViewController *haha;

@end

@implementation MasonryDemoVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.equalTo(@10);
//    }];

//    self.hehe;
//    [[self hehe] haha];
//    [[self haha] hehe];
//    self.hehe.haha;
    
    int result = [self xmg_makeCalculate:^(CalculateManager *manager) {
//        manager.add(5).add(5).multy(5).sub(10);
        
        manager.add(5).add(10);
        
    }];
    
    NSLog(@"%d", result);
}

- (int)xmg_makeCalculate:(void (^)(CalculateManager *))block
{
    CalculateManager *manager = [[CalculateManager alloc] init];
    block(manager);
    return manager.result;
}

- (MasonryDemoVCViewController *)hehe
{
    NSLog(@"hehe");
    return self;
}

- (MasonryDemoVCViewController *)haha
{
    NSLog(@"haha");
    return self;
}

@end
