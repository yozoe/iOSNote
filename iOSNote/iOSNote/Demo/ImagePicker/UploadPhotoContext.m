//
//  UploadAssetContext.m
//  iOSNote
//
//  Created by wangdong on 16/5/19.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import "UploadPhotoContext.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface UploadPhotoContext()

@property (nonatomic, strong) ALAssetsLibrary *assetsLibrary;
@property (nonatomic, strong) ALAssetsGroup *assetsGroup;
@property (nonatomic, strong) NSMutableArray *assetsArray;

@end

@implementation UploadPhotoContext

- (instancetype)init
{
    if (self = [super init]) {
        _selectedAssetsArray = [NSMutableArray new];
        _assetsArray = [NSMutableArray new];
        _assetsLibrary = [[ALAssetsLibrary alloc] init];
    }
    return self;
}

+ (UploadPhotoContext *)context
{
    static dispatch_once_t pred = 0;
    static UploadPhotoContext *context = nil;
    dispatch_once(&pred, ^{
        context = [[UploadPhotoContext alloc] init];
    });
    return context;
}

- (void)loadGroupAssetsWithURL:(NSURL *)url
{
    [_assetsLibrary groupForURL:url resultBlock:^(ALAssetsGroup *group) {
        self.assetsGroup = group;
        if (self.assetsGroup) {
            
            [self resetGroupAssets];

            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [self.assetsGroup enumerateAssetsWithOptions:NSEnumerationReverse usingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                    if (result) {
                        [_assetsArray insertObject:result atIndex:0];
                    }
                }];
                dispatch_async(dispatch_get_main_queue(), ^{
                    if ([_delegate respondsToSelector:@selector(groupAssetLoadFinished)]) {
                        [_delegate groupAssetLoadFinished];
                    }
                });
            });
        }
    } failureBlock:^(NSError *error) {
        
    }];
}

- (NSArray *)fetchAssets
{
    return _assetsArray;
}

- (void)resetGroupAssets
{
    [_assetsArray removeAllObjects];
    [_selectedAssetsArray removeAllObjects];
}

- (void)addSelectedAsset:(ALAsset *)asset
{
    [self.selectedAssetsArray addObject:asset];
}

- (void)removeSelectedAsset:(ALAsset *)asset
{
    if ([self isSelectedAsset:asset]) {
        [self.selectedAssetsArray removeObject:asset];
    }
}

- (BOOL)isSelectedAsset:(ALAsset *)targetAsset
{
    for (ALAsset *asset in self.selectedAssetsArray) {
        NSURL *assetURL = [asset valueForProperty:ALAssetPropertyAssetURL];
        NSURL *targetAssetURL = [targetAsset valueForProperty:ALAssetPropertyAssetURL];
        if ([[assetURL absoluteString] isEqualToString:[targetAssetURL absoluteString]]) {
            return YES;
        }
    }
    return NO;
}

- (NSString *)groupName
{
    return _assetsGroup ? [_assetsGroup valueForProperty:ALAssetsGroupPropertyName] : @"";
}

@end
