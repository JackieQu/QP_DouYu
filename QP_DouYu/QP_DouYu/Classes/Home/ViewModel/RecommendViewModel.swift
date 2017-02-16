//
//  RecommendViewModel.swift
//  QP_DouYu
//
//  Created by JackieQu on 2017/2/15.
//  Copyright © 2017年 JackieQu. All rights reserved.
//

import UIKit

class RecommendViewModel {
    // MARK:- 懒加载
    fileprivate lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
    
}

// MARK:- 发送网络请求
extension RecommendViewModel {
    func requestData() {
        // 1. 请求推荐数据
        
        // 2. 请求颜值数据
        
        // 3. 请求游戏数据
        
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: ["limit": "4", "offset": "0", "time": NSDate.getCurrentTime()]) { (result) in
            // 1. 将 result 转为字典类型
            guard let resultDict = result as? [String : NSObject] else { return }
            
            // 2. 跟据 data 的 key 获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            // 3. 遍历数组，获取字典，字典转模型
            for dict in dataArray {
                let group = AnchorGroup(dict: dict)
                self.anchorGroups.append(group)
            }
            
            for group in self.anchorGroups {
                for anchor in group.anchors {
                    print(anchor.nickname)
                }
                print("----------")
            }
        }
    }
}
