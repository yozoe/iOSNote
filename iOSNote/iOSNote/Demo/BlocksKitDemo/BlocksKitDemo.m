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

@property (nonatomic, strong) NSArray *array;

@end

@implementation BlocksKitDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.array = @[@"a",@"b",@"c",@"d"];
    
    NSArray *array = [self.array bk_select:^BOOL(NSString *obj) {
        return ([obj isEqualToString:@"b"] || [obj isEqualToString:@"c"]);
    }];
    
    NSLog(@"%@", array);
    
//    [@[@1,@2,@3] bk_each:^(id obj) {
//        NSLog(@"%@", obj);
//    }];
//    
//    [self.array bk_match:^BOOL(id obj) {
//        NSLog(@"%@", obj);
//        return YES;
//    }];

    
    [self bk_reduce];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self bk_reduce];
}

- (void)bk_reduce
{
    id obj =  [self.array bk_reduce:@"e" withBlock:^id(id sum, id obj) {
        return [NSString stringWithFormat:@"%@ %@", sum,obj];
    }];
    
    NSLog(@"%@", obj);
}

@end
