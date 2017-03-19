//
//  RoomNormalViewController.swift
//  QP_DouYu
//
//  Created by JackieQu on 2017/3/19.
//  Copyright © 2017年 JackieQu. All rights reserved.
//

import UIKit

class RoomNormalViewController: UIViewController, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.yellow
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 隐藏导航栏
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        // 保留手势
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
