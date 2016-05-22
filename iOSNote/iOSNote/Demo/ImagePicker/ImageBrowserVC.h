//
//  ImageBrowserVC.h
//  iOSNote
//
//  Created by wangdong on 16/5/18.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import "MWPhotoBrowser.h"

@class ImagePickerUploadButton;

@protocol ImageBrowserVCDelegate <MWPhotoBrowserDelegate>

- (void)clickUploadButton;

@end

@interface ImageBrowserVC : MWPhotoBrowser

@property (nonatomic, strong) ImagePickerUploadButton *uploadButton;
@property (nonatomic, weak) id<ImageBrowserVCDelegate> delegate;
@property (nonatomic, assign) BOOL actionButtonSelected;

@end
