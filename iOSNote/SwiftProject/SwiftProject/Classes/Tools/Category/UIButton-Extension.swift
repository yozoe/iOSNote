//
//  UIButton-Extension.swift
//  SwiftProject
//
//  Created by 王东 on 2016/11/16.
//  Copyright © 2016年 王东. All rights reserved.
//

import UIKit

extension UIButton {
    
    class func createButton(imageName:String, bgImageName:String) -> UIButton {
        
        let btn = UIButton()
        
        btn.setBackgroundImage(UIImage(named: imageName), for: .normal)
        btn.setBackgroundImage(UIImage(named: imageName + "_highlighted"), for: .highlighted)
        btn.setImage(UIImage(named: bgImageName), for: .normal)
        btn.setImage(UIImage(named: bgImageName + "_highlighted"), for: .highlighted)
        
        btn.sizeToFit()
        
        return btn
    }
    
    convenience init (imageName:String, bgImageName:String) {
        self.init()
        
        setBackgroundImage(UIImage(named: imageName), for: .normal)
        setBackgroundImage(UIImage(named: imageName + "_highlighted"), for: .highlighted)
        setImage(UIImage(named: bgImageName), for: .normal)
        setImage(UIImage(named: bgImageName + "_highlighted"), for: .highlighted)
        
        sizeToFit()
    }
    
}
