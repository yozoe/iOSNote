//
//  LocationAtHome+CoreDataProperties.m
//  
//
//  Created by wangdong on 2017/1/7.
//
//

#import "LocationAtHome+CoreDataProperties.h"

@implementation LocationAtHome (CoreDataProperties)

+ (NSFetchRequest<LocationAtHome *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"LocationAtHome"];
}

@dynamic storedIn;
@dynamic items;

@end
