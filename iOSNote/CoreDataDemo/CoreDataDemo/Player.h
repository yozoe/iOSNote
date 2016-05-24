//
//  Player.h
//  CoreDataDemo
//
//  Created by wangdong on 16/5/23.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Team;

@interface Player : NSManagedObject

@property (nonatomic, assign) NSNumber *age;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) Team *team;

@end
