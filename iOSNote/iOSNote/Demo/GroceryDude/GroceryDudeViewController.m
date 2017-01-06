//
//  GroceryDudeViewController.m
//  iOSNote
//
//  Created by wangdong on 2016/12/28.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import "GroceryDudeViewController.h"
#import "Item+CoreDataClass.h"
//#import "Measurement+CoreDataClass.h"
//#import "Amount+CoreDataClass.h"

#import "Unit+CoreDataClass.h"

@interface GroceryDudeViewController ()

@end

@implementation GroceryDudeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willTerminate) name:UIApplicationWillTerminateNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)demo
{
//    for (int i = 1; i < 5000; i++) {
//        Measurement *newMeasurement = [NSEntityDescription insertNewObjectForEntityForName:@"Measurement" inManagedObjectContext:_coreDataHelper.context];
//        newMeasurement.abc = [NSString stringWithFormat:@"-->> LOTS OF TEST DATA x%i", i];
//        NSLog(@"Inserted %@", newMeasurement.abc);
//    }
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Unit"];
    [request setFetchLimit:50];
    
    NSError *error = nil;
    
    NSArray *fetchedObjects = [_coreDataHelper.context executeFetchRequest:request error:&error];
    
    if (error) {
        NSLog(@"%@", error);
    }
    else {
        for (Unit *unit in fetchedObjects) {
            NSLog(@"Fetched Object = %@", unit.name);
        }
    }
//
    
//    NSArray *fetchedObjects = [];
    
    return;
    
//    NSArray *newItemNames = [NSArray arrayWithObjects:@"Apple", @"Milk", @"Bread", @"Cheese", @"Sausages", nil];
//    
//    for (NSString *newItemName in newItemNames) {
//        Item *newItem = [NSEntityDescription insertNewObjectForEntityForName:@"Item" inManagedObjectContext:_coreDataHelper.context];
//        newItem.name = newItemName;
//        NSLog(@"Inserted NEW Managed Object for '%@'", newItem.name);
//    }
    
//    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Item"];
    
//    NSFetchRequest *request = [[[_coreDataHelper model] fetchRequestTemplateForName:@"Test"] copy];
    
//    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
//    [request setSortDescriptors:[NSArray arrayWithObject:sort]];
    
//    NSPredicate *filter = [NSPredicate predicateWithFormat:@"name != %@", @"Sausages"];
//    [request setPredicate:filter];
    
//    NSArray *fetchObjects = [_coreDataHelper.context executeFetchRequest:request error:nil];

    
//    for (Item *item in fetchObjects) {
//        NSLog(@"%@", item.name);
//    }
}

- (void)didBecomeActive
{
    [self cdh];
    [self demo];
}

- (void)didEnterBackground
{
    [[self cdh] saveContext];
}

- (void)willTerminate
{
    [[self cdh] saveContext];
}

- (CoreDataHelper *)cdh
{
    if (!_coreDataHelper) {
        _coreDataHelper = [CoreDataHelper new];
        [_coreDataHelper setupCoreData];
    }
    return _coreDataHelper;
}

@end
