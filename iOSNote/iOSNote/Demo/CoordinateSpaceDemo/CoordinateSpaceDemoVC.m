//
//  CoordinateSpaceDemoVC.m
//  iOSNote
//
//  Created by wangdong on 2017/2/3.
//  Copyright © 2017年 yozoe. All rights reserved.
//

#import "CoordinateSpaceDemoVC.h"

@interface CoordinateSpaceDemoVC ()
@property (weak, nonatomic) IBOutlet UIView *v1;
@property (weak, nonatomic) IBOutlet UIView *v2;
@property (weak, nonatomic) IBOutlet UIView *v3;
@property (weak, nonatomic) IBOutlet UILabel *defaultFrameLabel;
@property (weak, nonatomic) IBOutlet UILabel *relativeParentLabel;

@end

@implementation CoordinateSpaceDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _defaultFrameLabel.text = [NSString stringWithFormat:@"v1:%@\nv2:%@\nv3:%@", NSStringFromCGRect(self.v1.frame), NSStringFromCGRect(self.v2.frame), NSStringFromCGRect(self.v3.frame)];
    
    CGRect test1 = [self.v2 convertRect:self.v2.frame toView:self.view];
    CGRect test2 = [self.v2 convertRect:self.v2.frame fromView:self.view];
    CGRect test3 = [self.view convertRect:self.v2.frame toView:self.view];
    CGRect test4 = [self.view convertRect:self.v2.frame fromView:self.view];
    
    NSLog(@"%@", NSStringFromCGRect(test1));
    NSLog(@"%@", NSStringFromCGRect(test2));
    NSLog(@"%@", NSStringFromCGRect(test3));
    NSLog(@"%@", NSStringFromCGRect(test4));
}

@end
