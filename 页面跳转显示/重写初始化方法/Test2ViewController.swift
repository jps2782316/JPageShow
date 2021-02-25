//
//  Test2ViewController.swift
//  页面跳转显示
//
//  Created by jps on 2020/11/10.
//  Copyright © 2020 jps. All rights reserved.
//

import UIKit

class Test2ViewController: UIViewController {
    @IBOutlet weak var btn: UIButton!
    
    var userId: Int
    
    
    
    //MARK:  ------------  init  ------------
    
    init(userId: Int) {
        self.userId = userId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    //MARK:  ------------  LifeCircle  ------------
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    @IBAction func btnClicked(_ sender: Any) {
        print("userId: \(userId)")
    }
    
    

}
