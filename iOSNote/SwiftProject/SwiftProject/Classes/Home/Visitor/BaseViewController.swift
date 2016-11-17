//
//  BaseViewController.swift
//  SwiftProject
//
//  Created by 王东 on 2016/11/16.
//  Copyright © 2016年 王东. All rights reserved.
//

import UIKit

class BaseViewController: UITableViewController {

    lazy var visitorView : VisitorView = VisitorView.visitorView()
    
    var isLogin : Bool = true
    
    
    override func loadView() {
        isLogin ? super.loadView() : setupVisitorView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationItems()
    }

}

extension BaseViewController {
    
    fileprivate func setupVisitorView() {
        view = visitorView
        
        visitorView.registerBtn.addTarget(self, action: #selector(registerBtnClick), for: .touchUpInside)
        visitorView.loginBtn.addTarget(self, action: #selector(loginBtnClick), for: .touchUpInside)
    }

    fileprivate func setupNavigationItems() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .plain, target: self, action: #selector(registerBtnClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: .plain, target: self, action: #selector(loginBtnClick))
    }
}

extension BaseViewController {
    @objc fileprivate func registerBtnClick() {
        print(1)
    }
    @objc fileprivate func loginBtnClick() {
        print(2) 
    }
}



