//
//  Test3ViewController.swift
//  页面跳转显示
//
//  Created by jps on 2020/11/10.
//  Copyright © 2020 jps. All rights reserved.
//

import UIKit

class Test3ViewController: UIViewController {

    @IBOutlet weak var btn: UIButton!
    
    
    var userId: Int!
    
    
    //MARK:  ------------  init  ------------
    
    static func instance(userId: Int) -> Test3ViewController {
        let vc = UIStoryboard.init(name: "Test", bundle: nil).instantiateViewController(withIdentifier: "Test3ViewController") as! Test3ViewController
        vc.userId = userId
        return vc
    }
    
    
    
    
    //MARK:  ------------  LifeCircle  ------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("userId: \(userId!)")
    }
    

    @IBAction func btnClicked(_ sender: Any) {
        print("userId: \(userId!)")
    }
    

}
