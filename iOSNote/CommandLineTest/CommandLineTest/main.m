//
//  main.m
//  CommandLineTest
//
//  Created by wangdong on 16/7/15.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Test1.h"
#import "Test2.h"
#import "NSObject+TestCategory.h"

void hehe() {
    printf("hehe\n");
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        

        Test1 *t1 = [[Test1 alloc] init];
//        NSLog(@"%@", t1.hehe);
        NSLog(@"%@", t1.strhehe);

//        void (*heheP)() = hehe;
//        
//        heheP();
//        
//        void (^heheBlock)() = ^ () {
//            NSLog(@"hehe block");
//        };
//        
//        heheBlock();
//        
//        void (^heheBlock1)(int num);
//        
//        heheBlock1 = ^(int num) {
//            for (int i = 0; i < num; i++) {
//                NSLog(@"a");
//            }
//        };
//        
//        heheBlock1(5);
//        
//        typedef void (^testBlock)();
//        
//        testBlock tv;
//        
//        tv = ^ {
//            NSLog(@"test block");
//        };
//        
//        tv();
        
    }
    return 0;
}
