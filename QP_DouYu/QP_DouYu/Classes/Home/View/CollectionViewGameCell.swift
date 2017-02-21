//
//  CollectionViewGameCell.swift
//  QP_DouYu
//
//  Created by JackieQu on 2017/2/19.
//  Copyright © 2017年 JackieQu. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionViewGameCell: UICollectionViewCell {

    // MARK:- 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK:- 定义模型属性
    var group : AnchorGroup? {
        didSet {
            titleLabel.text = group?.tag_name
            
            if let iconURL = URL(string: group?.icon_url ?? "") {
                iconImageView.kf.setImage(with: iconURL)
            } else {
                iconImageView.image = UIImage(named: "home_more_btn")
            }
            
//            let iconURL = URL(string: group?.icon_url ?? "")!
//            iconImageView.kf.setImage(with: iconURL, placeholder: UIImage(named: "home_more_btn"))
        }
    }
    
//    // MARK:- 系统回调函数
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }

}
