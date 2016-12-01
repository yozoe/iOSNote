//
//  BlocksKitDemo.m
//  iOSNote
//
//  Created by wangdong on 2016/11/30.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import "BlocksKitDemo.h"
#import <BlocksKit.h>

@interface BlocksKitDemo ()

@end

@implementation BlocksKitDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [@[@1,@2,@3] bk_each:^(id obj) {
        NSLog(@"%@", obj);
    }];
    
}

@end
