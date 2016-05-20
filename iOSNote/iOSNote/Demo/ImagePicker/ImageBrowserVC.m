//
//  ImageBrowserVC.m
//  iOSNote
//
//  Created by wangdong on 16/5/18.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import "ImageBrowserVC.h"
#import "ImagePickerUploadButton.h"

@interface ImageBrowserVC ()

@property (nonatomic, strong) ImagePickerUploadButton *uploadButton;
@property (nonatomic, strong) UIButton *actionSelectButton;

@end

@implementation ImageBrowserVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self setAlignLeftButtonTitle:@"back"];
}

- (void)setAlignLeftButtonTitle:(NSString *)title
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [button setTitleColor:ORANGE_CLICK_COLOR forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize:17];
    button.titleLabel.textAlignment = NSTextAlignmentLeft;
    [button addTarget:self action:@selector(leftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//    CGFloat width = [title pp_sizeWithFont:button.titleLabel.font].width;
    button.frame = CGRectMake(0, 0, 50, 30);
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -6;
    self.navigationItem.leftBarButtonItems = @[negativeSpacer, leftItem];
}

- (void)leftButtonAction:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(result)]) {
        [self.delegate performSelector:@selector(result) withObject:nil];
    }
    [self.navigationController popViewControllerAnimated:YES];
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
        _actionSelectButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        [_actionSelectButton setImage:[UIImage imageNamed:@"selecte"] forState:UIControlStateNormal];
        [_actionSelectButton setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateSelected];
        [_actionSelectButton addTarget:self action:@selector(handleActionButtonAction) forControlEvents:UIControlEventTouchUpInside];
        _actionButton = [[UIBarButtonItem alloc] initWithCustomView:_actionSelectButton];
    }
    return _actionButton;
}

- (void)handleActionButtonAction
{
    if ([self.delegate respondsToSelector:@selector(photoBrowser:actionButtonPressedForPhotoAtIndex:)]) {
        [self.delegate photoBrowser:self actionButtonPressedForPhotoAtIndex:self.currentIndex];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)addCustomItemsFromItemsArray:(NSMutableArray *)items
{
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *item3 = [[UIBarButtonItem alloc] initWithCustomView:self.uploadButton];
    UIBarButtonItem *item4 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    item4.width = -40;
    [items addObjectsFromArray:@[item1, item3, item4]];
}

- (void)setActionButtonSelected:(BOOL)actionButtonSelected
{
    _actionButtonSelected = actionButtonSelected;
    _actionSelectButton.selected = _actionButtonSelected;
}

@end
