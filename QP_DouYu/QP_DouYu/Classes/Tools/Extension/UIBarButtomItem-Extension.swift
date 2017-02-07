//
//  UIBarButtomItem-Extension.swift
//  QP_DouYu
//
//  Created by 曲鹏 on 2017/2/7.
//  Copyright © 2017年 JackieQu. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    /*
    class func creatItem(imageName : String, highImageName : String, size : CGSize) -> UIBarButtonItem {
        let btn = UIButton()
        
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: highImageName), for: .highlighted)
        
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        
        return UIBarButtonItem(customView: btn)
    }
    */
    
    // 便利构造函数: 1> convenience 开头 2> 在构造函数中必须调用一个设计的构造函数(self)
    convenience init(imageName : String, highImageName : String = "", size : CGSize = CGSize.zero) {
        // 1.创建 UIButton
        let btn = UIButton()
        
        // 2.设置 btn 图片
        btn.setImage(UIImage(named: imageName), for: .normal)
        if highImageName != "" {
            btn.setImage(UIImage(named: highImageName), for: .highlighted)
        }
        
        // 3.设置 btn 尺寸
        if size == CGSize.zero {
            btn.sizeToFit()
        } else {
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        
        // 4.创建 UIBarButtonItem
        self.init(customView: btn)
    }
    
}
