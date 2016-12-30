//
//  JSONDemoVC.h
//  iOSNote
//
//  Created by wangdong on 2016/12/8.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    SexMale,
    SexFemale
} Sex;

@interface User : NSObject
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *icon;
@property (assign, nonatomic) unsigned int age;
@property (copy, nonatomic) NSString *height;
@property (strong, nonatomic) NSNumber *money;
@property (assign, nonatomic) Sex sex;
@property (assign, nonatomic, getter=isGay) BOOL gay;
@end

@interface Status : NSObject
@property (copy, nonatomic) NSString *text;
@property (strong, nonatomic) NSArray *users;
@property (strong, nonatomic) Status *retweetedStatus;
@end


@interface JSONDemoVC : UIViewController

@end
