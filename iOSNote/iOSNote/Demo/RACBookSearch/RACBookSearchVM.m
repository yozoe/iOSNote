//
//  RACBookSearchVM.m
//  iOSNote
//
//  Created by wangdong on 16/7/23.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import "RACBookSearchVM.h"
#import "AFNetworking.h"
#import "RACBookEntity.h"

@implementation RACBookSearchVM

- (instancetype)init
{
    if (self = [super init]) {
        [self initialize];
    }
    return self;
}

- (void)initialize
{    
    self.executeSearch = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [self getRequestSearchSignal];
    }];
}

- (RACSignal *)getRequestSearchSignal
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
        [mgr GET:@"https://api.douban.com/v2/book/search" parameters:@{@"q":_searchText} progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSArray *dicArr = responseObject[@"books"];
            NSArray *modeArr = [[dicArr.rac_sequence map:^id(NSDictionary *value) {
                
                RACBookEntity *entity = [RACBookEntity new];
                entity.title = value[@"title"];
                entity.summary = value[@"summary"];
                
                return entity;
            }] array];
            
            [subscriber sendNext:modeArr];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
        return nil;
    }];
}

@end
