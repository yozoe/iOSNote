//
//  HomeViewController.swift
//  SwiftProject
//
//  Created by 王东 on 2016/11/14.
//  Copyright © 2016年 王东. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    fileprivate lazy var titleBtn:TitleButton = TitleButton()
    
    var isPresented:Bool = false
    
    //在闭包中如果使用当前对象的属性或者调用方法,也需要加self
    //两个地方需要使用self: 1>如果在一个函数中出现歧义 2>在闭包中使用当前对象的属性和方法也需要加self
    fileprivate lazy var popoverAnimator:PopoverAnimator = PopoverAnimator {[weak self] (presented)->() in
        self?.titleBtn.isSelected = presented
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        visitorView.addRotationAnim()
        
        if (!isLogin) {
            return
        }

        setupNavigationBar()
    }


}

extension HomeViewController {

    fileprivate func setupNavigationBar() {
//        let leftBtn = UIButton()
//        leftBtn.setImage(UIImage(named: "navigationbar_friendattention"), for: .normal)
//        leftBtn.setImage(UIImage(named: "navigationbar_friendattention_highlighted"), for: .highlighted)
//        leftBtn.sizeToFit()
//        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
//        
//        let rightBtn = UIButton()
//        rightBtn.setImage(UIImage(named: "navigationbar_pop"), for: .normal)
//        rightBtn.setImage(UIImage(named: "navigationbar_pop_highlighted"), for: .highlighted)
//        rightBtn.sizeToFit()
//        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBtn)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendattention");
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName:"navigationbar_pop")
        
        titleBtn.setTitle("coderwhy", for: .normal)
        titleBtn.addTarget(self, action: #selector(titleBtnClick), for: .touchUpInside)
        
        navigationItem.titleView = titleBtn
        
        
    }
    
}

extension HomeViewController {
    @objc fileprivate func titleBtnClick(titleBtn:TitleButton) {
        
        let popoverVc = PopoverViewController()
        popoverVc.modalPresentationStyle = .custom
        
        popoverVc.transitioningDelegate = popoverAnimator
        popoverAnimator.presentedFrame = CGRect(x: 100, y: 100, width: 180, height: 240)
        
        present(popoverVc, animated: true, completion: nil)
    }

}




