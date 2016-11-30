//
//  AppDelegate.m
//  iOSNote
//
//  Created by wangdong on 16/4/20.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import "AppDelegate.h"
#import "TestViewController.h"
#import "AutolayoutTestViewController.h"
#import "XibTestViewController.h"
#import "FirstTableViewController.h"
#import "RuntimeTestViewController.h"
#import "TransitionDemoVC.h"
#import "EditImageVC.h"
#import "RACTestVC.h"
#import "GCDTestVC.h"
#import "RACBookSearchVC.h"
#import "RACTestViewController.h"
#import "iOSNote-Swift.h"
#import "AFNetWorking.h"
#import "NSURLSessionTestViewController.h"
#import <MagicalRecord/MagicalRecord.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

NSURL *ZPDefaultSystemDatabaseFileURL(void)
{
    NSString *urlPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    return [NSURL fileURLWithPath:[urlPath stringByAppendingPathComponent:@"data.db"]];
}

NSManagedObjectModel *ZPDefaultSystemCoreDataModel(void)
{
    return [NSManagedObjectModel mergedModelFromBundles:@[[NSBundle mainBundle]]];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
//    [MagicalRecord setupCoreDataStack];
    
    [MagicalRecord cleanUp];
    [NSManagedObjectModel MR_setDefaultManagedObjectModel:ZPDefaultSystemCoreDataModel()];
    [MagicalRecord setupCoreDataStackWithAutoMigratingSqliteStoreAtURL:ZPDefaultSystemDatabaseFileURL()];
    
    
    return YES;
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
   
//    //1.创建回话管理者
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    [manager GET:@"" parameters:@"" progress:^(NSProgress * _Nonnull downloadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//    }];
//    
//    [manager downloadTaskWithRequest:nil progress:nil destination:nil completionHandler:nil];
    
//    AutolayoutTestViewController *controller = [[AutolayoutTestViewController alloc] init];
//    XibTestViewController *controller = [[XibTestViewController alloc] initWithNibName:@"XibTestViewController" bundle:nil];
    
//    FirstTableViewController *controller = [[FirstTableViewController alloc] initWithNibName:@"FirstTableViewController" bundle:nil];
    
//    TransitionDemoVC *vc = [TransitionDemoVC new];
    
//    EditImageVC *vc = [EditImageVC new];
    
    RACTestVC *vc = [RACTestVC new];

    
//    RACBookSearchVC *vc = [RACBookSearchVC new];
    
//    SwiftVC *vc = [SwiftVC new];
    
//    RACTestViewController *vc = [RACTestViewController new];
    
    
//    GCDTestVC *vc = [[GCDTestVC alloc] initWithNibName:@"GCDTestVC" bundle:nil];
    
//    vc.title = @"首页1";
    
//    NSURLSessionTestViewController *vc = [NSURLSessionTestViewController new];
////    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
//
//    UITabBarController *tab = [[UITabBarController alloc] init];
//
//    tab.viewControllers = @[nav];
    
    
//    self.window.rootViewController = tab;
    
    
    
    self.window.rootViewController = nav;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [MagicalRecord cleanUp];
}

@end
