//
//  RACAdvancedVC.m
//  iOSNote
//
//  Created by 王东 on 2016/11/24.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import "RACAdvancedVC.h"
#import "ReactiveCocoa.h"

@interface RACAdvancedVC ()

@end

@implementation RACAdvancedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

/*
 按一定顺序拼接信号，当多个信号发出的时候，有顺序的接收信号。
 // concat底层实现:
 // 1.当拼接信号被订阅，就会调用拼接信号的didSubscribe
 // 2.didSubscribe中，会先订阅第一个源信号（signalA）
 // 3.会执行第一个源信号（signalA）的didSubscribe
 // 4.第一个源信号（signalA）didSubscribe中发送值，就会调用第一个源信号（signalA）订阅者的nextBlock,通过拼接信号的订阅者把值发送出来.
 // 5.第一个源信号（signalA）didSubscribe中发送完成，就会调用第一个源信号（signalA）订阅者的completedBlock,订阅第二个源信号（signalB）这时候才激活（signalB）。
 // 6.订阅第二个源信号（signalB）,执行第二个源信号（signalB）的didSubscribe
 // 7.第二个源信号（signalA）didSubscribe中发送值,就会通过拼接信号的订阅者把值发送出来.
 */
- (IBAction)concat:(id)sender {
    
    RACSignal *firsetSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [subscriber sendNext:@"延迟发送第一个信号"];
            [subscriber sendCompleted];
        });
        return nil;
    }];
    
    RACSignal *secondSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"第二个信号发送"];
        return nil;
    }];
    
    RACSignal *concatSignal = [firsetSignal concat:secondSignal];
    
    [concatSignal subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    
}

/*
 用于连接两个信号，当第一个信号完成，才会连接then返回的信号。
 注意使用then，之前信号的值会被忽略掉.
 底层实现：1、先过滤掉之前的信号发出的值。2.使用concat连接then返回的信号
 */
- (IBAction)then:(id)sender {
    [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"第一个信号发送"];
        [subscriber sendCompleted];
        return nil;
    }] then:^RACSignal *{
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:@"then里的信号发送完成"];
            return nil;
        }];
    }] subscribeNext:^(id x) {
        NSLog(@"then--> %@", x);
    }];
}

/*
 把多个信号合并为一个信号，任何一个信号有新值的时候就会调用
 // 底层实现：
 // 1.合并信号被订阅的时候，就会遍历所有信号，并且发出这些信号。
 // 2.每发出一个信号，这个信号就会被订阅
 // 3.也就是合并信号一被订阅，就会订阅里面所有的信号。
 // 4.只要有一个信号被发出就会被监听。
 */
- (IBAction)merge:(id)sender {
    
    RACSignal *signal1 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"第一个信号发送数据"];
        return nil;
    }];
    
    RACSignal *signal2 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [subscriber sendNext:@"延迟发送第二个信号"];
        });
        return nil;
    }];
    
    RACSignal *signal3 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"第三个信号发送数据"];
        return nil;
    }];
 
    RACSignal *mergeSignal = [[signal1 merge:signal2] merge:signal3];
    [mergeSignal subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
}

/*
 把两个信号压缩成一个信号，只有当两个信号同时发出信号内容时，并且把两个信号的内容合并成一个元组，才会触发压缩流的next事件。
 // 底层实现:
 // 1.定义压缩信号，内部就会自动订阅signalA，signalB
 // 2.每当signalA或者signalB发出信号，就会判断signalA，signalB有没有发出个信号，有就会把最近发出的信号都包装成元组发出。
 */
- (IBAction)zipWith:(id)sender {
    
    RACSignal *signal1 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"发送第一个信号"];
        return nil;
    }];
    
    RACSignal *signal2 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [subscriber sendNext:@"延迟发送第二个信号"];
        });
        return nil;
    }];
    
    RACSignal *zipSignal = [signal1 zipWith:signal2];
    
    [zipSignal subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    
}

/*
 将多个信号合并起来，并且拿到各个信号的最新的值,必须每个合并的signal至少都有过一次sendNext，才会触发合并的信号。
 // 底层实现：
 // 1.当组合信号被订阅，内部会自动订阅signalA，signalB,必须两个信号都发出内容，才会被触发。
 // 2.并且把两个信号组合成元组发出。
 */
