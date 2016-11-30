//
//  Employee+CoreDataProperties.h
//  iOSNote
//
//  Created by wangdong on 2016/11/29.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import "Employee+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Employee (CoreDataProperties)

+ (NSFetchRequest<Employee *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *brithday;
@property (nullable, nonatomic, copy) NSNumber *height;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *sectionName;
@property (nullable, nonatomic, retain) Department *department;

@end

NS_ASSUME_NONNULL_END
