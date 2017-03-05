//
//  AmuseViewController.swift
//  QP_DouYu
//
//  Created by JackieQu on 2017/2/26.
//  Copyright © 2017年 JackieQu. All rights reserved.
//

import UIKit

class AmuseViewController: BaseAnchorViewController {

    // MARK:- 懒加载属性
    fileprivate lazy var amuseVM : AmuseViewModel = AmuseViewModel()
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