- (IBAction)combineLatest:(id)sender {
    
    RACSignal *signal1 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"发送第一个信号"];
        return nil;
    }];
    
    RACSignal *signal2 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [subscriber sendNext:@"延迟发送第二个信号"];
        });
        return nil;
    }];
    
    RACSignal *combineSignal = [signal1 combineLatestWith:signal2];
    
    [combineSignal subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];

}

/*
 聚合:用于信号发出的内容是元组，把信号发出元组的值聚合成一个值
 // 聚合
 // 常见的用法，（先组合在聚合）。combineLatest:(id<NSFastEnumeration>)signals reduce:(id (^)())reduceBlock
 // reduce中的block简介:
 // reduceblcok中的参数，有多少信号组合，reduceblcok就有多少参数，每个参数就是之前信号发出的内容
 // reduceblcok的返回值：聚合信号之后的内容。
 // 底层实现:
 // 1.订阅聚合信号，每次有内容发出，就会执行reduceblcok，把信号内容转换成reduceblcok返回的值。
 */
- (IBAction)reduce:(id)sender {
    
    RACSignal *signal1 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"第一个信号发送数据"];
        return nil;
    }];
    
    RACSignal *signal2 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [subscriber sendNext:@"延迟发送第二个信号"];
        });
        return nil;
    }];
    
    RACSignal *signal3 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"第三个信号发送数据"];
        return nil;
    }];
    
    RACSignal *reduceSignal = [RACSignal combineLatest:@[signal1, signal2, signal3] reduce:^id(NSString *v1, NSString *v2, NSString *v3){
        return [NSString stringWithFormat:@"%@-%@-%@", v1, v2, v3];
    }];
    
    [reduceSignal subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
}

/*
 过滤信号，使用它可以获取满足条件的信号.
 */
- (IBAction)filter:(id)sender {
    
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        int x = arc4random() % 10;
        
        NSLog(@"值为:%d", x);
        [subscriber sendNext:@(x)];
        
        return nil;
    }];
    
    [[signal filter:^BOOL(NSNumber *value) {
        return value.intValue > 4;
    }] subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
}

/*
 忽略完某些值的信号.
 */
- (IBAction)ignore:(id)sender {
    
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        int x = arc4random() % 10;
        NSLog(@"值为:%d", x);
        
        [subscriber sendNext:@(x)];
        
        return nil;
    }];
    
    [[signal ignore:@(4)] subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
}

/*
 从开始一共取N次的信号
 */
- (IBAction)take:(id)sender {
    
    RACSubject *subject = [RACSubject subject];
    
    [[subject take:2] subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    
    [subject sendNext:@1];
    [subject sendNext:@2];
    [subject sendNext:@3];
    [subject sendNext:@4];
    [subject sendNext:@5];
}

/*
 取最后N次的信号,前提条件，订阅者必须调用完成，因为只有完成，就知道总共有多少信号.
 */
- (IBAction)takeLast:(id)sender {
    // 1、创建信号
    RACSubject *signal = [RACSubject subject];
    
    // 2、处理信号，订阅信号
    [[signal takeLast:1] subscribeNext:^(id x) {
        
        NSLog(@"%@",x);
    }];
    
    // 3.发送信号
    [signal sendNext:@1];
    
    [signal sendNext:@2];
    
    [signal sendCompleted];
}

/*
 (RACSignal *):获取信号直到某个信号执行完成
 */
- (IBAction)takeUntil:(id)sender {
}

/*
 当上一次的值和当前的值有明显的变化就会发出信号，否则会被忽略掉。
 */
- (IBAction)distinctUntilChanged:(id)sender {
    
    RACSubject *subject = [RACSubject subject];
    
    [[subject distinctUntilChanged] subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    
    [subject sendNext:@1];
    [subject sendNext:@2];
    
    //下面的值都会被忽略掉
    [subject sendNext:@2];
    [subject sendNext:@2];
    [subject sendNext:@2];
}

- (IBAction)skip:(id)sender {
}

- (IBAction)switchToLatest:(id)sender {
}


@end
