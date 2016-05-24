//
//  AddPlayerViewController.m
//  CoreDataDemo
//
//  Created by wangdong on 16/5/23.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import "AddPlayerViewController.h"
#import "Player.h"
#import "Team.h"
#import "ViewController.h"

@interface AddPlayerViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *ageTextField;

@end

@implementation AddPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)handleAddButtonAction:(id)sender {
    Player *playerObject = [NSEntityDescription insertNewObjectForEntityForName:@"Player" inManagedObjectContext:self.viewController.managedObjectContext];
    playerObject.name = self.nameTextField.text;
    playerObject.age = [NSNumber numberWithInteger:[self.ageTextField.text integerValue]];
    playerObject.team = self.team;
    [self.viewController saveContext];
}

@end
