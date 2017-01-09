//
//  Location+CoreDataProperties.m
//  
//
//  Created by wangdong on 2017/1/7.
//
//

#import "Location+CoreDataProperties.h"

@implementation Location (CoreDataProperties)

+ (NSFetchRequest<Location *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Location"];
}

@dynamic summary;

@end
