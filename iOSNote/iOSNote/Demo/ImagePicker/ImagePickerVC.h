//
//  ImagePickerVC.h
//  iOSNote
//
//  Created by wangdong on 16/5/17.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ImagePickerVCDelegate <NSObject>

- (void)hehe;

@end

@interface ImagePickerVC : UIViewController

@property (nonatomic, weak) id<ImagePickerVCDelegate> delegate;

- (instancetype)initWithGroupURL:(NSURL *)assetsGroupUrl;

@end
