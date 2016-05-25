//
//  UploadAssetDBHelper.h
//  iOSNote
//
//  Created by wangdong on 16/5/24.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UploadAssetDBHelper : NSObject

+ (UploadAssetDBHelper *)defaultHelper;
- (void)insertNewUploadAssetWithURL:(NSString *)url;
- (NSArray *)fetchAll;

@end
