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
        
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        // 隐藏 tabbar
        viewController.hidesBottomBarWhenPushed = true
        
        super.pushViewController(viewController, animated: animated)
    }
}
