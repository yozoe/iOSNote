//
//  GDListTableViewController.h
//  iOSNote
//
//  Created by wangdong on 2017/1/7.
//  Copyright © 2017年 yozoe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataHelper.h"
#import "Item+CoreDataClass.h"
#import "Unit+CoreDataClass.h"

@interface GDListTableViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *frc;

- (void)performFetch;

@end
