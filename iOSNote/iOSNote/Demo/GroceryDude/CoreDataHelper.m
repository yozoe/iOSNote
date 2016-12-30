//
//  CoreDataHelper.m
//  iOSNote
//
//  Created by wangdong on 2016/12/28.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import "CoreDataHelper.h"

@implementation CoreDataHelper

#define debug 1

#pragma mark - FILES

NSString *storeFilename = @"Grocery-Dude.sqlite";

#pragma mark - PATHS

- (NSString *)applicationDocumentsDirectory
{
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

- (NSURL *)applicationStoresDirectory
{
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    NSURL *storesDirectory = [[NSURL fileURLWithPath:[self applicationDocumentsDirectory]] URLByAppendingPathComponent:@"Stores"];
    NSFileManager *fileManger = [NSFileManager defaultManager];
    if (![fileManger fileExistsAtPath:[storesDirectory pathExtension]]) {
        NSError *error = nil;
        if ([fileManger createDirectoryAtURL:storesDirectory withIntermediateDirectories:YES attributes:nil error:&error]) {
            if (debug == 1) {
                NSLog(@"Successfully cereated Stores directory");
            }
        }
        else {
            NSLog(@"FAILED to create Stores directory: %@", error);
        }
    }
    return storesDirectory;
}

- (NSURL *)storeURL
{
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    return [[self applicationStoresDirectory] URLByAppendingPathComponent:storeFilename];
}

- (instancetype)init
{
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    if (self = [super init]) {
        
        //此方法会用main budle中的全部数据模型文件来初始化此对象.
//        _model = [NSManagedObjectModel mergedModelFromBundles:nil];
        
        _model = [[NSManagedObjectModel alloc] initWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"]];
        
        _coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_model];
        
        _context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [_context setPersistentStoreCoordinator:_coordinator];
    }
    return self;
}

- (void)loadStore
{
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    if (_store) {
        return;
    }
    
    NSDictionary *options = @{NSSQLitePragmasOption:@{@"journal_mode":@"DELETE"}};
    
    NSError *error = nil;
    _store = [_coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[self storeURL] options:options error:&error];
    if (!_store) {
        NSLog(@"Filed to add store. Error: %@", error);
        abort();
    }
    else {
        if (debug == 1) {
            NSLog(@"Successfully added store : %@", _store);
        }
    }
}

- (void)setupCoreData
{
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    [self loadStore];
}

- (void)saveContext
{
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    if ([_context hasChanges]) {
        NSError *error = nil;
        if ([_context save:&error]) {
            NSLog(@"_context SAVED changes to persistent store");
        }
        else {
            NSLog(@"Failed to save _context: %@", error);
        }
    }
    else {
        NSLog(@"SKIPPED _context save, there are no changes!");
    }
}

@end
