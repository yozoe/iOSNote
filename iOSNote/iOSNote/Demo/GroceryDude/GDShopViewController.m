//
//  GDShopViewController.m
//  iOSNote
//
//  Created by wangdong on 2017/1/8.
//  Copyright © 2017年 yozoe. All rights reserved.
//

#import "GDShopViewController.h"
#import "GDItemViewController.h"

@interface GDShopViewController ()

@end

@implementation GDShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureFetch];
    [self performFetch];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(performFetch) name:@"SomethingChanged" object:nil];
}

- (void)configureFetch
{
    CoreDataHelper *cdh = [CoreDataHelper cdh];
    
    //若要修改,必须拷贝
    NSFetchRequest *request = [[cdh.model fetchRequestTemplateForName:@"ShoppingList"] copy];
    
    request.sortDescriptors = [NSArray arrayWithObjects:[NSSortDescriptor sortDescriptorWithKey:@"locationAtShop.aisle" ascending:YES], [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES], nil];
    
    [request setFetchBatchSize:50];
    
    self.frc = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:cdh.context sectionNameKeyPath:@"locationAtShop.aisle" cacheName:nil];
    
    self.frc.delegate = self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Shop Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    Item *item = [self.frc objectAtIndexPath:indexPath];
    
    NSMutableString *title = [NSMutableString stringWithFormat:@"%.2f%@ %@", item.quantity, item.unit.name, item.name];
    [title replaceOccurrencesOfString:@"(null)" withString:@"" options:0 range:NSMakeRange(0, [title length])];
    cell.textLabel.text = title;
    
    if (item.collected) {
        [cell.textLabel setTextColor:[UIColor colorWithRed:0.368627450 green:0.741176470 blue:0.349019601 alpha:1.0]];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else {
        cell.textLabel.textColor = [UIColor orangeColor];
        cell.accessoryType = UITableViewCellAccessoryDetailButton;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Item *item = [self.frc objectAtIndexPath:indexPath];
    
    if (item.collected) {
        item.collected = NO;
    }
    else {
        item.collected = YES;
    }
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return nil;
}

- (IBAction)clear:(id)sender
{
    if ([self.frc.fetchedObjects count] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Nothing to Clear" message:@"Add items using the Prepare tab" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    BOOL nothingCleared = YES;
    
    for (Item *item in self.frc.fetchedObjects) {
        if (item.collected) {
            item.listed = NO;
            item.collected = NO;
            nothingCleared = NO;
        }
    }
    if (nothingCleared) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Select items to be removed from the list before pressing Clear" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    GDItemViewController *itemVC = segue.destinationViewController;
    if ([segue.identifier isEqualToString:@"Add Item Segue"]) {
        CoreDataHelper *cdh = [CoreDataHelper cdh];
        Item *newItem = [NSEntityDescription insertNewObjectForEntityForName:@"Item" inManagedObjectContext:cdh.context];
        NSError *error = nil;
        
        if (![cdh.context obtainPermanentIDsForObjects:[NSArray arrayWithObject:newItem] error:&error]) {
            NSLog(@"Couldn't obtain a permanent ID for object %@", error);
        }
        itemVC.selectedItemID = newItem.objectID;
    }
    else {
        NSLog(@"Unidentified Segue Attempted!");
    }
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    GDItemViewController *itemVC = [self.storyboard instantiateViewControllerWithIdentifier:@"GDItemViewController"];
    itemVC.selectedItemID = [[self.frc objectAtIndexPath:indexPath] objectID];
    [self.navigationController pushViewController:itemVC animated:YES];
}

@end
