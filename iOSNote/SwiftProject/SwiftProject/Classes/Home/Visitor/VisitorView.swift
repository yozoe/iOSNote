//
//  VisitorView.swift
//  SwiftProject
//
//  Created by 王东 on 2016/11/16.
//  Copyright © 2016年 王东. All rights reserved.
//

import UIKit

class VisitorView: UIView {

    class func visitorView() -> VisitorView {
        return Bundle.main.loadNibNamed("VisitorView", owner: nil, options: nil)?.first as! VisitorView
    }

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var rotationView: UIImageView!
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    func setupVisitorViewInfo(iconName:String, title:String) {
        iconView.image = UIImage(named: iconName)
        tipLabel.text = title
        rotationView.isHidden = true
    }
    
    func addRotationAnim() {
        let rotationAnim = CABasicAnimation(keyPath: "transform.rotation.z")
        
        rotationAnim.fromValue = 0
        rotationAnim.toValue = M_PI * 2
        rotationAnim.repeatCount = MAXFLOAT
        rotationAnim.duration = 5
        rotationAnim.isRemovedOnCompletion = false
        
        rotationView.layer.add(rotationAnim, forKey: nil)
    }
    
}
