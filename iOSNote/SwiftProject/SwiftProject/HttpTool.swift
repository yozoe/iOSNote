//
//  HttpTool.swift
//  SwiftProject
//
//  Created by wangdong on 2016/10/26.
//  Copyright © 2016年 wangdong. All rights reserved.
//

import Foundation

class HttpTool: NSObject {
    
    var callBack: ((jsonData: String) -> ())?
    
    let dict: [String: AnyObject] = ["a":"b"]
    
    func loadData(callBack: (jsonData: String) -> ()) {
        
        self.callBack = callBack
        
        dispatch_async(dispatch_get_global_queue(0, 0)) { 
            print("发送网络请求\(NSThread.currentThread())")
            
            
            dispatch_async(dispatch_get_main_queue(), { 
                print("获取到数据,并且进行回调:\(NSThread.currentThread())")

                callBack(jsonData: "jsonData数据")
     
            })
            
        }
    }
}
