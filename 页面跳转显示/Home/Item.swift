//
//  Item.swift
//  页面跳转显示
//
//  Created by jps on 2020/11/10.
//  Copyright © 2020 jps. All rights reserved.
//

import Foundation


enum Item {
    case overriedInit
    case show
    case transfer
    
    var title: String {
        switch self {
        case .overriedInit:
            return "重写初始化方法"
        case .show:
            return "不同的显示方式"
        case .transfer:
            return "转场动画"
        }
    }
    
}
