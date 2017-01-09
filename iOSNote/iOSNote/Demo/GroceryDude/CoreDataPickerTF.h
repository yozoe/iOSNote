//
//  CoreDataPickerTF.h
//  iOSNote
//
//  Created by wangdong on 2017/1/8.
//  Copyright © 2017年 yozoe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataHelper.h"

@class CoreDataPickerTF;

@protocol CoreDataPickerTFDelegate <NSObject>

- (void)selectedObjectID:(NSManagedObjectID *)objectID changedForPickerTF:(CoreDataPickerTF *)pickerTF;

@optional
- (void)selectedObjectCleardForPickerTF:(CoreDataPickerTF *)pickerTF;

@end

@interface CoreDataPickerTF : UITextField
<UIKeyInput, UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, weak) id <CoreDataPickerTFDelegate> pickerDelegate;
@property (nonatomic, strong) UIPickerView *picker;
@property (nonatomic, strong) NSArray *pickerData;
@property (nonatomic, strong) UIToolbar *toolbar;
@property (nonatomic) BOOL showToolbar;
@property (nonatomic, strong) NSManagedObjectID *selectedObjectID;

@end
