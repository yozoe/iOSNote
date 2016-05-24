//
//  PlayerListViewController.h
//  CoreDataDemo
//
//  Created by wangdong on 16/5/23.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Team;
@class ViewController;

@interface PlayerListViewController : UIViewController

@property (nonatomic, strong) Team *team;
@property (nonatomic, strong) ViewController *viewController;

@end
