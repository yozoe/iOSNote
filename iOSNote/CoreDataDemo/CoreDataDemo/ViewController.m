//
//  ViewController.m
//  CoreDataDemo
//
//  Created by wangdong on 16/5/23.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import "ViewController.h"
#import "Team.h"
#import "PlayerListViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *teamArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"TeamCell"];
    
    self.teamArray = [self fetchTeamList];
    
    
    
    [self createTeamWithName:@"Heat"city:@"Miami"];
    [self createTeamWithName:@"Lakers"city:@"LA"];
    
    return;
    
//    Team *teamObject = [NSEntityDescription insertNewObjectForEntityForName:@"Team" inManagedObjectContext:self.managedObjectContext];
//    teamObject.name = @"hehe";
//    teamObject.city = @"haha";
    
    [self saveContext];
    
    NSArray *teamArray = [self fetchTeamList];
    
    if (teamArray) {
        for (Team *teamObject in teamArray) {
//            NSString *teamName = [teamObject valueForKey:@"name"];
//            NSString *teamCity = [teamObject valueForKey:@"city"];
            NSLog(@"Team info: %@ %@\n", teamObject.name, teamObject.city);
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    //什么合并策略
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
    NSURL *storeUrl = [[self applicationStoreDirectory]URLByAppendingPathComponent:@"cdNBA.sqlite"];
    NSLog(@"storeurl = %@",storeUrl);
    return storeUrl;
}

- (BOOL)createTeamWithName:(NSString *)teamName city:(NSString *)teamCity
{
    if (!teamName || !teamCity) {
        return NO;
    }
    
    Team *teamObject = [self getTeamInfoByName:teamName];
    
    if (!teamObject) {
        teamObject = [NSEntityDescription insertNewObjectForEntityForName:@"Team" inManagedObjectContext:self.managedObjectContext];
    }
    
    teamObject.name = teamName;
    teamObject.city = teamCity;
    
//    NSManagedObject *teamObject = [NSEntityDescription insertNewObjectForEntityForName:@"Team" inManagedObjectContext:self.managedObjectContext];
//    [teamObject setValue:teamName forKey:@"name"];
//    [teamObject setValue:teamCity forKey:@"city"];
    
    [self saveContext];
    
    return YES;
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

- (NSArray *)fetchTeamList
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:@"Team" inManagedObjectContext:self.managedObjectContext]];
    
    NSError *error = nil;
    NSArray *array = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (error) {
        NSLog(@"error %@", [error description]);
    }
    return array;
}

- (Team *)getTeamInfoByName:(NSString *)teamName
{
    Team *teamObject = nil;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *teamEntity = [NSEntityDescription entityForName:@"Team" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:teamEntity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", teamName];
    [fetchRequest setPredicate:predicate];
    [fetchRequest setFetchLimit:1];
    
    NSError *error = nil;
    NSArray *array = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (error) {
        NSLog(@"error %@", [error description]);
    }
    
    if (array && [array count] > 0) {
        teamObject = [array objectAtIndex:0];
    }
    
    return teamObject;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.teamArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TeamCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    Team *teamObject = self.teamArray[indexPath.row];
    cell.textLabel.text = teamObject.name;
    cell.detailTextLabel.text = teamObject.city;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[PlayerListViewController class]]) {
        NSIndexPath *selectedIndexPath = self.tableView.indexPathForSelectedRow;
        if (selectedIndexPath != nil) {
            PlayerListViewController *playerListViewController = segue.destinationViewController;
            playerListViewController.viewController = self;
            playerListViewController.team = self.teamArray[selectedIndexPath.row];
        }
    }
}

@end
