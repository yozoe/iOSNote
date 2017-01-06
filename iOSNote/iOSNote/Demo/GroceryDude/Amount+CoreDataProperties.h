//
//  Amount+CoreDataProperties.h
//  
//
//  Created by wangdong on 2017/1/6.
//
//

#import "Amount+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Amount (CoreDataProperties)

+ (NSFetchRequest<Amount *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *xyz;

@end

NS_ASSUME_NONNULL_END
