//
//  RuntimeTestViewController.m
//  iOSNote
//
//  Created by wangdong on 16/4/23.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import "RuntimeTestViewController.h"
#import <objc/message.h>

@implementation RuntimeTestObject

+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    NSLog(@"resolve instance method");
    return YES;
}

+ (BOOL)resolveClassMethod:(SEL)sel
{
    NSLog(@"resolve class method");
    return YES;
}

- (id)forwardingTargetForSelector:(SEL)aSelector
{
    NSLog(@"forwarding target for selector");
//    return [super forwardingTargetForSelector:aSelector];
    return self;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    NSLog(@"forward invocation");
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    NSLog(@"method signature for selector");
    return nil;
}

//- (void)test
//{
//    NSLog(@"test");
//}

@end

@interface RuntimeTestViewController ()

@end

@implementation RuntimeTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    id class = objc_getClass("RuntimeTestViewController");
//    
//    unsigned int outCount;
//    
//    objc_property_t *properties = class_copyPropertyList(class, &outCount);
//    
//    for (int i = 0; i < outCount; i++) {
//        objc_property_t property = properties[i];
//        printf("%s", property_getName(property));
//    }
    
    
    RuntimeTestObject *to = [RuntimeTestObject new];
    [to test];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
