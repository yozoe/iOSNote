//
//  UploadPhotoModel.h
//  iOSNote
//
//  Created by wangdong on 16/5/24.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ALAsset;

typedef enum : NSUInteger {
    ImageFromServer,
    ImageFromDB,
    ImageFromLibrary,
} ImageFrom;

@interface UploadPhotoModel : NSObject

@property (nonatomic, assign) ImageFrom imageFrom;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) ALAsset *asset;
@property (nonatomic, assign) BOOL selected;

@end
