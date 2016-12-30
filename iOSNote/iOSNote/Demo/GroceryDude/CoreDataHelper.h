//
//  CoreDataHelper.h
//  iOSNote
//
//  Created by wangdong on 2016/12/28.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataHelper : NSObject

@property (nonatomic, readonly) NSManagedObjectContext *context;
@property (nonatomic, readonly) NSManagedObjectModel *model;
@property (nonatomic, readonly) NSPersistentStoreCoordinator *coordinator;
@property (nonatomic, readonly) NSPersistentStore *store;

- (void)setupCoreData;
- (void)saveContext;

@end
