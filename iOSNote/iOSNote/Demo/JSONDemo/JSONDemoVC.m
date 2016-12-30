//
//  JSONDemoVC.m
//  iOSNote
//
//  Created by wangdong on 2016/12/8.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import "JSONDemoVC.h"
#import <MJExtension.h>

@implementation User
@end
@implementation Status
@end

@interface JSONDemoVC ()

@end

@implementation JSONDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary *dict = @{
                           @"text" : @"Agree!Nice weather!",
                           @"users" : @[@{
                                            @"name" : @"Jack",
                                            @"icon" : @"lufy.png"
                                            },@{
                                            @"name" : @"Jack",
                                            @"icon" : @"lufy.png"
                                            },@{
                                            @"name" : @"Jack",
                                            @"icon" : @"lufy.png"
                                            },@{
                                            @"name" : @"Jack",
                                            @"icon" : @"lufy.png"
                                            }],
                           @"retweetedStatus" : @{@"text" : @"Nice weather!",}
                           };
    
    [Status mj_setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"users" : @"User",
                 };
    }];
    
    Status *status = [Status mj_objectWithKeyValues:dict];
    
    NSDictionary *stuDict = status.mj_keyValues;
    NSLog(@"%@", stuDict);
}

@end
