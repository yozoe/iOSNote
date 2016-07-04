//
//  Flag.h
//  iOSNote
//
//  Created by wangdong on 16/7/1.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Flag : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *icon;

+ (instancetype)flagWithDict:(NSDictionary *)dict;

@end
