//
//  ImagePickerUploadButton.m
//  iOSNote
//
//  Created by wangdong on 16/5/18.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import "ImagePickerUploadButton.h"

@interface ImagePickerUploadButton ()

@property (nonatomic, strong) UILabel *badgeValueLabel;
@property (nonatomic, strong) UIView *backGroudView;
@property (nonatomic, strong) UIButton *sendButton;

@end


@implementation ImagePickerUploadButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:CGRectMake(0, 0, 58, 26)]) {
        [self initControls];
    }
    return self;
}

- (void)addTaget:(id)target action:(SEL)action
{
    [self.sendButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

- (void)initControls
{
    _backGroudView = [[UIView alloc] init];
    
    _backGroudView.layer.cornerRadius = 9.f;
    _backGroudView.backgroundColor = [UIColor redColor];
    
    [self addSubview:_backGroudView];
    
    
    _badgeValueLabel = [[UILabel alloc] init];
    _badgeValueLabel.backgroundColor = [UIColor clearColor];
    _badgeValueLabel.textColor = [UIColor whiteColor];
    _badgeValueLabel.font = [UIFont systemFontOfSize:15.0f];
    _badgeValueLabel.textAlignment = NSTextAlignmentCenter;
    _badgeValueLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:_badgeValueLabel];
    
    
    
    _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_sendButton setTitle:@"上传"
                 forState:UIControlStateNormal];
    _sendButton.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    _sendButton.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    _sendButton.backgroundColor = [UIColor clearColor];
    [self addSubview:_sendButton];
    
    [_sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [_badgeValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_sendButton.mas_left).offset(-16.f);
        make.centerY.equalTo(_sendButton);
        make.width.height.mas_equalTo(18.f);
    }];
    
    [_backGroudView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_badgeValueLabel);
    }];
}

- (void)setBadgeValue:(NSString *)badgeValue
{
//    CGRect rect = [badgeValue boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:kSendButtonFont} context:nil];
//    self.badgeValueLabel.frame = CGRectMake(self.badgeValueLabel.left, self.badgeValueLabel.top, (rect.size.width + 9) > 20?(rect.size.width + 9):20, 20);
//    self.backGroudView.width = self.badgeValueLabel.width;
//    self.backGroudView.height = self.badgeValueLabel.height;
//    
//    self.sendButton.width = self.badgeValueLabel.width + kSendButtonTextWitdh;
//    self.width = self.sendButton.width;
    
    self.badgeValueLabel.text = badgeValue;
    
    if (badgeValue.integerValue > 0) {
        [self showBadgeValue];
        self.backGroudView.transform =CGAffineTransformMakeScale(0, 0);
        [UIView animateWithDuration:0.2 animations:^{
            self.backGroudView.transform = CGAffineTransformMakeScale(1.1, 1.1);
        }
                         completion:^(BOOL finished){
                             [UIView animateWithDuration:0.1 animations:^{
                                 self.backGroudView.transform = CGAffineTransformMakeScale(1.0, 1.0);
                             }];
                         }];
        
    } else {
        [self hideBadgeValue];
    }
}

- (void)showBadgeValue
{
    self.badgeValueLabel.hidden = NO;
    self.backGroudView.hidden = NO;
}

- (void)hideBadgeValue
{
    self.badgeValueLabel.hidden = YES;
    self.backGroudView.hidden = YES;
    self.sendButton.adjustsImageWhenDisabled = YES;
}

@end
