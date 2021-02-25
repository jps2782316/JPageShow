//
//  HomeViewController.swift
//  页面跳转显示
//
//  Created by jps on 2020/11/9.
//  Copyright © 2020 jps. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var items: [Item] = [.overriedInit, .show, .transfer]
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let path = NSHomeDirectory()
        print("\(path)")
        
        //test()
    }
    
    
    
    
    
    
    private func test() {
        let v1 = UIView()
        v1.isUserInteractionEnabled = false
        v1.frame = CGRect(x: 50, y: 50, width: 200, height: 200)
        v1.backgroundColor = .red
//        let tap1 = UITapGestureRecognizer(target: self, action: #selector(v1TapHandle(_:)))
//        v1.addGestureRecognizer(tap1)
        self.view.addSubview(v1)
        
        let v2 = UIView()
        v2.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        v2.backgroundColor = .yellow
//        let tap2 = UITapGestureRecognizer(target: self, action: #selector(v2TapHandle(_:)))
//        v2.addGestureRecognizer(tap2)
        v1.addSubview(v2)
    }
    
    @objc func v1TapHandle(_ tap: UITapGestureRecognizer) {
        print("v1响应了点击事件")
    }
    @objc func v2TapHandle(_ tap: UITapGestureRecognizer) {
        print("v2响应了点击事件")
    }
    
    
    
    
}



extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let str = "cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: str)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: str)
        }
        let type = items[indexPath.row]
        cell?.textLabel?.text = type.title
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let type = items[indexPath.row]
        switch type {
        case .overriedInit:
            let initVC = HomeInitViewController()
            initVC.title = type.title
            self.navigationController?.pushViewController(initVC, animated: true)
        case .show:
            let showVC = HomeShowViewController()
            showVC.title = type.title
            self.navigationController?.pushViewController(showVC, animated: true)
        case .transfer:
            let transitionVC = TransitionViewController()
            transitionVC.title = type.title
            self.navigationController?.pushViewController(transitionVC, animated: true)
        }
    }
    
    
}



