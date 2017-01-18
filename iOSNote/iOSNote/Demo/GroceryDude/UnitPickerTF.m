//
//  UnitPickerTF.m
//  iOSNote
//
//  Created by wangdong on 2017/1/9.
//  Copyright © 2017年 yozoe. All rights reserved.
//

#import "UnitPickerTF.h"
#import "CoreDataHelper.h"
#import "Unit+CoreDataClass.h"

@implementation UnitPickerTF

- (void)fetch
{
    CoreDataHelper *cdh = [CoreDataHelper cdh];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Unit"];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObject:sort]];
    [request setFetchBatchSize:50];
    NSError *error;
    self.pickerData = [cdh.context executeFetchRequest:request error:&error];
    if (error) {
        [self selectDefaultRow];
    }
}

- (void)selectDefaultRow
{
    if (self.selectedObjectID && [self.pickerData count] > 0) {
        CoreDataHelper *cdh = [CoreDataHelper cdh];
        Unit *selectedObject = [cdh.context existingObjectWithID:self.selectedObjectID error:nil];
        [self.pickerData enumerateObjectsUsingBlock:^(Unit * _Nonnull unit, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([unit.name compare:selectedObject.name] == NSOrderedSame) {
                [self.picker selectRow:idx inComponent:0 animated:NO];
                [self.pickerDelegate selectedObjectID:self.selectedObjectID changedForPickerTF:self];
                *stop = YES;
            }
        }];
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    Unit *unit = [self.pickerData objectAtIndex:row];
    return unit.name;
}

@end
