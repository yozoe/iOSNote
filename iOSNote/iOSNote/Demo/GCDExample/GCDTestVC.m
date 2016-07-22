//
//  GCDTestVC.m
//  iOSNote
//
//  Created by wangdong on 16/7/19.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import "GCDTestVC.h"

@interface GCDTestVC ()

@end

@implementation GCDTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
                并发队列        手动创建的串行队列       主队列
        同步     不开新线程      不开新线程             不开新线程
                串行           串行                  串行
        异步     有开新线程      有开新线程             不开新线程
                并发           串行                  串行
     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

//异步函数+并发队列:会开启新的线程
- (void)asyncConcurrent
{
    
    NSLog(@"--asyncConcurrent--start--");
    
//    dispatch_queue_t queue = dispatch_queue_create("com.iosnote", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(queue, ^{
        NSLog(@"---download1---%@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"---download2---%@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"---download3---%@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"---download4---%@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"---download5---%@", [NSThread currentThread]);
    });
    
    NSLog(@"--asyncConcurrent--end--");
}

//异步函数+串行队列:会开启一条线程,任务串行执行
- (void)asyncSerial
{
    dispatch_queue_t queue = dispatch_queue_create("com.iosnote", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(queue, ^{
        NSLog(@"---download1---%@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"---download2---%@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"---download3---%@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"---download4---%@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"---download5---%@", [NSThread currentThread]);
    });
}

//同步函数+并发队列:不会开线程,任务串行执行
- (void)syncConcurrent
{
    NSLog(@"--syncConcurrent--start--");
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_sync(queue, ^{
        NSLog(@"---download1---%@", [NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        NSLog(@"---download2---%@", [NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        NSLog(@"---download3---%@", [NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        NSLog(@"---download4---%@", [NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        NSLog(@"---download5---%@", [NSThread currentThread]);
    });
    NSLog(@"--syncConcurrent--end--");
}

//同步函数+串行队列:不会开县城,任务串行执行
- (void)syncSerial
{
    dispatch_queue_t queue = dispatch_queue_create("com.iosnote", DISPATCH_QUEUE_SERIAL);
    dispatch_sync(queue, ^{
        NSLog(@"---download1---%@", [NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        NSLog(@"---download2---%@", [NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        NSLog(@"---download3---%@", [NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        NSLog(@"---download4---%@", [NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        NSLog(@"---download5---%@", [NSThread currentThread]);
    });
}


//异步函数+主队列:不会开线程,任务串行执行
- (void)asyncMain
{
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_async(queue, ^{
        NSLog(@"---download1---%@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"---download2---%@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"---download3---%@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"---download4---%@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"---download5---%@", [NSThread currentThread]);
    });
}

//同步函数+主队列:死锁
- (void)syncMain
{
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_sync(queue, ^{
        NSLog(@"---download1---%@", [NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        NSLog(@"---download2---%@", [NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        NSLog(@"---download3---%@", [NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        NSLog(@"---download4---%@", [NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        NSLog(@"---download5---%@", [NSThread currentThread]);
    });
}

- (void)dealy
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0   * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"--%@", [NSThread currentThread]);
    });
}

- (void)once
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"+++++++ ");
    });
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dealy];
}

@end
