//
//  GDPrepareViewController.m
//  iOSNote
//
//  Created by wangdong on 2017/1/7.
//  Copyright © 2017年 yozoe. All rights reserved.
//

#import "GDPrepareViewController.h"

@interface GDPrepareViewController ()

@end

@implementation GDPrepareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureFetch];
    [self performFetch];
    
    self.clearConfirmActionSheet.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(performFetch) name:@"SomethingChanged" object:nil];
}

- (void)configureFetch
{
    CoreDataHelper *cdh = [CoreDataHelper cdh];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Item"];
    
    //一定要主意:该值必须和NSFetchRequest里首个NSSortDescriptor所使用的值相符.
    request.sortDescriptors = [NSArray arrayWithObjects:[NSSortDescriptor sortDescriptorWithKey:@"locationAtHome.storedIn" ascending:YES], [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES], nil];
    [request setFetchLimit:50];
    
    self.frc = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:cdh.context sectionNameKeyPath:@"locationAtHome.storedIn" cacheName:nil];
    self.frc.delegate = self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Item Cell";
    UITableViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.accessoryType = UITableViewCellAccessoryDetailButton;
    Item *item = [self.frc objectAtIndexPath:indexPath];
    NSMutableString *title = [NSMutableString stringWithFormat:@"%0.2f%@ %@", item.quantity, item.unit.name, item.name];
    cell.textLabel.text = title;
    
    if (item.listed) {
        [cell.textLabel setTextColor:[UIColor orangeColor]];
    }
    else {
        [cell.textLabel setTextColor:[UIColor grayColor]];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Item *deleteTarget = [self.frc objectAtIndexPath:indexPath];
        [self.frc.managedObjectContext deleteObject:deleteTarget];
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObjectID *itemid = [[self.frc objectAtIndexPath:indexPath] objectID];
    Item *item = (Item *)[self.frc.managedObjectContext existingObjectWithID:itemid error:nil];
    
    if (item.listed) {
        item.listed = NO;
    }
    else {
        item.listed = YES;
        item.collected = NO;
    }
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

- (IBAction)clear:(id)sender
{
    CoreDataHelper *cdh = [CoreDataHelper cdh];
    
    NSFetchRequest *request = [cdh.model fetchRequestTemplateForName:@"ShoppingList"];
    
    NSArray *shoppingList = [cdh.context executeFetchRequest:request error:nil];
    
    if (shoppingList.count > 0) {
        self.clearConfirmActionSheet = [[UIActionSheet alloc] initWithTitle:@"Clear Entire Shopping List?" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Clear" otherButtonTitles:nil, nil];
        [self.clearConfirmActionSheet showFromTabBar:self.navigationController.tabBarController.tabBar];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Nothing to Clear" message:@"Add items to the Shop tab by tapping them on the Prepare tab. Remove all times from the Shop tab by clicking Clear on the Prepare tab" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet == self.clearConfirmActionSheet) {
        if (buttonIndex == [actionSheet destructiveButtonIndex]) {
            [self performSelector:@selector(clearList)];
        }
        else if (buttonIndex == [actionSheet cancelButtonIndex]) {
            [actionSheet dismissWithClickedButtonIndex:[actionSheet cancelButtonIndex] animated:YES];
        }
    }
}

- (void)clearList
{
    CoreDataHelper *cdh = [CoreDataHelper cdh];
    
    NSFetchRequest *request = [cdh.model fetchRequestTemplateForName:@"ShoppingList"];
    NSArray *shoppingList = [cdh.context executeFetchRequest:request error:nil];
    
    for (Item *item in shoppingList) {
        item.listed = NO;
    }
}

@end
