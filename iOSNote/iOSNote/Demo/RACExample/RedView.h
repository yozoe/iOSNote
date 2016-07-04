//
//  RedView.h
//  iOSNote
//
//  Created by wangdong on 16/7/1.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReactiveCocoa.h"

@interface RedView : UIView

@property (nonatomic, strong) RACSubject *btnClickSignal;

@end
