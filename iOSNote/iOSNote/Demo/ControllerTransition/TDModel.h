//
//  TDModel.h
//  iOSNote
//
//  Created by wangdong on 16/5/13.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TDModel : NSObject

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy, readonly) NSString *overview;

+ (NSArray *)exampleThings;
- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image overview:(NSString *)overview;

@end
