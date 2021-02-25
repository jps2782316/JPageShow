//
//  TransitionUtil.swift
//  页面跳转显示
//
//  Created by jps on 2020/11/10.
//  Copyright © 2020 jps. All rights reserved.
//

import Foundation
import UIKit

///转场动画类
class TransitionUtil: NSObject {
    
    //var isPresent: Bool = true
    
    ///转场类型
    var transitionType: TransitionType?
    
    
    //交互转场
    var interactive = false
    let interactionController = UIPercentDrivenInteractiveTransition()
    
    
    override init() {
        super.init()
        
        
    }
    
    
}


//MARK:  ------------  动画控制器协议  ------------

extension TransitionUtil: UIViewControllerAnimatedTransitioning {
    
    //控制转场动画执行时间
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.5
    }
    
    //执行动画的地方，最核心的方法。
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        //isPresent ? self.presentAnimation(transitionContext: transitionContext) : self.dismissAnimation(transitionContext: transitionContext)
        
        transitionNavigation(transitionContext: transitionContext)
        
    }
    
    //如果实现了，会在转场动画结束后调用，可以执行一些收尾工作。
    func animationEnded(_ transitionCompleted: Bool) {
        
    }
    
    
    
    
    
    ///转场动画具体实现
    
    
    //MARK:  ------------  小窗口效果  ------------
    
    //带暗色调背景的小窗口效果， 定制 presentedView 的尺寸
    private func transitionModal(transitionContext: UIViewControllerContextTransitioning) {
        //获得容器视图（转场动画发生的地方）
        let containerView = transitionContext.containerView
        //设置暗背景视图(也可以创建一个dimmingView，设置背景大小后，insert到containerView的最底层)
        containerView.backgroundColor = UIColor.red.withAlphaComponent(0.3)
        
        
        //动画执行时间
        let duration = self.transitionDuration(using: transitionContext)
        
        //fromVC (即将消失的视图)
        let fromVC = transitionContext.viewController(forKey: .from)!
        let fromView = fromVC.view!
        //toVC (即将出现的视图)
        let toVC = transitionContext.viewController(forKey: .to)!
        let toView = toVC.view!
        
        if toVC.isBeingPresented {
            let toW: CGFloat = 100
            let toH: CGFloat = 200
            //添加到容器
            containerView.addSubview(toView)
            toView.center = containerView.center
            toView.bounds = CGRect(x: 0, y: 0, width: 1, height: toH)
            
            //暗色背景
            let dimmingView = UIView()
            containerView.insertSubview(dimmingView, belowSubview: toView)
            dimmingView.backgroundColor = UIColor.red.withAlphaComponent(0.3)
            dimmingView.center = containerView.center
            dimmingView.bounds = CGRect(x: 0, y: 0, width: toW, height: toH)
            
            
            /*
            containerView.addSubview(toView)
            toView.center = containerView.center
            toView.bounds = CGRect(x: 0, y: 0, width: toW, height: toH)
            toView.transform = CGAffineTransform(scaleX: 0.1, y: 1)
            UIView.animate(withDuration: duration, animations: {
                toView.transform = .identity
            }) { (finished) in
                //考虑到转场中途可能取消的情况，转场结束后，恢复视图状态。(通知是否完成转场)
                let wasCancelled = transitionContext.transitionWasCancelled
                transitionContext.completeTransition(!wasCancelled)
            }*/
            
            
            
            UIView.animate(withDuration: duration, animations: {
                toView.bounds = CGRect(x: 0, y: 0, width: toW, height: toH)
                dimmingView.bounds = containerView.bounds
            }) { (finished) in
                let wasCancelled = transitionContext.transitionWasCancelled
                //通知完成转场
                transitionContext.completeTransition(!wasCancelled)
            }
        }
        
        //Dismissal 转场中不要将 toView 添加到 containerView
        if fromVC.isBeingDismissed {
            let fromH = fromView.frame.height
            UIView.animate(withDuration: duration, animations: {
                fromView.bounds = CGRect(x: 0, y: 0, width: 1, height: fromH)
            }) { (finished) in
                let wasCancelled = transitionContext.transitionWasCancelled
                transitionContext.completeTransition(!wasCancelled)
            }
        }
    }
    
    
    
    
    func transitionNavigation(transitionContext: UIViewControllerContextTransitioning) {
        //获得容器视图（转场动画发生的地方）
        let containerView = transitionContext.containerView
        //动画执行时间
        let duration = self.transitionDuration(using: transitionContext)
        
        //fromVC (即将消失的视图)
        let fromVC = transitionContext.viewController(forKey: .from)!
        let fromView = fromVC.view!
        //toVC (即将出现的视图)
        let toVC = transitionContext.viewController(forKey: .to)!
        let toView = toVC.view!
        
        var offset = containerView.frame.width
        var fromTransform = CGAffineTransform.identity
        var toTransform = CGAffineTransform.identity
        
        switch transitionType {
        case .modal(let operation):
            offset = containerView.frame.height
            let fromY = operation == .presentation ? 0 : offset
            fromTransform = CGAffineTransform(translationX: 0, y: fromY)
            let toY = operation == .presentation ? offset : 0
            toTransform = CGAffineTransform(translationX: 0, y: toY)
            if operation == .presentation {
                containerView.addSubview(toView)
            }
            
        case .navigation(let operation):
            offset = operation == .push ? offset : -offset
            fromTransform = CGAffineTransform(translationX: -offset, y: 0)
            toTransform = CGAffineTransform(translationX: offset, y: 0)
            containerView.addSubview(toView)
            
        case .tabBar(let direction):
            offset = direction == .left ? offset : -offset
            fromTransform = CGAffineTransform(translationX: offset, y: 0)
            toTransform = CGAffineTransform(translationX: -offset, y: 0)
            containerView.addSubview(toView)
            
        case nil:
            break
        }
        
        toView.transform = toTransform
        UIView.animate(withDuration: duration, animations: {
            fromView.transform = fromTransform
            toView.transform = .identity
        }) { (finished) in
            fromView.transform = .identity
            toView.transform = .identity
            let wasCancelled = transitionContext.transitionWasCancelled
            transitionContext.completeTransition(!wasCancelled)
        }
        
        
    }
    
    
    
    
    
    
    
    
    //MARK:  ------------  放大查看图片  ------------
    
    private func presentAnimation(transitionContext: UIViewControllerContextTransitioning) {
        //获得容器视图（转场动画发生的地方）
        let containerView = transitionContext.containerView
        //containerView.backgroundColor = .red
        
        //得到fromVC (来源vc)
        let fromNavi = transitionContext.viewController(forKey: .from) as! UINavigationController
        let fromVC = fromNavi.topViewController as! TransitionViewController
        //起始坐标
        let startFrame = fromVC.view.convert(fromVC.imgBtn.frame, to: UIApplication.shared.keyWindow!)
        //动画图片
        let animateImgView = UIImageView(frame: startFrame)
        animateImgView.image = fromVC.imgBtn.image(for: .normal)
        animateImgView.contentMode = .scaleAspectFit
        animateImgView.clipsToBounds = true
        containerView.addSubview(animateImgView)
        
        //得到toVC (目标vc)
        let toVC = transitionContext.viewController(forKey: .to) as! TransitionDetailViewController
        toVC.view.alpha = 0
        //将目标view添加到容器view
        containerView.addSubview(toVC.view)
        //结束坐标
        let endFrame = toVC.view.convert(toVC.imgBtn.frame, to: UIApplication.shared.keyWindow!)
        
        //执行过渡动画
        UIView.animate(withDuration: 1.0, animations: {
            animateImgView.frame = endFrame
            toVC.view.alpha = 1.0
        }) { (b) in
            transitionContext.completeTransition(true)
            animateImgView.removeFromSuperview()
        }
    }
    
    
    private func dismissAnimation(transitionContext: UIViewControllerContextTransitioning) {
        //获得容器视图（转场动画发生的地方）
        let containerView = transitionContext.containerView
        //containerView.backgroundColor = .clear
        
        //得到fromVC (来源vc)
        let fromVC = transitionContext.viewController(forKey: .from) as! TransitionDetailViewController
        //起始坐标
        let startFrame = fromVC.imgBtn.frame
        //动画图片
        let animateImgView = UIImageView(frame: startFrame)
        animateImgView.image = fromVC.imgBtn.image(for: .normal)
        animateImgView.contentMode = .scaleAspectFit
        animateImgView.clipsToBounds = true
        containerView.addSubview(animateImgView)
        
        //得到toVC (目标vc)
        let toNavi = transitionContext.viewController(forKey: .to) as! UINavigationController
        let toVC = toNavi.topViewController as! TransitionViewController
        toVC.view.alpha = 0
        //注意⚠️: dismiss不能把目标视图添加进容器
        //containerView.addSubview(toVC.view)
        //结束坐标
        let endFrame = toVC.imgBtn.frame
        
        
        UIView.animate(withDuration: 1.0, animations: {
            animateImgView.frame = endFrame
            fromVC.view.alpha = 0
            toVC.view.alpha = 1.0
        }) { (b) in
            transitionContext.completeTransition(true)
            animateImgView.removeFromSuperview()
        }
        
        
    }
    
}







//MARK:  ------------  遵循转场代理方法  ------------



///自定义模态转场动画时使用
extension TransitionUtil: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.transitionType = .modal(.presentation)
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.transitionType = .modal(.dismissal)
        return self
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactive ? self.interactionController : nil
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactive ? self.interactionController : nil
    }
    
    
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return nil
    }
    
}



/// 自定义navigation转场动画时使用
extension TransitionUtil: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.transitionType = .navigation(operation)
        return self
    }
    
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactive ? self.interactionController : nil
    }
    
}


/// 自定义tab转场动画时使用
extension TransitionUtil: UITabBarControllerDelegate {
    
    
    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let fromIndex = tabBarController.viewControllers?.firstIndex(of: fromVC) ?? 0
        let toIndex = tabBarController.viewControllers?.firstIndex(of: toVC) ?? 0
        let direction: TabBarOperationDirection = fromIndex < toIndex ? .right : .left
        self.transitionType = .tabBar(direction)
        return self
    }
    
    func tabBarController(_ tabBarController: UITabBarController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactive ? self.interactionController : nil
    }
    
    
}
