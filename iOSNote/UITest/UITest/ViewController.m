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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    self.label.text = @"SDK垃圾;绿壳蛋鸡是否卡德罗斯;几分撒发就看电视了;氨分解啊水电费考虑时间阿坤;东街口啦圣诞节";
    self.label.text = @"S";
}

@end
