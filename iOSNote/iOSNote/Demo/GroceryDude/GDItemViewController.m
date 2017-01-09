//
//  GDItemViewController.m
//  iOSNote
//
//  Created by wangdong on 2017/1/8.
//  Copyright © 2017年 yozoe. All rights reserved.
//

#import "GDItemViewController.h"

@interface GDItemViewController ()

@end

@implementation GDItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self hideKeyboardWhenBackgroundIsTapped];
}

- (IBAction)done:(id)sender
{
    [self hideKeyboard];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)hideKeyboardWhenBackgroundIsTapped
{
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [tgr setCancelsTouchesInView:NO];
    [self.view addGestureRecognizer:tgr];
}

- (void)hideKeyboard
{
    [self.view endEditing:YES];
}

@end
