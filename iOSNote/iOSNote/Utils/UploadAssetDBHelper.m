//
//  UploadAssetDBHelper.m
//  iOSNote
//
//  Created by wangdong on 16/5/24.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import "UploadAssetDBHelper.h"
#import <CoreData/CoreData.h>
#import "UploadAssetManagedObject.h"

@interface UploadAssetDBHelper()

@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStroreCoordinator;

@end

@implementation UploadAssetDBHelper

+ (UploadAssetDBHelper *)defaultHelper
{
    static dispatch_once_t pred = 0;
    static UploadAssetDBHelper *helper = nil;
    dispatch_once(&pred, ^{
        helper = [[UploadAssetDBHelper alloc] init];
    });
    return helper;
}

- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel) {
        return _managedObjectModel;
    }
    _managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    return _managedObjectModel;
}

- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext) {
        return _managedObjectContext;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setMergePolicy:NSMergeByPropertyObjectTrumpMergePolicy];
    
    if (self.persistentStroreCoordinator) {
        [_managedObjectContext setPersistentStoreCoordinator:self.persistentStroreCoordinator];
    }
    
    return _managedObjectContext;
}

- (NSPersistentStoreCoordinator *)persistentStroreCoordinator
{
    if (_persistentStroreCoordinator) {
        return _persistentStroreCoordinator;
    }
    
    NSString *storeType = NSSQLiteStoreType;
    
    NSError *error = nil;
    
    
    _persistentStroreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                             [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
    
    if (![_persistentStroreCoordinator addPersistentStoreWithType:storeType configuration:nil URL:[self storeUrl] options:options error:&error]) {
        NSLog(@"error %@", [error description]);
    }
    
    return _persistentStroreCoordinator;
}

- (NSString *)applicationDocumentDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths lastObject];
}

- (NSURL *)applicationStoreDirectory
{
    NSURL *url = [[NSURL fileURLWithPath:[self applicationDocumentDirectory]] URLByAppendingPathComponent:@"stores"];
    if (![[NSFileManager defaultManager]fileExistsAtPath:[url path]]) {
        NSError *error = nil;
        BOOL success   = [[NSFileManager defaultManager]createDirectoryAtURL:url
                                                 withIntermediateDirectories:YES
                                                                  attributes:nil
                                                                       error:&error];
        if (success) {
            
            NSLog(@"success create directory!");
            
        }else{
            NSLog(@"failed create directory!");
        }
    }
    
    return url;
}

- (NSURL *)storeUrl
{
    NSURL *storeUrl = [[self applicationStoreDirectory]URLByAppendingPathComponent:@"upload_asset.sqlite"];
    NSLog(@"storeurl = %@",storeUrl);
    return storeUrl;
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *moc = self.managedObjectContext;
    if (moc && [moc hasChanges] && ![moc save:&error]) {
        NSLog(@"error %@", [error description]);
        abort();
    }
}

- (void)insertNewUploadAssetWithURL:(NSString *)url
{
    UploadAssetManagedObject *entity = [NSEntityDescription insertNewObjectForEntityForName:@"UploadAsset" inManagedObjectContext:self.managedObjectContext];
    entity.url = url;
    [self saveContext];
}

- (BOOL)isExistAssetURL:(NSString *)url
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *ed = [NSEntityDescription entityForName:@"UploadAsset" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:ed];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"url == %@", url];
    [fetchRequest setPredicate:predicate];
    [fetchRequest setFetchLimit:1];
    
    NSArray *array = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    if (array && array.count) {
        return YES;
    }
    return NO;
}

- (NSArray *)fetchAll
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *teamEntity = [NSEntityDescription entityForName:@"UploadAsset" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:teamEntity];
    
//    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"age"ascending:YES];
//    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"team == %@", self.team];
//    [fetchRequest setPredicate:predicate];
    
    NSError *error = NULL;
    NSArray *array = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (error) {
        NSLog(@"Error : %@\n", [error localizedDescription]);
    }
    
    return array;
}

@end
