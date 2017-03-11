//
//  MasonryDemoVCViewController.h
//  iOSNote
//
//  Created by wangdong on 2017/2/26.
//  Copyright © 2017年 yozoe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalculateManager.h"

@interface MasonryDemoVCViewController : UIViewController

- (int)xmg_makeCalculate:(void(^)(CalculateManager *manager))block;

@end
