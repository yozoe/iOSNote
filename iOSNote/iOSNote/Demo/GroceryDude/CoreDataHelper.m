//
//  CoreDataHelper.m
//  iOSNote
//
//  Created by wangdong on 2016/12/28.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import "CoreDataHelper.h"
#import "GroceryDudeViewController.h"

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
    
    BOOL useMigrationManager = YES;
    
    if (useMigrationManager && [self isMigrationNecessaryForStore:[self storeURL]]) {
        [self performBackgroundManagedMigrationForStore:[self storeURL]];
    }
    else {
        /*
         NSMigratePersistentStoresAutomaticallyOption 是YES,那么coredata会试着把低版本的持久化存储区迁移到最新版本的模型
         NSInferMappingModelAutomaticallyOption 是YES,那么coredata就会试着以最为合理的方式自动推断出源模型尸体中的某个属性到底对应于"目标模型实体"中的哪一个属性
         */
        NSDictionary *options = @{
                                  NSMigratePersistentStoresAutomaticallyOption:@YES,
                                  NSInferMappingModelAutomaticallyOption:@YES,
                                  NSSQLitePragmasOption:@{@"journal_mode":@"DELETE"}
                                  };
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

- (BOOL)isMigrationNecessaryForStore:(NSURL *)storeUrl
{
    if (![[NSFileManager defaultManager] fileExistsAtPath:[self storeURL].path]) {
        return NO;
    }
    
    NSError *error = nil;
    NSDictionary *sourceMetadata = [NSPersistentStoreCoordinator metadataForPersistentStoreOfType:NSSQLiteStoreType URL:storeUrl options:nil error:&error];
    NSManagedObjectModel *destinationModel = _coordinator.managedObjectModel;
    if ([destinationModel isConfiguration:nil compatibleWithStoreMetadata:sourceMetadata]) {
        return NO;
    }
    return YES;
}

- (BOOL)migrateStore:(NSURL *)sourceStore
{
    BOOL success = NO;
    NSError *error = nil;
    
    NSDictionary *sourceMetadata = [NSPersistentStoreCoordinator metadataForPersistentStoreOfType:NSSQLiteStoreType URL:sourceStore options:nil error:&error];
    NSManagedObjectModel *sourceModel = [NSManagedObjectModel mergedModelFromBundles:nil forStoreMetadata:sourceMetadata];
    
    NSManagedObjectModel *destinModel = _model;
    
    NSMappingModel *mappingModel = [NSMappingModel mappingModelFromBundles:nil forSourceModel:sourceModel destinationModel:destinModel];
    
    if (mappingModel) {
        NSError *error = nil;
        NSMigrationManager *migrationManager = [[NSMigrationManager alloc] initWithSourceModel:sourceModel destinationModel:destinModel];
        
        [migrationManager addObserver:self forKeyPath:@"migrationProgress" options:NSKeyValueObservingOptionNew context:NULL];
        
        NSURL *destinStore = [[self applicationStoresDirectory] URLByAppendingPathComponent:@"Temp.sqlite"];
        
        success = [migrationManager migrateStoreFromURL:sourceStore
                                                   type:NSSQLiteStoreType
                                                options:nil
                                       withMappingModel:mappingModel
                                       toDestinationURL:destinStore
                                        destinationType:NSSQLiteStoreType
                                     destinationOptions:nil
                                                  error:&error];
        
        if (success) {
            if ([self replaceStore:sourceStore withStore:destinStore]) {
                [migrationManager removeObserver:self forKeyPath:@"migrationProgress"];
            }
        }
        else {
            if (debug == 1) {NSLog(@"FAILED MIGRATION %@", error);};
        }
    }
    else {
        if (debug == 1) {NSLog(@"FAILED MIGRATION: Mapping Model is null ");};
    }
    
    return YES;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"migrationProgress"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            float progress = [[change objectForKey:NSKeyValueChangeNewKey] floatValue];
            self.migrationVC.progressView.progress = progress;
            int percentage = progress * 100;
            NSString *string = [NSString stringWithFormat:@"Migration Progress: %i%%", percentage];
            NSLog(@"%@", string);
            self.migrationVC.label.text = string;
        });
    }
}

- (BOOL)replaceStore:(NSURL *)old withStore:(NSURL *)new
{
    BOOL success = NO;
    NSError *Error = nil;
    
    if ([[NSFileManager defaultManager] removeItemAtURL:old error:&Error]) {
        Error = nil;
        if ([[NSFileManager defaultManager] moveItemAtURL:new toURL:old error:&Error]) {
            success = YES;
        }
        else {
            if (debug == 1) {NSLog(@"FAILED to re-home new store %@", Error);};
        }
    }
    else {
        if (debug == 1) {
            NSLog(@"FAILED to remove old store %@: Error:%@", old, Error);
        }
    }
    return success;
}

- (void)performBackgroundManagedMigrationForStore:(NSURL *)storeURL
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"GroceryDude" bundle:nil];
    self.migrationVC = [sb instantiateViewControllerWithIdentifier:@"migration"];
    UIApplication *sa = [UIApplication sharedApplication];
    UINavigationController *nc = (UINavigationController *)sa.keyWindow.rootViewController;
    [nc presentViewController:self.migrationVC animated:NO completion:nil];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        BOOL done = [self migrateStore:storeURL];
        if (done) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSError *error = nil;
                _store = [_coordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                    configuration:nil
                                                              URL:[self storeURL]
                                                          options:nil
                                                            error:&error];
                if (!_store) {
                    NSLog(@"Failed to add a migrated store. Error: %@", error);
                    abort();
                }
                else {
                    NSLog(@"Successfully added a migrated store: %@", _store);
                    [self.migrationVC dismissViewControllerAnimated:NO completion:nil];
                    self.migrationVC = nil;
                }
            });
        }
    });
}

@end
