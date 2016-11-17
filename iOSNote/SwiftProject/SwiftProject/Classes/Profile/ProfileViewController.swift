//
//  ProfileViewController.swift
//  SwiftProject
//
//  Created by 王东 on 2016/11/14.
//  Copyright © 2016年 王东. All rights reserved.
//

import UIKit

class ProfileViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        visitorView.setupVisitorViewInfo(iconName: "visitordiscover_image_profile", title: "登录后,别人评论你的微博,给你发消息,都会在这里收到通知")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}
