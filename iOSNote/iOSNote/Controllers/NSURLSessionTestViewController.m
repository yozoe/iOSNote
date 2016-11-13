//
//  NSURLSessionTestViewController.m
//  iOSNote
//
//  Created by 王东 on 2016/11/9.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import "NSURLSessionTestViewController.h"
#import <AFNetworking.h>
#import "TestViewController.h"

@interface NSURLSessionTestViewController () <NSURLSessionDataDelegate>

@property (nonatomic, strong) NSMutableData *fileData;

@end

@implementation NSURLSessionTestViewController

- (NSMutableData *)fileData
{
    if (_fileData == nil) {
        _fileData = [NSMutableData data];
    }
    return _fileData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    NSLog(@"start");
    
    dispatch_async(queue, ^{
        NSLog(@"download1");
    });
    
    dispatch_async(queue, ^{
        NSLog(@"download2");
    });
    
    dispatch_async(queue, ^{
        NSLog(@"download3");
    });
    
    dispatch_async(queue, ^{
        NSLog(@"download4");
    });
    
    NSLog(@"end");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    TestViewController *vc = [[TestViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
    return;
    [NSThread detachNewThreadWithBlock:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"testMethod" object:nil];
    }];
    
    
    return;
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSession *seesion = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];

    
    NSURLSessionDataTask *dataTask = [seesion dataTaskWithRequest:request];
    
    
    [dataTask resume];
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    NSLog(@"%s", __func__);
    
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    NSLog(@"%s", __func__);
    
    [self.fileData appendData:data];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    NSLog(@"%s", __func__);
    
    NSLog(@"%@", [[NSString alloc] initWithData:self.fileData encoding:NSUTF8StringEncoding]);
}

- (void)get
{
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    }];
    
    [dataTask resume];
}

@end
