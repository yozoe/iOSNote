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
    
   
}

- (void)demo
{
    return;
    [self showUnitAndItemCount];

    NSFetchRequest *request =
    [NSFetchRequest fetchRequestWithEntityName:@"Unit"];
    
    NSPredicate *filter =
    [NSPredicate predicateWithFormat:@"name == %@", @"Kg"];
    
    [request setPredicate:filter];
    
    NSArray *kgUnit =
    [[[CoreDataHelper cdh] context] executeFetchRequest:request error:nil];
    
    for (Unit *unit in kgUnit) {
        
        [[[CoreDataHelper cdh] context] deleteObject:unit];
        NSLog(@"A kg unit object was deleted");
        
//        NSError *error;
//        
//        if ([unit validateForDelete:&error]) {
//            NSLog(@"Deleting '%@'", unit.name);
//             [_coreDataHelper.context deleteObject:unit];
//        }
//        else {
//            NSLog(@"Failed to delete %@, Error: %@", unit.name, error.localizedDescription);
//        }
    }
    
    NSLog(@"After deletion of the unit entiry");
    
    [self showUnitAndItemCount];
    [[CoreDataHelper cdh] saveContext];
    
//    Unit *kg =
//    [NSEntityDescription insertNewObjectForEntityForName:@"Unit" inManagedObjectContext:[[self cdh] context]];
//    
//    Item *oranges =
//    [NSEntityDescription insertNewObjectForEntityForName:@"Item" inManagedObjectContext:[[self cdh] context]];
//    
//    Item *bananas =
//    [NSEntityDescription insertNewObjectForEntityForName:@"Item" inManagedObjectContext:[[self cdh] context]];
//    
//    kg.name = @"Kg";
//    oranges.name = @"Oranges";
//    bananas.name = @"Bananas";
//    oranges.quantity = 1.f;
//    bananas.quantity = 4.f;
//    oranges.listed = YES;
//    bananas.listed = YES;
//    oranges.unit = kg;
//    bananas.unit = kg;
//    
//    NSLog(@"Inserted %f%@ %@",
//          oranges.quantity, oranges.unit.name, oranges.name);
//    NSLog(@"Inserted %f%@ %@",
//          bananas.quantity, bananas.unit.name, bananas.name);
//    
//    [[self cdh] saveContext];
    
    
    
//    for (int i = 1; i < 5000; i++) {
//        Measurement *newMeasurement = [NSEntityDescription insertNewObjectForEntityForName:@"Measurement" inManagedObjectContext:_coreDataHelper.context];
//        newMeasurement.abc = [NSString stringWithFormat:@"-->> LOTS OF TEST DATA x%i", i];
//        NSLog(@"Inserted %@", newMeasurement.abc);
//    }
    
//    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Unit"];
//    [request setFetchLimit:50];
//    
//    NSError *error = nil;
//    
//    NSArray *fetchedObjects = [_coreDataHelper.context executeFetchRequest:request error:&error];
//    
//    if (error) {
//        NSLog(@"%@", error);
//    }
//    else {
//        for (Unit *unit in fetchedObjects) {
//            NSLog(@"Fetched Object = %@", unit.name);
//        }
//    }
    
    
    
    
    
    
    
    
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

- (void)showUnitAndItemCount
{
    NSFetchRequest *items = [NSFetchRequest fetchRequestWithEntityName:@"Item"];
    NSError *itemsError = nil;
    NSArray *fetchedItems = [[[CoreDataHelper cdh] context] executeFetchRequest:items error:&itemsError];
    
    if (!fetchedItems) {
        NSLog(@"%@", itemsError);
    }
    else {
        NSLog(@"Found %lu item(s) ", (unsigned long)[fetchedItems count]);
    }
    
    NSFetchRequest *units = [NSFetchRequest fetchRequestWithEntityName:@"Unit"];
    NSError *unitsError = nil;
    NSArray *fetchedUnits = [[[CoreDataHelper cdh] context] executeFetchRequest:units error:&unitsError];
    
    if (!fetchedUnits) {
        NSLog(@"%@", unitsError);
    }
    else {
        NSLog(@"Found %lu nits(s) ", (unsigned long)[fetchedUnits count]);
    }
}

@end
