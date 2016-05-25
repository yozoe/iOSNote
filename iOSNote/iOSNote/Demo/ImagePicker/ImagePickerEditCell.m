//
//  ImagePickerEditCell.m
//  iOSNote
//
//  Created by wangdong on 16/5/18.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import "ImagePickerEditCell.h"
#import "UploadPhotoModel.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface ImagePickerEditCell()

@property (nonatomic, strong) UIImage *image;

@end

@implementation ImagePickerEditCell

- (void)setModel:(UploadPhotoModel *)model
{
    _model = model;
    
    switch (_model.imageFrom) {
        case ImageFromDB:
        {
            [self db];
        }
            break;
        case ImageFromServer:
        {
            [self server];
        }
            break;
        case ImageFromLibrary:
        {
            CGImageRef iref = [model.asset thumbnail];
            if (iref) {
                self.image = [UIImage imageWithCGImage:iref];
            }
            self.imageView.image = self.image;
        }
            break;
    }
    
    self.isSelected = model.selected;
}

- (void)db
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @autoreleasepool {
            @try {
                ALAssetsLibrary *assetslibrary = [[ALAssetsLibrary alloc] init];
                [assetslibrary assetForURL:self.model.url
                               resultBlock:^(ALAsset *asset){
                                   
                                   CGImageRef iref = [asset thumbnail];
                                   if (iref) {
                                       self.image = [UIImage imageWithCGImage:iref];
                                   }
                                   [self performSelectorOnMainThread:@selector(imageLoadingComplete) withObject:asset waitUntilDone:NO];
                               }
                              failureBlock:^(NSError *error) {
                                  self.image = nil;
                                  [self performSelectorOnMainThread:@selector(imageLoadingComplete) withObject:nil waitUntilDone:NO];
                              }];
            } @catch (NSException *e) {
                [self performSelectorOnMainThread:@selector(imageLoadingComplete) withObject:nil waitUntilDone:NO];
            }
        }
    });
}

- (void)server
{
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:@"https://ss0.bdstatic.com/5aV1bjqh_Q23odCf/static/superman/img/logo/bd_logo1_31bdc765.png"]
                      placeholderImage:nil];
}

- (void)imageLoadingComplete
{
//    [self fillWithAsset:asset isSelected:YES];
    self.imageView.image = self.image;
}

- (void)dealloc
{
    NSLog(@"%s", __func__);
}

@end
