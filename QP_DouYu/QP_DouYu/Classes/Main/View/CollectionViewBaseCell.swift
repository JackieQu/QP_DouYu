//
//  CollectionViewBaseCell.swift
//  QP_DouYu
//
//  Created by JackieQu on 2017/2/16.
//  Copyright © 2017年 JackieQu. All rights reserved.
//

import UIKit

class CollectionViewBaseCell: UICollectionViewCell {
 
    // MARK:- 控件的属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var nickNameLabel: UILabel!
    
    // MARK:- 定义模型属性
    var anchor : AnchorModel? {
        didSet {
            // 0.检查模型是否有值
            guard let anchor = anchor else { return }
            
            // 1.取出在线人数显示文字
            var onlineStr : String = ""
            if anchor.online >= 10000 {
                onlineStr = "\(Int(anchor.online / 10000))万在线"
            } else {
                onlineStr = "\(anchor.online)在线"
            }
            onlineBtn.setTitle(onlineStr, for: .normal)
            
            // 2.昵称的显示
            nickNameLabel.text = anchor.nickname
            
            // 3.设置封面图片
            guard let iconURL = URL(string : anchor.vertical_src) else { return }
            iconImageView.kf.setImage(with: iconURL)
        }
    }
}
