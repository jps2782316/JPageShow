//
//  Test1ViewController.swift
//  页面跳转显示
//
//  Created by jps on 2020/11/10.
//  Copyright © 2020 jps. All rights reserved.
//

import UIKit

class Test1ViewController: UIViewController {
    
    
    var userId: Int
    
    
    
    //MARK:  ------------  init  ------------
    
    /*
    //初始化方法一: 传入用户id，初始化控制器
    init(userId: Int) {
        self.userId = userId
        super.init(nibName: nil, bundle: nil)
    }*/
    
    
    //初始化方法一，如果出入的用户id无效，则不初始化控制器
    init?(userId: Int) {
        if userId == 0 { return nil }
        self.userId = userId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    //MARK:  ------------  LifeCircle  ------------
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("userId: \(userId)")
        self.view.backgroundColor = .red
    }
    

    

}
