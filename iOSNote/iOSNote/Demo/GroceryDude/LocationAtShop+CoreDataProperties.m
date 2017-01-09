//
//  LocationAtShop+CoreDataProperties.m
//  
//
//  Created by wangdong on 2017/1/7.
//
//

#import "LocationAtShop+CoreDataProperties.h"

@implementation LocationAtShop (CoreDataProperties)

+ (NSFetchRequest<LocationAtShop *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"LocationAtShop"];
}

@dynamic aisle;
@dynamic items;

@end
