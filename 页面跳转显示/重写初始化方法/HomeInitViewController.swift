//
//  HomeInitViewController.swift
//  页面跳转显示
//
//  Created by jps on 2020/11/10.
//  Copyright © 2020 jps. All rights reserved.
//

import UIKit

class HomeInitViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func codeClicked(_ sender: Any) {
        if let codeVC = Test1ViewController(userId: 2) {
            self.navigationController?.pushViewController(codeVC, animated: true)
        }
    }
    
    @IBAction func xibClicked(_ sender: Any) {
        let xibVC = Test2ViewController(userId: 642)
        self.navigationController?.pushViewController(xibVC, animated: true)
    }
    
    @IBAction func storyboradClicked(_ sender: Any) {
        let storyboardVC = Test3ViewController.instance(userId: 66)
        self.navigationController?.pushViewController(storyboardVC, animated: true)
    }
    
}
