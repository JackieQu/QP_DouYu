//
//  AmuseMenuView.swift
//  QP_DouYu
//
//  Created by JackieQu on 2017/3/6.
//  Copyright © 2017年 JackieQu. All rights reserved.
//

import UIKit

class AmuseMenuView: UIView {

    
}

extension AmuseMenuView {
    class func amuseMenuView() -> AmuseMenuView {
        return Bundle.main.loadNibNamed("AmuseMenuView", owner: nil, options: nil)?.first as! AmuseMenuView
    }
}
