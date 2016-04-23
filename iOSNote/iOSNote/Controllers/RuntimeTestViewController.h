//
//  RuntimeTestViewController.h
//  iOSNote
//
//  Created by wangdong on 16/4/23.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RuntimeTestObject : NSObject

- (void)test;

@end

@interface RuntimeTestViewController : UIViewController

@property (nonatomic, strong) UIButton *button;

@end
