//
//  HeightDemoCell_1.m
//  iOSNote
//
//  Created by wangdong on 2016/12/1.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import "HeightDemoCell_1.h"

@implementation HeightDemoCell_1

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)prepareForReuse
{
    self.testImageView.image = nil;
    self.testTitle.text = @"";
}

@end
