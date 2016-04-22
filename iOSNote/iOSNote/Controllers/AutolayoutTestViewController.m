//
//  AutolayoutTestViewController.m
//  iOSNote
//
//  Created by wangdong on 16/4/22.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import "AutolayoutTestViewController.h"

@implementation AutolayoutTestViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIView *view = [UIView new];
    [view setBackgroundColor:[UIColor redColor]];
    
    [self.view addSubview:view];
    
    CGRect viewFrame = CGRectMake(50, 100, 150, 150);
    
    [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSLayoutConstraint *viewLeft = [NSLayoutConstraint constraintWithItem:view
                                                                attribute:NSLayoutAttributeLeading
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.view
                                                                attribute:NSLayoutAttributeLeading
                                                               multiplier:1
                                                                 constant:CGRectGetMinX(viewFrame)];
    
    NSLayoutConstraint *viewTop = [NSLayoutConstraint constraintWithItem:view
                                                               attribute:NSLayoutAttributeTop
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.view
                                                               attribute:NSLayoutAttributeTop
                                                              multiplier:1
                                                                constant:CGRectGetMinY(viewFrame)];

    NSLayoutConstraint *viewWidth = [NSLayoutConstraint constraintWithItem:view
                                                                 attribute:NSLayoutAttributeWidth
                                                                 relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                    toItem:nil
                                                                 attribute:NSLayoutAttributeNotAnAttribute
                                                                multiplier:1
                                                                  constant:CGRectGetWidth(viewFrame)];

    NSLayoutConstraint *viewHeight = [NSLayoutConstraint constraintWithItem:view
                                                                  attribute:NSLayoutAttributeHeight
                                                                  relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                     toItem:nil
                                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                                 multiplier:1
                                                                   constant:CGRectGetHeight(viewFrame)];
    
    [self.view addConstraints:@[viewLeft, viewTop, viewWidth, viewHeight]];
}

@end
