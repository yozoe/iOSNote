//
//  ImagePickerCell.h
//  iOSNote
//
//  Created by wangdong on 16/5/17.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ALAsset;
@class ImagePickerCell;

@protocol ImagePickerCellDelegate <NSObject>

- (void)didClickCell:(ImagePickerCell *)cell;

@end

@interface ImagePickerCell : UICollectionViewCell

@property (nonatomic, strong) ALAsset *asset;
@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, weak) id<ImagePickerCellDelegate> delegate;
@property (nonatomic, assign) BOOL editing;

- (void)fillWithAsset:(ALAsset *)asset isSelected:(BOOL)seleted;

@end
