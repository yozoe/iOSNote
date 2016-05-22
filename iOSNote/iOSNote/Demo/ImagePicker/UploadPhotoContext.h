//
//  UploadAssetContext.h
//  iOSNote
//
//  Created by wangdong on 16/5/19.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *kSavedPhotoGroupKey = @"kSavedPhotoGroupKey";

@class ALAsset;

@protocol UploadAssetContextDelegate  <NSObject>

- (void)groupAssetLoadFinished;

@end

@interface UploadPhotoContext : NSObject

@property (nonatomic, weak) id<UploadAssetContextDelegate> delegate;
@property (nonatomic, strong) NSMutableArray *selectedAssetsArray;
@property (nonatomic, strong) NSMutableArray *previewAssetesArray;
@property (nonatomic, strong) NSString *groupName;
@property (nonatomic, assign) NSInteger previewAssetesCount;

+ (UploadPhotoContext *)context;
- (void)loadGroupAssetsWithURL:(NSURL *)url;
- (NSArray *)fetchAssets;
- (void)addSelectedAsset:(ALAsset *)asset;
- (void)insertSelectedAsset:(ALAsset *)asset atIndex:(NSInteger)index;
- (void)removeSelectedAsset:(ALAsset *)asset;
- (BOOL)isSelectedAsset:(ALAsset *)targetAsset;
- (void)initPreviewAssets;
- (void)togglePreviewSelectedAsset:(ALAsset *)asset index:(NSInteger)index selected:(void (^)(BOOL))block;
- (BOOL)savePhotoGroupID;
- (NSString *)loadPhotoGourpID;

@end
