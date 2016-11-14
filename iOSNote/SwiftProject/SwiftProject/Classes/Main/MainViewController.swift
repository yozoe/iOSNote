//
//  MainViewController.swift
//  SwiftProject
//
//  Created by 王东 on 2016/11/14.
//  Copyright © 2016年 王东. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let jsonPath = Bundle.main.path(forResource: "MainVCSettings.json", ofType: nil) else {
            print("没有获取到对应的文件路径")
            return
        }
        
        guard let jsonData = NSData(contentsOfFile: jsonPath) else {
            print("没有获取到json文件中数据")
            return;
        }
        
        
        /*
         方式一:try方式 程序员手动捕捉异常
         do {
         try JSONSerialization.jsonObject(with: jsonData as Data, options: JSONSerialization.ReadingOptions.mutableContainers)
         }
         catch {
         print(error)
         }
         
         方式二:try?方式 系统帮助我们处理异常,如果该方法出现了异常,则该方法返回nil,如果没有异常,则返回对应的对象
         guard let anyObject = try? JSONSerialization.jsonObject(with: jsonData as Data, options: JSONSerialization.ReadingOptions.mutableContainers) else {
         return
         }
         
         方式三:try!方法 直接告诉系统,该方法没有异常,注意:如果该方法出现了异常,那么程序会崩溃
         let anyObject = try! JSONSerialization.jsonObject(with: jsonData as Data, options: JSONSerialization.ReadingOptions.mutableContainers) else {
         return
         */
        
        guard let anyObject = try? JSONSerialization.jsonObject(with: jsonData as Data, options: JSONSerialization.ReadingOptions.mutableContainers) else {
            return
        }
        
        guard let dictArray = anyObject as? [[String: AnyObject]] else {
            return
        }
    
        for dict in dictArray {
            
            guard let vcName = dict["vcName"] as? String else {
                continue
            }
            
            guard let title = dict["title"] as? String else {
                continue
            }
            
            guard let imageName = dict["imageName"] as? String else {
                continue
            }
            
            addChildViewController(childVcName: vcName, title: title, imageName: imageName)
        }
        
//        addChildViewController(childVcName: "HomeViewController", title: "首页", imageName: "tabbar_home")
//        addChildViewController(childVcName: "MessageViewController", title: "消息", imageName: "tabbar_message_center")
//        addChildViewController(childVcName: "DiscoverViewController", title: "发现", imageName: "tabbar_discover")
//        addChildViewController(childVcName: "ProfileViewController", title: "我", imageName: "tabbar_profile")
    }
    
    private func addChildViewController(childVcName: String, title: String, imageName: String) {

        guard let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String else {
            print("没有获取命名空间")
            return
        }
        
        guard let ChildVcClass = NSClassFromString(nameSpace + "." + childVcName) else {
            print("没有获取到字符串对应的Class");
            return
        }
        
        guard let childVcType = ChildVcClass as? UIViewController.Type else {
            print("没有获取到对应控制器的类型")
            return
        }
        
        let childVc = childVcType.init()
        
        childVc.title = title
        
        childVc.tabBarItem.image = UIImage(named: imageName)
        childVc.tabBarItem.image = UIImage(named: imageName + "_highlighted")
        
        let childNav = UINavigationController(rootViewController: childVc)
        addChildViewController(childNav)
    }

}
