//
//  UploadAssetContext.h
//  iOSNote
//
//  Created by wangdong on 16/5/19.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ALAsset;

@protocol UploadAssetContextDelegate  <NSObject>

- (void)groupAssetLoadFinished;

@end

@interface UploadPhotoContext : NSObject

@property (nonatomic, weak) id<UploadAssetContextDelegate> delegate;
@property (nonatomic, strong) NSMutableArray *selectedAssetsArray;
@property (nonatomic, strong) NSString *groupName;

+ (UploadPhotoContext *)context;
- (void)loadGroupAssetsWithURL:(NSURL *)url;
- (NSArray *)fetchAssets;
- (void)addSelectedAsset:(ALAsset *)asset;
- (void)removeSelectedAsset:(ALAsset *)asset;
- (BOOL)isSelectedAsset:(ALAsset *)targetAsset;

@end
