//
//  GDPrepareViewController.h
//  iOSNote
//
//  Created by wangdong on 2017/1/7.
//  Copyright © 2017年 yozoe. All rights reserved.
//

#import "GDListTableViewController.h"

@interface GDPrepareViewController : GDListTableViewController <UIActionSheetDelegate>

@property (nonatomic, strong) UIActionSheet *clearConfirmActionSheet;

@end
