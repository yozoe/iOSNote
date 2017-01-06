//
//  Measurement+CoreDataProperties.h
//  
//
//  Created by wangdong on 2017/1/5.
//
//

#import "Measurement+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Measurement (CoreDataProperties)

+ (NSFetchRequest<Measurement *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *abc;

@end

NS_ASSUME_NONNULL_END
