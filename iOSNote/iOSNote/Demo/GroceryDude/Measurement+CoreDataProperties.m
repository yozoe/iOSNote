//
//  Measurement+CoreDataProperties.m
//  
//
//  Created by wangdong on 2017/1/5.
//
//

#import "Measurement+CoreDataProperties.h"

@implementation Measurement (CoreDataProperties)

+ (NSFetchRequest<Measurement *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Measurement"];
}

@dynamic abc;

@end
