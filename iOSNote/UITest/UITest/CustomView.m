//
//  CustomView.m
//  UITest
//
//  Created by wangdong on 2016/11/30.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import "CustomView.h"

@implementation CustomView

+ (instancetype)instanceFromNib {
    return (CustomView *)[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].lastObject;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
//        NSArray *arrayNibs = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
//        [self addSubview:[arrayNibs firstObject]];
    }
    return self;
}

@end
