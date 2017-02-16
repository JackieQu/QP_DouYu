//
//  CollectionViewNormalCell.swift
//  QP_DouYu
//
//  Created by 曲鹏 on 2017/2/10.
//  Copyright © 2017年 JackieQu. All rights reserved.
//

import UIKit

class CollectionViewNormalCell: CollectionViewBaseCell {
    
    // MARK:- 控件的属性
    @IBOutlet weak var roomNameLabel: UILabel!
    
    // MARK:- 定义模型属性
    override var anchor : AnchorModel? {
        didSet {
            // 1.将属性传递给父类
            super.anchor = anchor
            // 2.房间名称
            roomNameLabel.text = anchor?.room_name
        }
    }
}
