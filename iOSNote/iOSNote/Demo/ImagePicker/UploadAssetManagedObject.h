//
//  UploadAssetEntity.h
//  iOSNote
//
//  Created by wangdong on 16/5/24.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface UploadAssetManagedObject : NSManagedObject

@property (nonatomic, strong) NSNumber *state;
@property (nonatomic, strong) NSString *url;

@end
