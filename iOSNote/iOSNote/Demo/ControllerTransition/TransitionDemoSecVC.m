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
#import "TDModel.h"

@interface TransitionDemoSecVC () <UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *overviewLabel;

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
    
    self.title = self.thing.title;
    self.overviewLabel.text = self.thing.overview;
    self.imageView.image = self.thing.image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC
{
    if (fromVC == self && [toVC isKindOfClass:[TransitionDemoVC class]]) {
        return [[TDTransitionFromSecToFir alloc] init];
    }
    return nil;
}

@end
