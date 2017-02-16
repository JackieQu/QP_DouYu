//
//  AnchorModel.swift
//  QP_DouYu
//
//  Created by JackieQu on 2017/2/16.
//  Copyright © 2017年 JackieQu. All rights reserved.
//

import UIKit

class AnchorModel: NSObject {
    
    var room_id : Int = 0
    
    var vertical_src : String = ""
    
    var isVertical : Int = 0
    
    var room_name : String = ""
    
    var nickname : String = ""
    
    var online : Int = 0
    
    init(dict : [String : NSObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
