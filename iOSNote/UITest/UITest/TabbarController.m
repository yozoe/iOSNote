//
//  TabbarController.m
//  UITest
//
//  Created by wangdong on 2016/12/7.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import "TabbarController.h"
#import "ViewController1.h"
#import "ViewController2.h"

@interface TabbarController ()

@end

@implementation TabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    ViewController1 *v1 = [[ViewController1 alloc] init];
    v1.view.backgroundColor = [UIColor redColor];
    ViewController2 *v2 = [[ViewController2 alloc] init];
    v2.view.backgroundColor = [UIColor blueColor];
    
    [self setViewControllers:@[v1, v2]];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.selectedIndex = 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
