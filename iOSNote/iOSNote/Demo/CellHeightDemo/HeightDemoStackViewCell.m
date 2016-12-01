//
//  HeightDemoStackViewCell.m
//  iOSNote
//
//  Created by wangdong on 2016/12/1.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import "HeightDemoStackViewCell.h"

@implementation HeightDemoStackViewCell

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
    [self.stackView.arrangedSubviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

@end
