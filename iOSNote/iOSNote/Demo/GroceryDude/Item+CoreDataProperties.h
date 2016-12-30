//
//  Item+CoreDataProperties.h
//  
//
//  Created by wangdong on 2016/12/29.
//
//

#import "Item+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Item (CoreDataProperties)

+ (NSFetchRequest<Item *> *)fetchRequest;

@property (nonatomic) BOOL collected;
@property (nonatomic) BOOL listed;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) NSData *photoData;
@property (nonatomic) float quantity;

@end

NS_ASSUME_NONNULL_END
