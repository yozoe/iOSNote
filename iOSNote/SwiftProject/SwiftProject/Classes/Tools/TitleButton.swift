//
//  TitleButton.swift
//  SwiftProject
//
//  Created by 王东 on 2016/11/17.
//  Copyright © 2016年 王东. All rights reserved.
//

import UIKit

class TitleButton: UIButton {

    override init (frame:CGRect) {
        super.init(frame:frame)
        setImage(UIImage(named:"navigationbar_arrow_down"), for: .normal)
        setImage(UIImage(named:"navigationbar_arrow_up"), for: .selected)
        setTitle("coderwhy", for: .normal)
        setTitleColor(UIColor.black, for: .normal)
        sizeToFit()
    }
    
    //swift中规定,重写空间的init(frame方法)或者init()方法,必须重写init?()
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel!.frame.origin.x = 0
        imageView!.frame.origin.x = titleLabel!.frame.size.width + 5
    }
}
