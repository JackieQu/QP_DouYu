//
//  AmuseViewController.swift
//  QP_DouYu
//
//  Created by JackieQu on 2017/2/26.
//  Copyright © 2017年 JackieQu. All rights reserved.
//

import UIKit

private let kMenuViewH : CGFloat = 200;

class AmuseViewController: BaseAnchorViewController {

    // MARK:- 懒加载属性
    fileprivate lazy var amuseVM : AmuseViewModel = AmuseViewModel()
    fileprivate lazy var menuView : AmuseMenuView = {
        let menuView = AmuseMenuView.amuseMenuView()
        menuView.frame = CGRect(x: 0, y: -kMenuViewH, width: kScreenW, height: kMenuViewH)
        menuView.backgroundColor = UIColor.red
        return menuView
    }()
}

// MARK:- 设置 UI
extension AmuseViewController {
    override func setupUI() {
        super.setupUI()
        
        collectionView.addSubview(menuView)
        collectionView.contentInset = UIEdgeInsets(top: kMenuViewH, left: 0, bottom: 0, right: 0)
    }
}

// MARK:- 请求数据
extension AmuseViewController {
    override func loadData() {
        
        baseVM = amuseVM
        
        amuseVM.loadAmuseData {
            self.collectionView.reloadData()
        }
    }
}
