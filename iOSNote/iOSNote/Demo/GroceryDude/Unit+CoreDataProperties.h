//
//  Unit+CoreDataProperties.h
//  
//
//  Created by wangdong on 2017/1/7.
//
//

#import "Unit+CoreDataClass.h"

@class Item;

NS_ASSUME_NONNULL_BEGIN

@interface Unit (CoreDataProperties)

+ (NSFetchRequest<Unit *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) NSSet<Item *> *items;

@end

@interface Unit (CoreDataGeneratedAccessors)

- (void)addItemsObject:(Item *)value;
- (void)removeItemsObject:(Item *)value;
- (void)addItems:(NSSet<Item *> *)values;
- (void)removeItems:(NSSet<Item *> *)values;

@end

NS_ASSUME_NONNULL_END
