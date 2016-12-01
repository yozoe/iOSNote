//
//  PureLayoutDemoVC.m
//  iOSNote
//
//  Created by wangdong on 2016/11/30.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import "PureLayoutDemoVC.h"
#import "PureLayout.h"

@interface PureLayoutDemoVC ()
@property (weak, nonatomic) IBOutlet UIView *blueView;
@property (weak, nonatomic) IBOutlet UIView *redView;
@property (weak, nonatomic) IBOutlet UIView *yellowView;
@property (weak, nonatomic) IBOutlet UIView *greenView;

@end

@implementation PureLayoutDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self forArray];
}

- (void)forView
{
/*
 - autoSetContent(CompressionResistance|Hugging)PriorityForAxis: - autoCenterInSuperview(Margins) // Margins variant iOS 8.0+ only
 - autoAlignAxisToSuperview(Margin)Axis: // Margin variant iOS 8.0+ only
 - autoPinEdgeToSuperview(Edge:|Margin:)(withInset:) // Margin variant iOS 8.0+ only
 - autoPinEdgesToSuperview(Edges|Margins)(WithInsets:)(excludingEdge:) // Margins variant iOS 8.0+ only
 - autoPinEdge:toEdge:ofView:(withOffset:)
 - autoAlignAxis:toSameAxisOfView:(withOffset:|withMultiplier:)
 - autoMatchDimension:toDimension:ofView:(withOffset:|withMultiplier:)
 - autoSetDimension(s)ToSize:
 - autoConstrainAttribute:toAttribute:ofView:(withOffset:|withMultiplier:)
 - autoPinTo(Top|Bottom)LayoutGuideOfViewController:withInset: // iOS only
 */
    
    [self.blueView autoCenterInSuperview];
    [self.blueView autoSetDimensionsToSize:CGSizeMake(50, 50)];
    
    [self.redView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.blueView];
    [self.redView autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.blueView];
    [self.redView autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.blueView];
    [self.redView autoSetDimension:ALDimensionHeight toSize:40.f];
    
    [self.yellowView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.redView withOffset:10.f];
    [self.yellowView autoSetDimension:ALDimensionHeight toSize:25.f];
    [self.yellowView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20.f];
    [self.yellowView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20.f];
    
    [self.greenView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.yellowView withOffset:10.f];
    [self.greenView autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.greenView autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:self.yellowView withMultiplier:2.0];
    [self.greenView autoSetDimension:ALDimensionWidth toSize:150.f];
}

- (void)forArray
{
/*
 // Arrays of Views
 - autoAlignViewsToEdge:
 - autoAlignViewsToAxis:
 - autoMatchViewsDimension:
 - autoSetViewsDimension:toSize:
 - autoSetViewsDimensionsToSize:
 - autoDistributeViewsAlongAxis:alignedTo:withFixedSpacing:(insetSpacing:)(matchedSizes:)
 - autoDistributeViewsAlongAxis:alignedTo:withFixedSize:(insetSpacing:)
 */
    
    [@[self.redView, self.yellowView] autoSetViewsDimension:ALDimensionHeight toSize:50.f];
    [@[self.blueView, self.greenView] autoSetViewsDimension:ALDimensionHeight toSize:70.f];
    
    NSArray *views = @[self.redView, self.blueView, self.yellowView, self.greenView];
    [views autoMatchViewsDimension:ALDimensionWidth];
    [self.redView autoPinToTopLayoutGuideOfViewController:self withInset:20.f];
    [[views firstObject] autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    UIView *previousView = nil;
    for (UIView *view in views) {
        if (previousView) {
            [view autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:previousView];
            [view autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:previousView];
        }
        previousView = view;
    }
    [[views lastObject] autoPinEdgeToSuperviewEdge:ALEdgeRight];
    
}

@end
