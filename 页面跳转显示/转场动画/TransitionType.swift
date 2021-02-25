//
//  TransitionType.swift
//  页面跳转显示
//
//  Created by jps on 2020/11/13.
//  Copyright © 2020 jps. All rights reserved.
//

import Foundation
import UIKit


///转场类型
enum TransitionType {
    //导航栏
    case navigation(_ operation: UINavigationController.Operation)
    //tabBar切换
    case tabBar(_ direction: TabBarOperationDirection)
    //模态跳转
    case modal(_ operation: ModalOperation)
}


enum TabBarOperationDirection {
    case left
    case right
}


enum ModalOperation {
    case presentation
    case dismissal
}



/*
 转场类型: (前两种都属于容器VC转场，而modal不是)
 UINavigationController转场: push、pop
 UITabBarController转场: Tab切换
 Modal转场: presentation、dismissal
 
 
 转场本质:
 转场过程中，作为容器的父 VC 维护着多个子 VC，但在视图结构上，只保留一个子 VC 的视图，所以转场的本质是下一场景(子 VC)的视图替换当前场景(子 VC)的视图以及相应的控制器(子 VC)的替换，表现为当前视图消失和下一视图出现，基于此进行动画，动画的方式非常多，所以限制最终呈现的效果就只有你的想象力了
 
 转场结果:
 非交互转场: 完成
 交互式转场: 完成、取消
 */
