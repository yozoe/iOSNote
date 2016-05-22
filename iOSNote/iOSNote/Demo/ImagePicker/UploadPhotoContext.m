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
            [self savePhotoGroupID];
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
}

- (void)addSelectedAsset:(ALAsset *)asset
{
    [self.selectedAssetsArray addObject:asset];
}

- (void)insertSelectedAsset:(ALAsset *)asset atIndex:(NSInteger)index
{
    [self.selectedAssetsArray insertObject:asset atIndex:index];
}

- (void)removeSelectedAsset:(ALAsset *)asset
{
    for (ALAsset *assetItem in self.selectedAssetsArray) {
        NSURL *assetURL = [assetItem valueForProperty:ALAssetPropertyAssetURL];
        NSURL *targetAssetURL = [asset valueForProperty:ALAssetPropertyAssetURL];
        if ([[assetURL absoluteString] isEqualToString:[targetAssetURL absoluteString]]) {
            
            if ([self.selectedAssetsArray containsObject:asset]) {
                [self.selectedAssetsArray removeObject:asset];
            }
            
            if ([self.selectedAssetsArray containsObject:assetItem]) {
                [self.selectedAssetsArray removeObject:assetItem];
            }
            
            break;
        }
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

- (void)initPreviewAssets
{
    self.previewAssetesArray = [self.selectedAssetsArray mutableCopy];
}

- (void)togglePreviewSelectedAsset:(ALAsset *)asset index:(NSInteger)index selected:(void (^)(BOOL))block
{
    BOOL flag = YES;
    if ([self isSelectedAsset:asset] && [self.previewAssetesArray containsObject:asset]) {
        [self.previewAssetesArray replaceObjectAtIndex:index withObject:[NSNull null]];
        flag = NO;
    } else {
        [self.previewAssetesArray replaceObjectAtIndex:index withObject:asset];
    }
    if (block) {
        block(flag);
    }
}

- (BOOL)savePhotoGroupID
{
    NSString *groupID = [self.assetsGroup valueForProperty:ALAssetsGroupPropertyPersistentID];
    if (groupID && groupID.length) {
        [[NSUserDefaults standardUserDefaults] setObject:groupID forKey:kSavedPhotoGroupKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return YES;
    }
    return NO;
}

- (NSString *)loadPhotoGourpID
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kSavedPhotoGroupKey];
}

- (NSInteger)previewAssetesCount
{
    NSInteger count = 0;
    for (id obj in _previewAssetesArray) {
        if (![obj isKindOfClass:[NSNull class]]) {
            count++;
        }
    }
    return count;
}

@end
