//
//  Unit+CoreDataProperties.h
//  
//
//  Created by wangdong on 2017/1/6.
//
//

#import "Unit+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Unit (CoreDataProperties)

+ (NSFetchRequest<Unit *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;

@end

NS_ASSUME_NONNULL_END
