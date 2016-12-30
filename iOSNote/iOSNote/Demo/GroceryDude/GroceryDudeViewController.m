//
//  GroceryDudeViewController.m
//  iOSNote
//
//  Created by wangdong on 2016/12/28.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import "GroceryDudeViewController.h"
#import "Item+CoreDataClass.h"

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
//    NSArray *newItemNames = [NSArray arrayWithObjects:@"Apple", @"Milk", @"Bread", @"Cheese", @"Sausages", nil];
//    
//    for (NSString *newItemName in newItemNames) {
//        Item *newItem = [NSEntityDescription insertNewObjectForEntityForName:@"Item" inManagedObjectContext:_coreDataHelper.context];
//        newItem.name = newItemName;
//        NSLog(@"Inserted NEW Managed Object for '%@'", newItem.name);
//    }
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Item"];
    
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObject:sort]];
    
    NSArray *fetchObjects = [_coreDataHelper.context executeFetchRequest:request error:nil];

    
    for (Item *item in fetchObjects) {
        NSLog(@"%@", item.name);
    }
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
