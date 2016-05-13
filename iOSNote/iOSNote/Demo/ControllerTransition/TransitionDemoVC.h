//
//  TransitionDemoVC.h
//  iOSNote
//
//  Created by wangdong on 16/5/13.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TDModel;
@class TDDemoCell;

@interface TransitionDemoVC : UICollectionViewController

- (TDDemoCell *)collectionViewCellForThing:(TDModel *)model;

@end
