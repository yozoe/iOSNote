//
//  PopoverAnimator.swift
//  SwiftProject
//
//  Created by 王东 on 2016/11/17.
//  Copyright © 2016年 王东. All rights reserved.
//

import UIKit

class PopoverAnimator: NSObject {
    var isPresented:Bool = false
    var presentedFrame:CGRect = CGRect.zero
    var callBack:((_ presented:Bool)->())?
    
    override init() {
        
    }
    
    //注意:如果自定义了一个构造函数,但是没有对父类的构造函数init()进行重写,那么自定义的构造函数会覆盖默认的init()构造函数
    init(callBack:@escaping ((_ presented:Bool)->())) {
        self.callBack = callBack
    }
}


extension PopoverAnimator : UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentation = XMGPresentationVController(presentedViewController: presented, presenting: presenting)
        presentation.presentedFrame = presentedFrame
        return presentation
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = true
        callBack?(isPresented)
        return self;
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = false
        callBack?(isPresented)
        return self
    }
}

//弹出动画
extension PopoverAnimator : UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    //转场上下文,获取弹出的view和消失的view
    //UITransitionContextFromViewKey:获取消失的view
    //UITransitionContextToViewKey:获取弹出的view
    
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        isPresented ? animationForPresentedView(transitionContext: transitionContext) : animationForDismissedView(transitionContext: transitionContext)
    }
    
    private func animationForPresentedView(transitionContext:UIViewControllerContextTransitioning) {
        
        //1.获取弹出view
        let presentedView = transitionContext.view(forKey: UITransitionContextViewKey.to)
        
        //2.将弹出的view添加到containerView中
        transitionContext.containerView.addSubview(presentedView!)
        presentedView?.transform = CGAffineTransform.init(scaleX: 1.0, y: 0.0)
        presentedView?.layer.anchorPoint = CGPoint.init(x: 0.5, y: 0)
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {()->Void in
            presentedView?.transform = CGAffineTransform.identity
        }, completion: {(_)->Void in
            //必须告诉转场上下文已经完成了动画
            transitionContext.completeTransition(true)
        })
    }
    
    private func animationForDismissedView(transitionContext:UIViewControllerContextTransitioning) {
        
        let dismissView = transitionContext.view(forKey: UITransitionContextViewKey.from)
        UIView.animate(withDuration: 0.5, animations: {() -> Void in
            dismissView?.transform = CGAffineTransform.init(scaleX: 1.0, y: 0.00001)
        }, completion: {(_) -> Void in
            dismissView?.removeFromSuperview()
            transitionContext.completeTransition(true)
        })
    }
    
}
