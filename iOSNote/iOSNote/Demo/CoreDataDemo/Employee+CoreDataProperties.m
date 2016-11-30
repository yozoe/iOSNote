//
//  Employee+CoreDataProperties.m
//  iOSNote
//
//  Created by wangdong on 2016/11/29.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import "Employee+CoreDataProperties.h"

@implementation Employee (CoreDataProperties)

+ (NSFetchRequest<Employee *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Employee"];
}

@dynamic brithday;
@dynamic height;
@dynamic name;
@dynamic sectionName;
@dynamic department;

@end
