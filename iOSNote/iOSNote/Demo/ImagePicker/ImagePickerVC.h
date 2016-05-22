//
//  ImagePickerVC.h
//  iOSNote
//
//  Created by wangdong on 16/5/17.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ImagePickerVC;

@protocol ImagePickerVCDelegate <NSObject>

- (void)photoPickerClickUploadButton:(ImagePickerVC *)picker;

@end

@interface ImagePickerVC : UIViewController

@property (nonatomic, weak) id<ImagePickerVCDelegate> delegate;

- (instancetype)initWithGroupURL:(NSURL *)assetsGroupUrl;

@end
