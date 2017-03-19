//
//  CustomNavigationController.swift
//  QP_DouYu
//
//  Created by JackieQu on 2017/3/19.
//  Copyright © 2017年 JackieQu. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1.获取系统 pop 手势
        guard let systemGes = interactivePopGestureRecognizer else { return }
        
        // 2.获取手势添加到 view
        guard let gesView = systemGes.view else { return }
        
        // 3.获取 target／action
        // 3.1.利用 runtime 查看所有属性名称
        /*
        var count : UInt32 = 0
        let ivars = class_copyIvarList(UIGestureRecognizer.self, &count)!
        for i in 0..<count {
            let ivar = ivars[Int(i)]
            let name = ivar_getName(ivar)
            
            print(String(cString: name!))
        }
         */
        
        let targets = systemGes.value(forKey: "_targets") as? [NSObject]
        guard let targetObjc = targets?.first else { return }
        
        // 3.2.取出 target
        guard let target = targetObjc.value(forKey: "target") else { return }
        
        // 3.3.取出 action
//        guard let action = targetObjc.value(forKey: "action") as? Selector else { return }
        let action = Selector(("handleNavigationTransition:"))
        
        // 4.创建 pan 手势
        let panGes = UIPanGestureRecognizer()
        gesView.addGestureRecognizer(panGes)
        panGes.addTarget(target, action: action)
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        // 隐藏 tabbar
        viewController.hidesBottomBarWhenPushed = true
        
        super.pushViewController(viewController, animated: animated)
    }
}
