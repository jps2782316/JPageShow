//
//  DetailViewController.swift
//  页面跳转显示
//
//  Created by jps on 2020/11/9.
//  Copyright © 2020 jps. All rights reserved.
//

import UIKit

enum ShowStyle {
    case addChild
    case addSubview
    case newWindow
    case present
    case push
}

class DetailViewController: UIViewController {
    
    @IBOutlet weak var backBtn: UIButton!
    
    
    var style: ShowStyle
    
    var clickHandle: (() -> Void)?
    
    var removeHandle: (() -> Void)?
    
    
    
    init(style: ShowStyle) {
        self.style = style
        /*
         Must call a designated initializer of the superclass 'UIViewController'
         super.init()
         */
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    deinit {
        print("DetailViewController deinit。。。")
    }
    
    
    private func setUI() {
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    }
    
    
    
    
    @IBAction func backClick(_ sender: Any) {
        //removeHandle?()
        switch style {
        case .addChild:
            self.removeFromParent()
            self.view.removeFromSuperview()
        case .addSubview:
            removeHandle?()
            //self.view.removeFromSuperview()
        case .newWindow:
            removeHandle?()
        case .present:
            self.dismiss(animated: false, completion: nil)
        case .push:
            self.navigationController?.popViewController(animated: false)
        }
        
    }
    
    
    @IBAction func blockBtnClick(_ sender: Any) {
        clickHandle?()
    }
    

}
