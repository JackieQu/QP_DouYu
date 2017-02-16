//
//  CollectionViewPrettyCell.swift
//  QP_DouYu
//
//  Created by 曲鹏 on 2017/2/11.
//  Copyright © 2017年 JackieQu. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionViewPrettyCell: CollectionViewBaseCell {

    // MARK:- 控件的属性 
    @IBOutlet weak var cityBtn: UIButton!
    
    // MARK:- 定义模型属性
    override var anchor : AnchorModel? {
        didSet {
            // 1.将属性传递给父类
            super.anchor = anchor
            // 2.所在的城市
            cityBtn.setTitle(anchor?.anchor_city, for: .normal)
        }
    }
}
