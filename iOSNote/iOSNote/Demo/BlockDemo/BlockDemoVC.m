//
//  BlockDemoVC.m
//  iOSNote
//
//  Created by 王东 on 2016/11/23.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import "BlockDemoVC.h"
#import "BDCalculatorManager.h"

typedef void(^BlockType)();

@interface BlockDemoVC ()

//@property (nonatomic, strong) void(^)() *block;
@property (nonatomic, strong) void(^block)();
@property (nonatomic, strong) BlockType block1;

@end

@implementation BlockDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self blockParameter];
    
    
    self.test();
    
    return;
    
    void(^block)();

    
    //block定义:三种方式 = ^(参数){}
    
    //第一种
    void(^block1)() = ^ {
        NSLog(@"block1");
    };
    
    _block = block1;
    
    //第二种 如果没有参数,参数可以隐藏,如果有参数,定义的时候,必须要写参数,而且必须要有参数变量名
    void(^block2)(int) = ^(int a) {
    };
    
    //第三种 block返回可以省略,不管有没有返回值,都可以省略
    int(^block3)() = ^int {
        return 123;
    };
    
    int(^block4)() = ^int(int a) {
        return 123;
    };
    
    //block类型 int(^)(NSString *)
    int(^block5)(NSString *) = ^(NSString *name) {
        return 2;
    };
    
//    block1();
    _block1();
    
    //快捷键inline-block
    

    //如果是局部变量,block是值传递
    //如果是静态变量,全局变量,__block修饰的变量,block是指针传递
    
}

- (void)blockParameter
{
    BDCalculatorManager *manager = [[BDCalculatorManager alloc] init];
    [manager calculator:^(NSInteger result){
        result += 5;
        result += 6;
        result *= 2;
        return result;
    }];
    
    NSLog(@"%ld", manager.result);
}

- (void(^)())test
{
    NSLog(@"test");
    return ^ {
        NSLog(@"fuck");
    };
}

@end
