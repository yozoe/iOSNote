//
//  UIBarButtonItem+Extension.swift
//  SwiftProject
//
//  Created by 王东 on 2016/11/17.
//  Copyright © 2016年 王东. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
//    convenience init (imageName:String) {
//        self.init()
//        let btn = UIButton()
//        btn.setImage(UIImage(named:imageName), for: .normal)
//        btn.setImage(UIImage(named:imageName + "highlighted"), for: .highlighted)
//        btn.sizeToFit()
//        self.customView = btn
//    }
    
    convenience init(imageName:String) {
        let btn = UIButton()
        btn.setImage(UIImage(named:imageName), for: .normal)
        btn.setImage(UIImage(named:imageName + "highlighted"), for: .highlighted)
        btn.sizeToFit()
        self.init(customView:btn)
    }
}
