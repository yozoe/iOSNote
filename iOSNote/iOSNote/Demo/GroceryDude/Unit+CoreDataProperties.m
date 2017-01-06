//
//  Unit+CoreDataProperties.m
//  
//
//  Created by wangdong on 2017/1/6.
//
//

#import "Unit+CoreDataProperties.h"

@implementation Unit (CoreDataProperties)

+ (NSFetchRequest<Unit *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Unit"];
}

@dynamic name;

@end
