//
//  RACTestViewController.m
//  iOSNote
//
//  Created by wangdong on 16/9/27.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import "RACTestViewController.h"
#import "ReactiveCocoa.h"

@interface RACTestViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextField *tf;
@property (weak, nonatomic) IBOutlet UIButton *button;

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, assign) NSInteger index1;


@property (nonatomic, assign) NSInteger index2;

@end

@implementation RACTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [NSNotificationCenter defaultCenter] addObserver:self selector:@selector(t) name:<#(nullable NSString *)#> object:<#(nullable id)#>;
    
    
//    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardDidShowNotification object:nil] map:^id(NSNotification *value) {
//        return value[@"UIKeyboardAnimationCurveUserInfoKey"];
//    }] subscribeNext:^(id x) {
//        NSLog(@"%@", x);
//    }];
    
    
//    [self addObserver:self forKeyPath:@"index" options:NSKeyValueObservingOptionNew context:nil];
//     [self addObserver:self forKeyPath:@"index1" options:NSKeyValueObservingOptionNew context:nil];
//     [self addObserver:self forKeyPath:@"index2" options:NSKeyValueObservingOptionNew context:nil];


//    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timer) userInfo:nil repeats:YES];
    
    
//    @weakify(self);
//    [[RACSignal interval:1 onScheduler:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
//        @strongify(self);
//        self.index++;
//        self.index1++;
//        self.index2++;
//    }];
//    
//    [[self rac_valuesForKeyPath:@"index" observer:nil] subscribeNext:^(id x) {
//        NSLog(@"index %@", x);
//    }];
//    
//    [[self rac_valuesForKeyPath:@"index1" observer:nil] subscribeNext:^(id x) {
//        NSLog(@"index1 %@", x);
//    }];
//    
//    [[self rac_valuesForKeyPath:@"index2" observer:nil] subscribeNext:^(id x) {
//        NSLog(@"index2 %@", x);
//    }];
    
//    NSDictionary *dic = @{@"a":@"b", @"c":@"d"};
//    
//    //pipleline
//    [[[[dic.rac_sequence signal] skip:1] map:^id(RACTuple *value) {
//        return value.second;
//    }] subscribeNext:^(id x) {
//        NSLog(@"%@", x);
//    }];
//
//    
//    [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
//        
//    }];
    
//    [[RACSignal interval:1 onScheduler:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
//        NSLog(@"%@", [NSThread currentThread]);
//    }];
//    
//    [[RACSignal interval:2 onScheduler:[RACScheduler schedulerWithPriority:RACSchedulerPriorityBackground]] subscribeNext:^(id x) {
//        NSLog(@"%@", [NSThread currentThread]);
//    }];

    
//kvo
    
}

- (void)timer
{
    self.index++;
    self.index1++;
    self.index2++;
}

//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
//{
////    NSLog(@"%@", [change valueForKey:@"new"]);
//    if ([keyPath isEqualToString:@"index"]) {
//        NSLog(@"inex %@", [change valueForKey:@"new"]);
//    }
//    if ([keyPath isEqualToString:@"index1"]) {
//        NSLog(@"index1 %@", [change valueForKey:@"new"]);
//    }
//    if ([keyPath isEqualToString:@"index2"]) {
//        NSLog(@"index2 %@", [change valueForKey:@"new"]);
//    }
//}

//- (void)test{
//    NSLog(@"clicked");
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
