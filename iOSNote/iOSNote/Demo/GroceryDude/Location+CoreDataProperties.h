//
//  Location+CoreDataProperties.h
//  
//
//  Created by wangdong on 2017/1/7.
//
//

#import "Location+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Location (CoreDataProperties)

+ (NSFetchRequest<Location *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *summary;

@end

NS_ASSUME_NONNULL_END
