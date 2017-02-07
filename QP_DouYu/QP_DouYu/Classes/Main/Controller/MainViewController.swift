//
//  MainViewController.swift
//  QP_DouYu
//
//  Created by 曲鹏 on 2017/2/7.
//  Copyright © 2017年 JackieQu. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addChildVC(storyName: "Home")
        addChildVC(storyName: "Live")
        addChildVC(storyName: "Follow")
        addChildVC(storyName: "Profile")
    }
    
    private func addChildVC(storyName : String) {
        // 1.通过 storyboard 获取控制器
        let childVC = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()!
        
        // 2.将 childVC 作为子控制器
        addChildViewController(childVC)
    }
}
