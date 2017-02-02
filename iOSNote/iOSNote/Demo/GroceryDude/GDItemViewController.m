//
//  GDItemViewController.m
//  iOSNote
//
//  Created by wangdong on 2017/1/8.
//  Copyright © 2017年 yozoe. All rights reserved.
//

#import "GDItemViewController.h"
#import "Item+CoreDataClass.h"
#import "LocationAtHome+CoreDataClass.h"
#import "LocationAtShop+CoreDataClass.h"

@interface GDItemViewController () <UITextFieldDelegate, CoreDataPickerTFDelegate>

@end

@implementation GDItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self hideKeyboardWhenBackgroundIsTapped];
    
//    self.unitPickerTextField.delegate = self;
//    self.unitPickerTextField.pickerDelegate = self;
    
    self.nameTextField.delegate = self;
    self.quantityTextField.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self ensureItemHomeLocationIsNotNull];
    [self ensureItemShopLocationIsNotNull];
    
    [self refreshInterface];
    if ([self.nameTextField.text isEqual:@"New Item"]) {
        self.nameTextField.text = @"";
        [self.nameTextField becomeFirstResponder];
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    CoreDataHelper *cdh = [CoreDataHelper cdh];
    [cdh saveContext];
}

- (IBAction)done:(id)sender
{
    [self hideKeyboard];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)hideKeyboardWhenBackgroundIsTapped
{
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [tgr setCancelsTouchesInView:NO];
    [self.view addGestureRecognizer:tgr];
}

- (void)hideKeyboard
{
    [self.view endEditing:YES];
}

- (void)selectedObjectID:(NSManagedObjectID *)objectID changedForPickerTF:(CoreDataPickerTF *)pickerTF
{
    
}

- (void)selectedObjectClearedForPickerTF:(CoreDataPickerTF *)pickerTF
{
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == self.nameTextField) {
        if ([self.nameTextField.text isEqualToString:@"New Item"]) {
            self.nameTextField.text = @"";
        }
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    CoreDataHelper *cdh = [CoreDataHelper cdh];
    
    Item *item = [cdh.context existingObjectWithID:self.selectedItemID error:nil];
    
    if (textField == self.nameTextField) {
        if ([self.nameTextField.text isEqualToString:@""]) {
            self.nameTextField.text = @"New Item";
        }
        item.name = self.nameTextField.text;
    }
    else if (textField == self.quantityTextField) {
        item.quantity = self.quantityTextField.text.floatValue;
    }
}

- (void)refreshInterface
{
    if (self.selectedItemID) {
        CoreDataHelper *cdh = [CoreDataHelper cdh];
        Item *item = [cdh.context existingObjectWithID:self.selectedItemID error:nil];
        self.nameTextField.text = item.name;
        self.quantityTextField.text = [NSString stringWithFormat:@"%f", item.quantity];
    }
}

- (void)ensureItemHomeLocationIsNotNull
{
    if (self.selectedItemID) {
        CoreDataHelper *cdh = [CoreDataHelper cdh];
        Item *item = [cdh.context existingObjectWithID:self.selectedItemID error:nil];
        if (!item.locationAtHome) {
            NSFetchRequest *request = [[cdh model] fetchRequestTemplateForName:@"UnknownLocationAtHome"];
            NSArray *fetchedObjects = [cdh.context executeFetchRequest:request error:nil];
            
            if ([fetchedObjects count] > 0) {
                item.locationAtHome = [fetchedObjects objectAtIndex:0];
            }
            else {
                LocationAtHome *locationAtHome = [NSEntityDescription insertNewObjectForEntityForName:@"LocationAtHome" inManagedObjectContext:cdh.context];
                NSError *error = nil;
                if (![cdh.context obtainPermanentIDsForObjects:[NSArray arrayWithObject:locationAtHome] error:&error]) {
                    NSLog(@"Couldn't obtain a permanent ID for object %@", error);
                }
                locationAtHome.storedIn = @"...UnknownLocation...";
                item.locationAtHome = locationAtHome;
            }
        }
    }
}

- (void)ensureItemShopLocationIsNotNull
{
    if (self.selectedItemID) {
        CoreDataHelper *cdh = [CoreDataHelper cdh];
        Item *item = [cdh.context existingObjectWithID:self.selectedItemID error:nil];
        if (!item.locationAtShop) {
            NSFetchRequest *request = [[cdh model] fetchRequestTemplateForName:@"UnknownLocationAtShop"];
            NSArray *fetchedObjects = [cdh.context executeFetchRequest:request error:nil];
            if ([fetchedObjects count] > 0) {
                item.locationAtShop = [fetchedObjects objectAtIndex:0];
            }
            else {
                LocationAtShop *locationAtShop = [NSEntityDescription insertNewObjectForEntityForName:@"LocationAtShop" inManagedObjectContext:cdh.context];
                NSError *error = nil;
                if (![cdh.context obtainPermanentIDsForObjects:[NSArray arrayWithObject:locationAtShop] error:&error]) {
                    NSLog(@"Couldn't obtain a permanent ID for object %@", error);
                }
                locationAtShop.aisle = @"...UnknownLocation...";
                item.locationAtShop = locationAtShop;
                
            }
        }
    }
}

@end
