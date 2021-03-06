//
//  RACTestViewController.m
//  iOSNote
//
//  Created by wangdong on 16/7/1.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import "RACTestVC.h"
#import "RACSignalTestVC.h"
#import "RACSubjectTestVC.h"
#import "RACSubjectReplaceDelegateVC.h"
#import "RACTupleTestVC.h"
#import "RACLiftSelectorTestVC.h"
#import "RACMacroTestVC.h"
#import "RACMulticastConnectionTestVC.h"
#import "RACCommandTestVC.h"
#import "RACBindTestVC.h"
#import "RACMapTestVC.h"
#import "RACConcatTestVC.h"
#import "RACFilterTestVC.h"
#import "RACMVVMLoginVC.h"
#import "RACMVVMRequestVC.h"
#import "RACPlaygourndVC.h"

@interface RACTestVC()
{
    NSArray *_listArray;
}

@end

@implementation RACTestVC

- (instancetype)init
{
    if (self = [super init]) {
        [self initList];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.代替代理:RACSubject
    // 2.代替KVO
    // 3.监听事件
    // 4.代替通知
    // 5.监听文本框
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"RACTestCell"];
}

- (void)initList
{
    _listArray = @[@"RACPlaygroundVC", @"RACSignal", @"RACSubject", @"RACSubjectReplaceDelegate", @"RACTuple", @"RACLiftSelector", @"RACMacro", @"RACMulticastConnection", @"RACCommand", @"RACBindTest", @"RACMapTest", @"RACConcatTest", @"RACFilterTest", @"RACMVVMLoginVC", @"RACMVVMRequestVC"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RACTestCell"];
    cell.textLabel.text = _listArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *vc = nil;
    NSString *title = _listArray[indexPath.row];
    if ([title isEqualToString:@""]) {
        
    }
    else if ([title isEqualToString:@"RACPlaygroundVC"]) {
        vc = [RACPlaygourndVC new];
    }
    else if ([title isEqualToString:@"RACSignal"]) {
        vc = [RACSignalTestVC new];
    } else if ([title isEqualToString:@"RACSubject"]) {
        vc = [RACSubjectTestVC new];
    } else if ([title isEqualToString:@"RACSubjectReplaceDelegate"]) {
        vc = [[RACSubjectReplaceDelegateVC alloc] initWithNibName:@"RACSubjectReplaceDelegateVC" bundle:nil];
    } else if ([title isEqualToString:@"RACTuple"]) {
        vc = [RACTupleTestVC new];
    } else if ([title isEqualToString:@"RACLiftSelector"]) {
        vc = [RACLiftSelectorTestVC new];
    } else if ([title isEqualToString:@"RACMacro"]) {
        vc = [RACMacroTestVC new];
    } else if ([title isEqualToString:@"RACMulticastConnection"]) {
        vc = [RACMulticastConnectionTestVC new];
    } else if ([title isEqualToString:@"RACCommand"]) {
        vc = [RACCommandTestVC new];
    } else if ([title isEqualToString:@"RACBindTest"]) {
        vc = [RACBindTestVC new];
    } else if ([title isEqualToString:@"RACMapTest"]) {
        vc = [RACMapTestVC new];
    } else if ([title isEqualToString:@"RACConcatTest"]) {
        vc = [RACConcatTestVC new];
    } else if ([title isEqualToString:@"RACFilterTest"]) {
        vc = [RACFilterTestVC new];
    } else if ([title isEqualToString:@"RACMVVMLoginVC"]) {
        vc = [RACMVVMLoginVC new];
    } else if ([title isEqualToString:@"RACMVVMRequestVC"]) {
        vc = [RACMVVMRequestVC new];
    }
    [self.navigationController pushViewController:vc animated:YES];
}

@end
