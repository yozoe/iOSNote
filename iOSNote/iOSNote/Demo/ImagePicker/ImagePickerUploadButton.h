//
//  ImagePickerUploadButton.h
//  iOSNote
//
//  Created by wangdong on 16/5/18.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImagePickerUploadButton : UIView

@property (nonatomic, copy) NSString *badgeValue;

- (void)addTaget:(id)target action:(SEL)action;

@end
