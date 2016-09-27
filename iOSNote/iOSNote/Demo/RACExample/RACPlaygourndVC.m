//
//  PlaygourndVC.m
//  iOSNote
//
//  Created by wangdong on 16/7/29.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import "RACPlaygourndVC.h"
#import "ReactiveCocoa.h"
#import "RACReturnSignal.h"
#import "RACScheduler.h"
#import "NSObject+RACKVOWrapper.h"

@interface RACPlaygourndVC ()

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextField *textField1;
@property (weak, nonatomic) IBOutlet UIButton *retryButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) NSInteger index;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (nonnull, strong) id<RACSubscriber> subscriber;

@end

@implementation RACPlaygourndVC

- (void)hehe:(UITextField *)sender
{
    self.label.text = sender.text;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification object:nil] map:^id(NSNotification *value) {
        return [value.userInfo objectForKey:@"UIKeyboardFrameEndUserInfoKey"];
    }] subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    
    return;
    
    NSDictionary *dic = @{@"a":@"b",@"c":@"d"};
//    [dic.rac_sequence.signal subscribeNext:^(RACTuple *x) {
//        NSLog(@"%@ %@", x.first, x.second);
//    }];
    
    [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSLog(@"%@ %@", key, obj);
    }];
    
    
    return;
    
    @weakify(self);
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        @strongify(self);
        self.subscriber = subscriber;
        [subscriber sendNext:@"hehe"];
        
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"disposable");
        }];
    }];
    
    [[signal subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }] dispose];
    
    
    return;
    
//    [self.textField addTarget:self action:@selector(hehe:) forControlEvents:UIControlEventEditingChanged];
//    
//    return;
    
    RAC(self.label, text) = [[self.textField.rac_textSignal skip:0] map:^id(NSString *value) {
        return [value stringByAppendingString:@"-hehe"];
    }];
    
    return;
    
//    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(headerHeight) userInfo:nil repeats:YES];
    
    [[[RACSignal interval:1 onScheduler:[RACScheduler mainThreadScheduler]] startWith:nil] subscribeNext:^(id x) {
        self.index=123;
    }];
    
    [[self rac_valuesAndChangesForKeyPath:@"index" options:NSKeyValueObservingOptionNew observer:nil] subscribeNext:^(RACTuple *x) {
        NSLog(@"%@", x.first);
        NSLog(@"==> %ld", self.index);
    }];
    
    [[RACSignal interval:1 onScheduler:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
        NSLog(@"meimeide");
    }];
    
    
//    RAC(self.textField, backgroundColor) = [self.textField.rac_textSignal map:^id(NSString *value) {
//        return value.length > 3 ? [UIColor redColor] : [UIColor yellowColor];
//    }];
    
    
//    RACSignal *signal = [self.textField.rac_textSignal map:^id(NSString *value) {
//        return @(value.length);
//    }];
//    
//    RACSignal *signal1 = [self.textField1.rac_textSignal map:^id(NSString *value) {
//        return @(value.length);
//    }];
//    
//    RACSignal *signal2 = [[RACSignal combineLatest:@[signal, signal1] reduce:^id(NSNumber *v1, NSNumber *v2){
//        NSLog(@"%@  %@", v1, v2);
//        return @(1);
//    }] subscribeNext:^(id x) {
//        NSLog(@"%@", x);
//    }];
    
//    [[self.retryButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
//        NSLog(@"%@", x);
//    }];
    
    [[[[self.retryButton rac_signalForControlEvents:UIControlEventTouchUpInside] doNext:^(id x) {
        NSLog(@"do next %@", x);
    }] flattenMap:^RACStream *(id value) {
        NSLog(@"%@", value);
        RACSignal *sig = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:@"hehe"];
            [subscriber sendCompleted];
            return nil;
        }];
        return sig;
    }] subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];

    
//    [subject sendNext:@"hehe"];
    
//    RACSignal *returnSignal = [subject flattenMap:^RACStream *(id value) {
//        NSLog(@"%@", value);
//        return [RACReturnSignal return:@"妹妹"];
//    }];
//    
//    [returnSignal subscribeNext:^(id x) {
//        NSLog(@"%@", x);
//    }];
//    
//    [subject sendNext:@"jiji"];
    
