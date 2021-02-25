//
//  HomeShowViewController.swift
//  页面跳转显示
//
//  Created by jps on 2020/11/10.
//  Copyright © 2020 jps. All rights reserved.
//

import UIKit

class HomeShowViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapHandle(_:)))
        self.view.addGestureRecognizer(tap)
    }
    
    
    @objc func tapHandle(_ tap: UITapGestureRecognizer) {
        print("self.view响应了点击事件")
    }
    
    
    //MARK:  ------------  show  ------------
    
    private func showByAddChild() {
        let vc = DetailViewController(style: .addChild)
        self.addChild(vc)
        self.view.addSubview(vc.view)
        vc.view.frame = self.view.frame
        /*
        vc.removeHandle = {[weak vc] in //必须加weak，不然内存泄漏
            vc?.removeFromParent()
            vc?.view.removeFromSuperview()
        }*/
        
        vc.clickHandle = {
            print("...")
        }
    }
    
    
    private var detailVC: DetailViewController?
    private func showByAddSubview() {
        let vc = DetailViewController(style: .addSubview)
        self.view.addSubview(vc.view)
        vc.view.frame = self.view.frame
        //不加[weak vc]，会内存泄漏
        //加[weak vc]，马上就会被释放
        vc.removeHandle = {[weak self] in
            self?.detailVC?.view.removeFromSuperview()
            self?.detailVC = nil
        }
        vc.clickHandle = {
            print("...")
        }
        
        /*
         let vc 是弱引用, 在离开这行代码所处的方法范围后, vc将被销毁，变为 nil
        如果不使用addChild(vc)的话，要用成员变量持有一下，不然方法执行完，vc就销毁了
        就会导致，虽然view显示出来了，但是里面的按钮的点击方法统统无效
        */
        detailVC = vc
    }
    
    
    var window: UIWindow?
    private func showByNewWindow() {
        let vc = DetailViewController(style: .newWindow)
        vc.removeHandle = {[weak self] in
            self?.window?.isHidden = true
            self?.window = nil
        }
        vc.clickHandle = {
            print("...")
        }
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = vc
        if let lastWindow = UIApplication.shared.windows.last {
            window?.windowLevel = lastWindow.windowLevel + 1
        }else {
            window?.windowLevel = .alert
        }
        window?.makeKeyAndVisible()
    }
    
    
    private func showByPresent() {
        let vc = DetailViewController(style: .present)
        //仅限于modalPresentationStyle属性为 UIModalPresentationFullScreen 或 UIModalPresentationCustom 这两种模式;
        vc.modalTransitionStyle = .crossDissolve //渐隐
        vc.modalPresentationStyle = .overFullScreen
        vc.clickHandle = {
            print("...")
        }
        self.present(vc, animated: false, completion: nil)
    }
    
    
    
    private func showByPush() {
        let vc = DetailViewController(style: .push)
        vc.clickHandle = {
            print("...")
        }
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    


    //MARK:  ------------  Click  ------------
    
    @IBAction func addChildClick1(_ sender: Any) {
        showByAddChild()
    }
    
    @IBAction func addSubviewClick2(_ sender: Any) {
        showByAddSubview()
    }
    
    @IBAction func newWindowClick(_ sender: Any) {
        showByNewWindow()
    }
    
    @IBAction func presentClick(_ sender: Any) {
        showByPresent()
    }
    
    @IBAction func pushClick(_ sender: Any) {
        showByPush()
    }

}
