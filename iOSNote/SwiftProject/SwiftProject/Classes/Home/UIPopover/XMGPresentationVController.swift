//
//  XMGPresentationVController.swift
//  SwiftProject
//
//  Created by 王东 on 2016/11/17.
//  Copyright © 2016年 王东. All rights reserved.
//

import UIKit

class XMGPresentationVController: UIPresentationController {
    
    var presentedFrame:CGRect = CGRect.zero
    
    fileprivate lazy var coverView:UIView = UIView()
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        
        presentedView?.frame = presentedFrame
        
        setupCoverView()
    }

}

extension XMGPresentationVController {
    
    fileprivate func setupCoverView() {
        containerView?.insertSubview(coverView, at: 0)
        coverView.backgroundColor = UIColor(white:0.2, alpha:0.2)
        coverView.frame = containerView!.bounds
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(coverViewClick))
        coverView.addGestureRecognizer(tap)
    }
    
    @objc func coverViewClick() {
        presentedViewController.dismiss(animated: true, completion: nil)
    }
    
}