//    RACSignal *bindSignal = [subject map:^id(id value) {
//        return [NSString stringWithFormat:@"xmg:%@", value];
//    }];
//    
//    [bindSignal subscribeNext:^(id x) {
//        NSLog(@"%@", x);
//    }];
//    
//    [subject sendNext:@"hehe"];
    
//    RACSubject *signalOfSignals = [RACSubject subject];
//    RACSubject *signal = [RACSubject subject];
//    
//    [[signalOfSignals flattenMap:^RACStream *(id value) {
//        return value;
//    }] subscribeNext:^(id x) {
//        NSLog(@"%@", x);
//    }];;
//    
//    [signalOfSignals sendNext:signal];
//    
//    [signal sendNext:@"hehe"];
    
    
//    RACSignal *signala = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//        [subscriber sendNext:@"aaaaa"];
//        [subscriber sendCompleted];
//        return nil;
//    }];
//    
//    RACSignal *signalb = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//        [subscriber sendNext:@"bbbbb"];
//        return nil;
//    }];
//
//    
//    RACSignal *concatSignal = [signala concat:signalb];
//    
//    [concatSignal subscribeNext:^(id x) {
//        NSLog(@"%@", x);
//    }];
    
    
//    RACSignal *thenSignal = [signala then:^RACSignal *{
//        return signalb;
//    }];
//    
//    [thenSignal subscribeNext:^(id x) {
//        NSLog(@"%@", x);
//    }];
    
    
    
//    RACSubject *signala = [RACSubject subject];
//    RACSubject *signalb = [RACSubject subject];
//
//    RACSignal *mergeSignal = [signala merge:signalb];
//    
//    [mergeSignal subscribeNext:^(id x) {
//        NSLog(@"%@", x);
//    }];
//    
//    [signala sendNext:@"上部分"];
//    [signalb sendNext:@"下部分"];
    
//    RACSubject *signala = [RACSubject subject];
//    RACSubject *signalb = [RACSubject subject];
//
//    [[signala zipWith:signalb] subscribeNext:^(id x) {
//        NSLog(@"%@", x);
//    }];
//    
//    [signala sendNext:@"aaaa"];
//    [signalb sendNext:@"bbbb"];
    
    
    
//    [self rac_liftSelector:@selector(update:) withSignalsFromArray:@[hotsignal, newsignal]];
    
    
//    RACSignal *hotsignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//        [subscriber sendNext:@"hot"];
//        return nil;
//    }];
//    
//    RACSignal *newsignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//        [subscriber sendNext:@"new"];
//        return nil;
//    }];
//    
//    [self rac_liftSelector:@selector(updateUIWithHot:new:) withSignalsFromArray:@[hotsignal, newsignal]];

    
//    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//        [subscriber sendNext:@"hot"];
//        return nil;
//    }];
//    
//    RACMulticastConnection *connection = [signal publish];
//    
//    [connection.signal subscribeNext:^(id x) {
//        NSLog(@"订阅者1%@", x);
//    }];
//    
//    [connection.signal subscribeNext:^(id x) {
//        NSLog(@"订阅者2%@", x);
//    }];
//    
//    [connection connect];
    
    
//    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
//        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//            [subscriber sendNext:@"执行命令产生的数据"];
//            return nil;
//        }];
//    }];
    
//    RACSignal *signal = [command execute:@123];
//    
//    [signal subscribeNext:^(id x) {
//        NSLog(@"%@", x);
//    }];
    
//    [command.executionSignals subscribeNext:^(RACSignal *x) {
//        [x subscribeNext:^(id x) {
//            NSLog(@"%@", x);
//        }];
//    }];
//    
//    [command execute:@213];
    
//    [[self.textField.rac_textSignal bind:^RACStreamBindBlock{
//        return ^RACStream *(id value, BOOL *stop) {
//            return [RACReturnSignal return:@"hehe"];
//        };
//    }] subscribeNext:^(id x) {
//        NSLog(@"%@", x);
//    }];

//    [[_textField.rac_textSignal filter:^BOOL(NSString *value) {
//        return value.length > 3;
//    }] subscribeNext:^(id x) {
//        NSLog(@"hehe");
//    }];
    
//    [[_textField.rac_textSignal ignore:@"1"] subscribeNext:^(id x) {
//        NSLog(@"%@", x);
//    }];
    
