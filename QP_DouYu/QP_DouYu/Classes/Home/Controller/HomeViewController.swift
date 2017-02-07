//
//  HomeViewController.swift
//  QP_DouYu
//
//  Created by 曲鹏 on 2017/2/7.
//  Copyright © 2017年 JackieQu. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 设置 UI 界面
        setupUI()
    }
    
}

// MARK:- 设置 UI 界面
extension HomeViewController {
    fileprivate func setupUI() {
        // 1.设置导航栏
        setupNavBar()
    }
    
    fileprivate func setupNavBar () {
        // 1.设置左侧 item
        /*
        let btn = UIButton()
        btn.setImage(UIImage(named: "logo"), for: .normal)
        btn.sizeToFit()
        */
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        // 2.设置右侧 items
        let size = CGSize(width: 40, height: 40)
        
        /*
        let historyItem = UIBarButtonItem.creatItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem.creatItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
        let qrcodeItem = UIBarButtonItem.creatItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        */
        
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)

        navigationItem.rightBarButtonItems = [historyItem, searchItem, qrcodeItem]
    }
}
