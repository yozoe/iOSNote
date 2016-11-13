//
//  TestViewController.m
//  iOSNote
//
//  Created by wangdong on 16/4/21.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import "TestViewController.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"

@implementation TestObject1

- (void)dealloc
{
    NSLog(@"object dealloc");
}

@end

@interface TestViewController()
{
    TestObject1 *_t1;
}

@end

@implementation TestViewController

- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor whiteColor];
 
    
    _t1 = [TestObject1 new];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor redColor];
    button.frame = CGRectMake(0, 100, 50, 50);
    [self.view addSubview:button];
    
    [button addTarget:self action:@selector(handleButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
//    CFRunLoopRef runLoop = CFRunLoopGetCurrent();
//    CFStringRef runLoopMode = kCFRunLoopDefaultMode;
//    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler
//    (kCFAllocatorDefault, kCFRunLoopBeforeWaiting, true, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity _) {
//        NSLog(@"%@", observer);
//    });
//    CFRunLoopAddObserver(runLoop, observer, runLoopMode);
}

- (void)handleButtonAction
{
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://www.baidu.com"]];
//    NSURLSession *session = [NSURLSession sharedSession];
//    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSString *dataStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", dataStr);
//    }];
//    [task resume];
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
    return;
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[[NSURL alloc] initWithString:@"https://www.baidu.com"]];
    [manager GET:@"" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

- (void)dealloc
{
    NSLog(@"dealloc test");
}

@end
