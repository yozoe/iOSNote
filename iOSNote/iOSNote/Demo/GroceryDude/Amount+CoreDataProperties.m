//
//  Amount+CoreDataProperties.m
//  
//
//  Created by wangdong on 2017/1/6.
//
//

#import "Amount+CoreDataProperties.h"

@implementation Amount (CoreDataProperties)

+ (NSFetchRequest<Amount *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Amount"];
}

@dynamic xyz;

@end