//    RACSubject *subject = [RACSubject subject];
//    
//    [[subject distinctUntilChanged] subscribeNext:^(id x) {
//        NSLog(@"%@", x);
//    }];
//    
//    
//    [subject sendNext:@"1"];
//    [subject sendNext:@"1"];
    
//    RACSubject *subject = [RACSubject subject];
//    
//    [[subject take:1] subscribeNext:^(id x) {
//        
//    }];
    
//    RACSubject *subject = [RACSubject subject];
//    [[subject take:2] subscribeNext:^(id x) {
//        NSLog(@"%@", x);
//    }];
//    
//    [subject sendNext:@1];
//    [subject sendNext:@2];
//    [subject sendNext:@3];
    
//    [self initPipeline];
    
//    [self.textField.rac_textSignal subscribeNext:^(id x) {
//        NSLog(@"%@", x);
//    } completed:^{
//        NSLog(@"complete");
//    }];
    
    
//    NSArray *numbers = @[@1,@2,@3,@4,@5];
//    
//    [numbers.rac_sequence.signal subscribeNext:^(id x) {
//        NSLog(@"%@", x);
//    }];
    
    
    
//    [[[RACSignal interval:1 onScheduler:[RACScheduler mainThreadScheduler]] startWith:nil] subscribeNext:^(id x) {
//        NSLog(@"%@", x);
//    }];
    
//    [self initRetryButtonPipeline];
}

- (void)initPipeline
{
    RACSignal *signal1 = [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification object:nil] map:^id(NSNotification *value) {
        
        NSDictionary *userInfo = [value userInfo];
        return [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
        
    }];
    
//    [[[[[[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillHideNotification object:nil] map:^id(id value) {
//        NSDictionary *userInfo = [value userInfo];
//        return [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
//    }] merge:signal1] skip:1] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
//        NSLog(@"sub -> %@", x);
//    } completed:^{
//        NSLog(@"completed");
//    }];
    
//    @weakify(self);
    
    [[[[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillHideNotification object:nil] map:^id(id value) {
        NSDictionary *userInfo = [value userInfo];
        return [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    }] merge:signal1] subscribeNext:^(id x) {
//        @strongify(self);
//        [self testMethod];
        NSLog(@"sub -> %@", x);
    } completed:^{
        NSLog(@"completed");
    }];
    
}

- (RACSignal *)retryButtonTitleAndEnable {
    static const NSInteger n = 5;
    
    RACSignal *timer = [[[RACSignal interval:1 onScheduler:[RACScheduler mainThreadScheduler]] map:^id(id value) {
        return nil;
        
    }] startWith:nil];
    
    NSMutableArray *numbers = [[NSMutableArray alloc] init];
    for (int i = n; i >= 0; i--) {
        
        [numbers addObject:[NSNumber numberWithInteger:i]];
    }
    
    return [[numbers.rac_sequence.signal zipWith:timer] map:^id(RACTuple *tuple) {
        NSNumber *number = tuple.first;
        NSLog(@"%@", number);
        NSInteger count = number.integerValue;
        if (count == 0) {
            return RACTuplePack(@"重试", [NSNumber numberWithBool:YES]);
        }
        else {
            NSString *title = [NSString stringWithFormat:@"重试(%lds)", (long)count];
            return RACTuplePack(title, [NSNumber numberWithBool:NO]);
        }
    }];
}

- (void)initRetryButtonPipeline
{
    @weakify(self);
    [[[[[[self.retryButton rac_signalForControlEvents:UIControlEventTouchUpInside] map:^id(id value) {
        
        @strongify(self);
        return [self retryButtonTitleAndEnable];
        
    }] startWith:[self retryButtonTitleAndEnable]] switchToLatest] takeUntil:[self rac_willDeallocSignal]] subscribeNext:^(RACTuple *tuple) {
        
        @strongify(self);
        NSString *title = tuple.first;
        [self.retryButton setTitle:title forState:UIControlStateNormal];

    } completed:^{
        
    }];
}

- (void)dealloc
{
    NSLog(@"%s dealloc", __func__);
}

- (void)testMethod
{
    NSLog(@"test method");
}

- (void)updateUIWithHot:(NSString *)hot new:(NSString *)new
{
    NSLog(@"%@ %@", hot, new);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)handleButtonAction:(id)sender {
    [self.textField resignFirstResponder];
}

@end
