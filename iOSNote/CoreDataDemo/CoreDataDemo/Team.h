//
//  Team.h
//  CoreDataDemo
//
//  Created by wangdong on 16/5/23.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface Team : NSManagedObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSSet *players;

@end
