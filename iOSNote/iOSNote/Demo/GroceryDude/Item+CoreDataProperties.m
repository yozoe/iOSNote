//
//  Item+CoreDataProperties.m
//  
//
//  Created by wangdong on 2016/12/29.
//
//

#import "Item+CoreDataProperties.h"

@implementation Item (CoreDataProperties)

+ (NSFetchRequest<Item *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Item"];
}

@dynamic collected;
@dynamic listed;
@dynamic name;
@dynamic photoData;
@dynamic quantity;

@end
