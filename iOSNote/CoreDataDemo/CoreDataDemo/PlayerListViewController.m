//
//  PlayerListViewController.m
//  CoreDataDemo
//
//  Created by wangdong on 16/5/23.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import "PlayerListViewController.h"
#import "Player.h"
#import "Team.h"
#import "AddPlayerViewController.h"
#import "ViewController.h"

@interface PlayerListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation PlayerListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"PlayerCell"];
    
    NSLog(@"%@", [self fetchPlayerList]);
}

- (NSArray *)fetchPlayerList
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *teamEntity = [NSEntityDescription entityForName:@"Player" inManagedObjectContext:self.viewController.managedObjectContext];
    [fetchRequest setEntity:teamEntity];
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"age"ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"team == %@", self.team];
    [fetchRequest setPredicate:predicate];
    
    NSError *error = NULL;
    NSArray *array = [self.viewController.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (error) {
        NSLog(@"Error : %@\n", [error localizedDescription]);
    }
    
    return array;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PlayerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = @"hehe";
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[AddPlayerViewController class]]) {
        AddPlayerViewController *addPlayerViewController = segue.destinationViewController;
        addPlayerViewController.team = self.team;
        addPlayerViewController.viewController = self.viewController;
    }
}

@end
