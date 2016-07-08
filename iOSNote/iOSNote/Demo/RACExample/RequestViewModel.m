//
//  RequestViewModel.m
//  iOSNote
//
//  Created by wangdong on 16/7/8.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import "RequestViewModel.h"
#import "AFNetworking.h"

@implementation RequestViewModel

- (instancetype)init
{
    if (self = [super init]) {
        [self setUp];
    }
    return self;
}

- (void)setUp
{
    _requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
            [mgr GET:@"https://api.douban.com/v2/book/search" parameters:@{@"q":@"美女"} progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                // 请求成功的时候调用
//                NSLog(@"%@", responseObject);
                
                NSArray *dicArr = responseObject[@"books"];
                NSArray *modeArr = [[dicArr.rac_sequence map:^id(id value) {
                    return [[NSObject alloc] init];
                }] array];
                
                [subscriber sendNext:modeArr];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                //
            }];
            return nil;
        }];
        
        return signal;
    }];
    
    
}

@end
