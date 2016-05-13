//
//  TransitionDemoSecVC.m
//  iOSNote
//
//  Created by wangdong on 16/5/13.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import "TransitionDemoSecVC.h"
#import "TDTransitionFromSecToFir.h"
#import "TransitionDemoVC.h"

@interface TransitionDemoSecVC () <UINavigationControllerDelegate>

@end

@implementation TransitionDemoSecVC

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (self.navigationController.delegate == self) {
        self.navigationController.delegate = nil;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%s", __FUNCTION__);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC
{
    if (fromVC == self && [toVC isKindOfClass:[TransitionDemoSecVC class]]) {
        return [[TDTransitionFromSecToFir alloc] init];
    }
    return nil;
}

@end
