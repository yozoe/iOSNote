//
//  ImagePickerCell.m
//  iOSNote
//
//  Created by wangdong on 16/5/17.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import "ImagePickerCell.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface ImagePickerCell()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *checkButton;
@property (nonatomic, strong) UIImageView *checkImageView;

@end

@implementation ImagePickerCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self imageView];
        [self checkButton];
        [self checkImageView];
        [self addContentConstraint];
    }
    return self;
}

- (void)addContentConstraint
{
    NSLayoutConstraint *imageConstraintsBottom = [NSLayoutConstraint
                                                  constraintWithItem:self.imageView
                                                  attribute:NSLayoutAttributeBottom
                                                  relatedBy:NSLayoutRelationEqual
                                                  toItem:self
                                                  attribute:NSLayoutAttributeBottom
                                                  multiplier:1.0f
                                                  constant:0];
    
    NSLayoutConstraint *imageConstraintsleading = [NSLayoutConstraint
                                                   constraintWithItem:self.imageView
                                                   attribute:NSLayoutAttributeLeading
                                                   relatedBy:NSLayoutRelationEqual
                                                   toItem:self
                                                   attribute:NSLayoutAttributeLeading
                                                   multiplier:1.0
                                                   constant:0];
    
    NSLayoutConstraint *imageContraintsTop = [NSLayoutConstraint
                                              constraintWithItem:self.imageView
                                              attribute:NSLayoutAttributeTop
                                              relatedBy:NSLayoutRelationEqual
                                              toItem:self
                                              attribute:NSLayoutAttributeTop
                                              multiplier:1.0
                                              constant:0];
    
    NSLayoutConstraint *imageViewConstraintTrailing = [NSLayoutConstraint
                                                       constraintWithItem:self.imageView
                                                       attribute:NSLayoutAttributeTrailing
                                                       relatedBy:NSLayoutRelationEqual
                                                       toItem:self
                                                       attribute:NSLayoutAttributeTrailing
                                                       multiplier:1.0
                                                       constant:0];
    
    [self addConstraints:@[imageConstraintsBottom,imageConstraintsleading,imageContraintsTop,imageViewConstraintTrailing]];
    
    NSLayoutConstraint *checkConstraitRight = [NSLayoutConstraint
                                               constraintWithItem:self.checkButton
                                               attribute:NSLayoutAttributeTrailing
                                               relatedBy:NSLayoutRelationEqual
                                               toItem:self
                                               attribute:NSLayoutAttributeTrailing
                                               multiplier:1.0f
                                               constant:0];
    
    NSLayoutConstraint *checkConstraitTop = [NSLayoutConstraint
                                             constraintWithItem:self.checkButton
                                             attribute:NSLayoutAttributeTop
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self
                                             attribute:NSLayoutAttributeTop
                                             multiplier:1.0f
                                             constant:0];
    
    NSLayoutConstraint *chekBtViewConsraintWidth = [NSLayoutConstraint
                                                    constraintWithItem:self.checkButton
                                                    attribute:NSLayoutAttributeWidth
                                                    relatedBy:NSLayoutRelationEqual
                                                    toItem:self.imageView
                                                    attribute:NSLayoutAttributeHeight
                                                    multiplier:0.5f
                                                    constant:0];
    
    NSLayoutConstraint *chekBtViewConsraintHeight = [NSLayoutConstraint
                                                     constraintWithItem:self.checkButton
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                     toItem:self.checkButton
                                                     attribute:NSLayoutAttributeWidth
                                                     multiplier:1.0
                                                     constant:0];
    
    [self addConstraints:@[checkConstraitRight,checkConstraitTop,chekBtViewConsraintWidth,chekBtViewConsraintHeight]];
    
    NSDictionary *checkImageViewMetric = @{@"sideLength":@25};
    NSString *checkImageViewVFLH = @"H:[_checkImageView(sideLength)]-3-|";
    NSString *checkImageVIewVFLV = @"V:|-3-[_checkImageView(sideLength)]";
    NSArray *checkImageConstraintsH = [NSLayoutConstraint constraintsWithVisualFormat:checkImageViewVFLH options:0 metrics:checkImageViewMetric views:NSDictionaryOfVariableBindings(_checkImageView)];
    NSArray *checkImageConstraintsV = [NSLayoutConstraint constraintsWithVisualFormat:checkImageVIewVFLV options:0 metrics:checkImageViewMetric views:NSDictionaryOfVariableBindings(_checkImageView)];
    
    [self addConstraints:checkImageConstraintsH];
    [self addConstraints:checkImageConstraintsV];
}

- (UIImageView *)imageView
{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [_imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addSubview:_imageView];
    }
    return _imageView;
}

- (UIButton *)checkButton
{
    if (_checkButton == nil) {
        _checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_checkButton addTarget:self action:@selector(checkButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_checkButton setTranslatesAutoresizingMaskIntoConstraints:NO];
        _checkButton.hidden = YES;
        [self addSubview:_checkButton];
    }
    return _checkButton;
}

- (UIImageView *)checkImageView
{
    if (_checkImageView == nil) {
        _checkImageView = [UIImageView new];
        _checkImageView.contentMode = UIViewContentModeScaleAspectFit;
        [_checkImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
        _checkImageView.hidden = YES;
        [self addSubview:_checkImageView];
    }
    return _checkImageView;
}

- (void)prepareForReuse
{
    _asset = nil;
    _isSelected = NO;
    _delegate = nil;
    _imageView.image = nil;
}

- (void)fillWithAsset:(ALAsset *)asset isSelected:(BOOL)seleted
{
    self.isSelected = seleted;
    self.asset = asset;
    CGImageRef thumbnailImageRef = [asset thumbnail];
    if (thumbnailImageRef) {
        self.imageView.image = [UIImage imageWithCGImage:thumbnailImageRef];
    }
}

- (void)setIsSelected:(BOOL)isSelected
{
    _isSelected = isSelected;
    self.checkButton.selected = _isSelected;
    [self updateCheckImageView];
}

- (void)updateCheckImageView
{
    if (self.checkButton.selected) {
        self.checkImageView.image = [UIImage imageNamed:@"selected"];
    } else {
        self.checkImageView.image = [UIImage imageNamed:@"selecte"];
    }
}

- (void)checkButtonAction:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickCell:)]) {
        [self.delegate didClickCell:self];
    }
//    if (self.checkButton.selected) {
//        if (self.delegate && [self.delegate respondsToSelector:@selector(didDeselectCell:)]) {
//            [self.delegate didDeselectCell:self];
//        }
//    } else {
//        if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectCell:)]) {
//            [self.delegate didSelectCell:self];
//        }
//    }
}

- (void)setEditing:(BOOL)editing
{
    _editing = editing;
    _checkButton.hidden = !_editing;
    _checkImageView.hidden = !_editing;
}

@end
