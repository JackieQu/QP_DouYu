//
//  RecommendViewModel.swift
//  QP_DouYu
//
//  Created by JackieQu on 2017/2/15.
//  Copyright © 2017年 JackieQu. All rights reserved.
//

import UIKit

class RecommendViewModel {

    
}

// MARK:- 发送网络请求
extension RecommendViewModel {
    func requestData() {
        NetworkTools.requestData(.get, URLString: "http://httpbin.org/get", parameters: ["name": "JackieQu"]) { (result) in
            print(result)
        }
        // 1. 请求推荐数据
        
        // 2. 请求颜值数据
        
        // 3. 请求游戏数据
    }
}
