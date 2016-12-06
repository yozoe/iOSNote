//
//  RACBaseVC.m
//  iOSNote
//
//  Created by wangdong on 2016/11/29.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import "RACBaseVC.h"
#import "ReactiveCocoa.h"

@interface RACBaseVC ()

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) RACCommand *command;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *commandButton;
@property (nonatomic, strong) RACSignal *testDisposeSignal;
@property (nonatomic, strong) RACDisposable *dispose;

@end

@implementation RACBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    @weakify(self)
    [[RACSignal interval:1 onScheduler:[RACScheduler currentScheduler]] subscribeNext:^(id x) {
        @strongify(self)
        self.index++;
    }];
    
    self.commandButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [subscriber sendNext:@"延迟两秒发送的数据"];
                [subscriber sendCompleted];
            });
            
            return nil;
        }];
    }];
    
    [[self.commandButton.rac_command.executionSignals switchToLatest] subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    
    static NSTimeInterval const __ZPLoginDefaultWaitingSeconds = 5;
    
    self.testDisposeSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [subscriber sendNext:@"延迟5秒发送信号"];
        });
        
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"销毁了");
        }];
    }];
    
    self.dispose = [self.testDisposeSignal subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    
    
//    self.testDisposeSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//        
//        [subscriber sendNext:@"你妈我都蒙圈了"];
//        
//        @strongify(self);
//        __block NSTimeInterval totalSeconds = __ZPLoginDefaultWaitingSeconds;
//        self.dispose = [[[[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber1) {
//            totalSeconds -= 1;
//            [subscriber1 sendNext:@(totalSeconds)];
//            [subscriber1 sendCompleted];
//            return nil;
//        }] delay:1.0] repeat] takeUntilBlock:^BOOL(id x) {
//            return (totalSeconds < 0);
//        }] subscribeNext:^(id x) {
//            NSLog(@"%@", x);
//        } completed:^{
//            NSLog(@"complete");
//            [subscriber sendCompleted];
//        }];
//        
//        return self.dispose;
//    }];
//    
//    [self.testDisposeSignal subscribeNext:^(id x) {
//        NSLog(@"%@", x);
//    }];
    
    
}

- (IBAction)RACMacro:(id)sender {
    [self.dispose dispose];
}

- (IBAction)RACObserveMacro:(id)sender {
    
    [RACObserve(self, index) subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    
}

/*
 // 一、RACCommand使用步骤:
 // 1.创建命令 initWithSignalBlock:(RACSignal * (^)(id input))signalBlock
 // 2.在signalBlock中，创建RACSignal，并且作为signalBlock的返回值
 // 3.执行命令 - (RACSignal *)execute:(id)input
 
 // 二、RACCommand使用注意:
 // 1.signalBlock必须要返回一个信号，不能传nil.
 // 2.如果不想要传递信号，直接创建空的信号[RACSignal empty];
 // 3.RACCommand中信号如果数据传递完，必须调用[subscriber sendCompleted]，这时命令才会执行完毕，否则永远处于执行中。
 // 4.RACCommand需要被强引用，否则接收不到RACCommand中的信号，因此RACCommand中的信号是延迟发送的。
 
 // 三、RACCommand设计思想：内部signalBlock为什么要返回一个信号，这个信号有什么用。
 // 1.在RAC开发中，通常会把网络请求封装到RACCommand，直接执行某个RACCommand就能发送请求。
 // 2.当RACCommand内部请求到数据的时候，需要把请求的数据传递给外界，这时候就需要通过signalBlock返回的信号传递了。
 
 // 四、如何拿到RACCommand中返回信号发出的数据。
 // 1.RACCommand有个执行信号源executionSignals，这个是signal of signals(信号的信号),意思是信号发出的数据是信号，不是普通的类型。
 // 2.订阅executionSignals就能拿到RACCommand中返回的信号，然后订阅signalBlock返回的信号，就能获取发出的值。
 
 // 五、监听当前命令是否正在执行executing
 
 // 六、使用场景,监听按钮点击，网络请求
 */
- (IBAction)command:(id)sender {

    
    self.command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [subscriber sendNext:[NSString stringWithFormat:@"%@  我是发送的数据", input]];
                [subscriber sendCompleted];
                [subscriber sendError:nil];
            });
            
            
            return nil;
        }];
        
    }];
    
    [self.command.executionSignals subscribeNext:^(id x) {
        [x subscribeNext:^(id x) {
            NSLog(@"executionSignals %@", x);
        }];
    }];
    
    [self.command.executing subscribeNext:^(id x) {
        NSLog(@"executing %@", x);
    }];
    
    [self.command.errors subscribeNext:^(id x) {
        NSLog(@"error %@", x);
    }];
    
    RACSignal *signal = [self.command execute:@"我可以是参数"];
    
    [signal subscribeNext:^(id x) {
        NSLog(@"command 返回的信号 %@", x);
    }];
}

- (IBAction)multicastConnection:(id)sender {
}

- (IBAction)liftSelectorWithSignalsFromArraySignals:(id)sender {
}

- (IBAction)ifThenElse:(id)sender {
    RACSignal *s1 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@(false)];
        [subscriber sendCompleted];
        return nil;
    }];
    
    RACSignal *s2 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"信号1"];
        [subscriber sendCompleted];
        return nil;
    }];
    
    RACSignal *s3 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"信号2"];
        [subscriber sendCompleted];
        return nil;
    }];
    
    [[RACSignal if:s1 then:s2 else:s3] subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
}

- (IBAction)returnSignal:(id)sender {
    [[RACSignal return:@1] subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
}

- (IBAction)signalForSelector:(id)sender {
    [[[self rac_signalForSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:) fromProtocol:@protocol(UITextFieldDelegate)] map:^id(RACTuple *value) {
        return value.first;
    }] subscribeNext:^(UITextField *x) {
        NSLog(@"%@", x.text);
    }];
}

- (IBAction)liftSelector:(id)sender {
    
    RACSignal *firstSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [subscriber sendNext:@"第一个信号延迟两秒发送数据"];
        });
        return nil;
    }];
    
    RACSignal *secondSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"第二个信号立即发送"];
        return nil;
    }];
    
    [self rac_liftSelector:@selector(liftSelectorFirst:second:) withSignalsFromArray:@[firstSignal, secondSignal]];
}

- (void)liftSelectorFirst:(NSString *)first second:(NSString *)second
{
    NSLog(@"%@  %@", first, second);
}

@end
