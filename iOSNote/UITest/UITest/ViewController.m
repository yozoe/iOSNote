//
//  ViewController.m
//  UITest
//
//  Created by wangdong on 16/7/15.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.


    
}

- (void)test
{
    UIView *redView = [[UIView alloc] init];
    redView.backgroundColor = [UIColor redColor];
    redView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:redView];
    
    
    NSLayoutConstraint *wlcs = [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:100];
    
    [redView addConstraint:wlcs];
    
    
    NSLayoutConstraint *hlcs = [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:100];
    
    [redView addConstraint:hlcs];
    
    NSLayoutConstraint *rlcs = [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:-20];
    
    [self.view addConstraint:rlcs];
    
    
    NSLayoutConstraint *blcs = [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:-20];
    
    [self.view addConstraint:blcs];
    
}

- (void)test1
{
    UIView *blueView = [[UIView alloc] init];
    blueView.backgroundColor = [UIColor blueColor];
    blueView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:blueView];
    
    UIView *redView = [[UIView alloc] init];
    redView.backgroundColor = [UIColor redColor];
    redView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:redView];

    NSLayoutConstraint *leftlcs_b = [NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:30];
    
    [self.view addConstraint:leftlcs_b];
    
    
    
    NSLayoutConstraint *bottomlcs_b = [NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:-30];
    
    [self.view addConstraint:bottomlcs_b];
    
    
    NSLayoutConstraint *rightlcs_b = [NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:redView attribute:NSLayoutAttributeLeft multiplier:1 constant:-30];
    
    [self.view addConstraint:rightlcs_b];
    
    NSLayoutConstraint *wlcs_b = [NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:redView attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
    
    [self.view addConstraint:wlcs_b];
    
    NSLayoutConstraint *hlcs_b = [NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:50];
    
    [blueView addConstraint:hlcs_b];
    
    
    
    
    
    NSLayoutConstraint *rightlcs_r = [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:-30];
    
    [self.view addConstraint:rightlcs_r];
    
    
    
    NSLayoutConstraint *toplcs_r = [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:blueView attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    
    
    [self.view addConstraint:toplcs_r];
    
    NSLayoutConstraint *bottomlcs_r = [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:blueView attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    
    [self.view addConstraint:bottomlcs_r];
}

- (void)test2
{
    UIView *redView = [[UIView alloc] init];
    redView.backgroundColor = [UIColor redColor];
    redView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:redView];
    
    NSString *hvfl = @"H:|-space-[abc]-space-|";
    
    NSDictionary *views = @{@"abc":redView};
    NSDictionary *metrics = @{@"space":@30};
    
    NSArray *hlcs =  [NSLayoutConstraint constraintsWithVisualFormat:hvfl options:kNilOptions metrics:metrics views:views];
    
    
    [self.view addConstraints:hlcs];
    
    NSString *vvfl = @"V:[abc(40)]-space-|";
    
    NSArray *vlcs  =[NSLayoutConstraint constraintsWithVisualFormat:vvfl options:kNilOptions metrics:metrics views:views];
    
    [self.view addConstraints:vlcs];
}

- (void)test3
{
    UIView *blueView = [[UIView alloc] init];
    blueView.backgroundColor = [UIColor blueColor];
    blueView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:blueView];
    
    UIView *redView = [[UIView alloc] init];
    redView.backgroundColor = [UIColor redColor];
    redView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:redView];
    
    //    NSDictionary *views = @{@"abc":redView,@"qwe":blueView};
    
    NSDictionary *views = NSDictionaryOfVariableBindings(redView,blueView);
    
    NSDictionary *metrics = @{@"space":@30};
    
    NSString *hvfl = @"H:|-space-[qwe]-space-[abc(==qwe)]-space-|";
    
    NSArray *hlcs = [NSLayoutConstraint constraintsWithVisualFormat:hvfl options:NSLayoutFormatAlignAllTop | NSLayoutFormatAlignAllBottom metrics:metrics views:views];
    
    [self.view addConstraints:hlcs];
    
    
    NSString *vvfl = @"V:[qwe(50)]-space-|";
    NSArray *vlcs  =[NSLayoutConstraint constraintsWithVisualFormat:vvfl options:kNilOptions metrics:metrics views:views];
    [self.view addConstraints:vlcs];
    
    //    NSLayoutConstraint *toplcs_r = [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:blueView attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    //
    //    [self.view addConstraint:toplcs_r];
    //
    //    NSLayoutConstraint *bottomlcs_r = [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:blueView attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    //
    //    [self.view addConstraint:bottomlcs_r];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    self.label.text = @"SDK垃圾;绿壳蛋鸡是否卡德罗斯;几分撒发就看电视了;氨分解啊水电费考虑时间阿坤;东街口啦圣诞节";
//    self.label.text = @"S";
    
    
    [self.blueView removeFromSuperview];
}

@end
