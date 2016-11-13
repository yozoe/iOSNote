//
//  TestViewController.h
//  iOSNote
//
//  Created by wangdong on 16/4/21.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TestViewControllerProtocol <NSObject>

@property (nonatomic, strong) NSString *hehe;

@end

@interface TestObject1 : NSObject

@end

@interface TestViewController : UIViewController
{
    IMP hehe;
    Class hehe1;
}

@end
