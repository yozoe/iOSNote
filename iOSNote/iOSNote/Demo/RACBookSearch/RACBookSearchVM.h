//
//  RACBookSearchVM.h
//  iOSNote
//
//  Created by wangdong on 16/7/23.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa.h>

@interface RACBookSearchVM : NSObject

@property (nonatomic, strong) RACCommand *executeSearch;
@property (nonatomic, strong) NSString *searchText;

@end
