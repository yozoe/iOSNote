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

@implementation TestViewController

- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor redColor];
    button.frame = CGRectMake(0, 100, 50, 50);
    [self.view addSubview:button];
    
    [button addTarget:self action:@selector(handleButtonAction) forControlEvents:UIControlEventTouchUpInside];
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
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[[NSURL alloc] initWithString:@"https://www.baidu.com"]];
    [manager GET:@"" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

@end
