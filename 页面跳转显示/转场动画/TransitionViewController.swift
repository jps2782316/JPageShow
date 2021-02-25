//
//  TransitionViewController.swift
//  页面跳转显示
//
//  Created by jps on 2020/11/10.
//  Copyright © 2020 jps. All rights reserved.
//

import UIKit
/*
 https://www.cnblogs.com/hualuoshuijia/p/9945604.html
 
 iOS 视图控制器转场详解. 唐巧的博客
 https://blog.devtang.com/2016/03/13/iOS-transition-guide/
 */








class TransitionViewController: UIViewController {
    
    @IBOutlet weak var imgBtn: UIButton!
    
    @IBOutlet weak var circleBtn: UIButton!
    
    
    
    let transitionUtil = TransitionUtil()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        //系统自带的有四种动画:
        public enum UIModalTransitionStyle : Int {
            
            case coverVertical // 默认 底部滑入

            case flipHorizontal //水平翻转

            case crossDissolve //渐隐

            @available(iOS 3.2, *)
            case partialCurl //翻页
        }*/
        
        
        
        
        
        
        
    }
    
    
    
    
    @IBAction func translationBtnClicked(_ sender: Any) {
        let vc = TransitionDetailViewController()
        //设置转场代理
        //而且与容器 VC 的转场的代理由容器 VC 自身的代理提供不同，Modal 转场的代理由 presentedVC 提供
        vc.transitioningDelegate = transitionUtil
        /*
        .FullScreen 的时候，presentingView 的移除和添加由 UIKit 负责，在 presentation 转场结束后被移除，dismissal 转场结束时重新回到原来的位置；
        .Custom 的时候，presentingView 依然由 UIKit 负责，但 presentation 转场结束后不会被移除。
        */
        vc.modalPresentationStyle = .custom
        //animated: 一定要给true，不然不会出现转场动画
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func circleBtnClicked(_ sender: Any) {
        let vc = TransitionDetailViewController()
        //设置转场代理
        self.navigationController?.delegate = transitionUtil
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
}




