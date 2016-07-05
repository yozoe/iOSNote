//
//  RACTupleTestVC.m
//  iOSNote
//
//  Created by wangdong on 16/7/1.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import "RACTupleTestVC.h"
#import "ReactiveCocoa.h"
#import "RACFlag.h"

@interface RACTupleTestVC ()

@end

@implementation RACTupleTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray *dictArr = @[@{@"name":@"China",@"icon":@"china.jpg"},
                     @{@"name":@"Japan",@"icon":@"japan.jpg"},
                     @{@"name":@"USA",@"icon":@"usa.jpg"}];
    
//    NSMutableArray *arr = [[NSMutableArray alloc] init];
//    
//    [dictArr.rac_sequence.signal subscribeNext:^(NSDictionary *x) {
//        Flag *flag = [Flag flagWithDict:x];
//        [arr addObject:flag];
//    }];
    
    // 高级用法
    NSArray *arr = [[dictArr.rac_sequence map:^id(NSDictionary *value) {
        // value:集合中元素
        // id:返回对象就是映射的值
        return [RACFlag flagWithDict:value];
    }] array];
    
    NSLog(@"%@", arr);
}

- (void)dict
{
    NSDictionary *dict = @{@"account":@"aaa", @"name":@"xmg", @"age":@18};
    
    [dict.rac_sequence.signal subscribeNext:^(RACTuple *x) {
        
        //        NSString *key = x[0];
        //        NSString *value = x[1];
        //        NSLog(@"%@ %@", key ,value);
        
        // RACTupleUnpack:用来解析元组
        // 宏里面的参数,传需要解析出来的变量名
        // = 右边,放需要解析的元组
        RACTupleUnpack(NSString *key, NSString *value) = x;
        
        NSLog(@"%@ %@", key, value);
    }];

}

- (void)arr
{
    NSArray *array = @[@"213", @"321", @1];
    
    // RAC集合
    RACSequence *sequence = array.rac_sequence;
    
    // 把集合转换成信号
    RACSignal *signal = sequence.signal;
    
    [signal subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
}

- (void)tuple
{
    RACTuple *tuple = [RACTuple tupleWithObjectsFromArray:@[@"213", @"321", @1]];
    NSString *str = tuple[0];
    NSLog(@"%@", str);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
