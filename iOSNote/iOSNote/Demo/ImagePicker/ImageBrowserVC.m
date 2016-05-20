//
//  ImageBrowserVC.m
//  iOSNote
//
//  Created by wangdong on 16/5/18.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import "ImageBrowserVC.h"
#import "ImagePickerUploadButton.h"

@interface ImageBrowserVC () <MWPhotoBrowserDelegate>

@property (nonatomic, strong) ImagePickerUploadButton *uploadButton;

@end

@implementation ImageBrowserVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (ImagePickerUploadButton *)uploadButton
{
    if (!_uploadButton) {
        _uploadButton = [[ImagePickerUploadButton alloc] initWithFrame:CGRectZero];
        [_uploadButton addTaget:self action:@selector(handleUploadButtonAction:)];
    }
    return _uploadButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIBarButtonItem *)actionButton
{
    if (!_actionButton) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        [button setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"selecte"] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(hh) forControlEvents:UIControlEventTouchUpInside];
        _actionButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    }
    return _actionButton;
}

- (void)hh
{
    NSLog(@"hehe");
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.navigationController.toolbarHidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    self.navigationController.toolbarHidden = YES;
}

- (void)addCustomItemsFromItemsArray:(NSMutableArray *)items
{
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *item3 = [[UIBarButtonItem alloc] initWithCustomView:self.uploadButton];
    UIBarButtonItem *item4 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    item4.width = -40;
    [items addObjectsFromArray:@[item1, item3, item4]];

}

@end
