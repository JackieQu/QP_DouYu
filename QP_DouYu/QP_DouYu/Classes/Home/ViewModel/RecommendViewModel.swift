//
//  RecommendViewModel.swift
//  QP_DouYu
//
//  Created by JackieQu on 2017/2/15.
//  Copyright © 2017年 JackieQu. All rights reserved.
//

import UIKit

class RecommendViewModel : BaseViewModel {
    // MARK:- 懒加载
    lazy var cycleModels : [CycleModel] = [CycleModel]()
    fileprivate lazy var bigDataGroup : AnchorGroup = AnchorGroup()
    fileprivate lazy var prettyGroup : AnchorGroup = AnchorGroup()
}

// MARK:- 发送网络请求
extension RecommendViewModel {
    // 请求推荐数据
    func requestData(finishCallback : @escaping ()-> ()) {
        // 1. 定义参数
        let parameters = ["limit": "4", "offset": "0", "time": NSDate.getCurrentTime()]
        
        // 2. 创建 Group
        let dGroup = DispatchGroup()
        
        // 3. 请求推荐数据
        dGroup.enter()
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time" : NSDate.getCurrentTime()]) { (result) in
            // 1. 将 result 转为字典类型
            guard let resultDict = result as? [String : NSObject] else { return }
            
            // 2. 跟据 data 的 key 获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            // 3. 遍历数组，获取字典，字典转模型
            // 3.1 设置组属性
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            
            // 3.2 获取主播数据
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.bigDataGroup.anchors.append(anchor)
            }
            
            // 3.3 离开组
            dGroup.leave()
        }
        
        
        // 4. 请求颜值数据
        dGroup.enter()
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) in
            // 1. 将 result 转为字典类型
            guard let resultDict = result as? [String : NSObject] else { return }
            
            // 2. 跟据 data 的 key 获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            // 3. 遍历数组，获取字典，字典转模型
            // 3.1 设置组属性
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            
            // 3.2
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.prettyGroup.anchors.append(anchor)
            }
            
            // 3.3 离开组
            dGroup.leave()
        }
        
        // 5. 请求 2-12 游戏数据
        dGroup.enter()
        loadAnchorData(isGroupData: true, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) { 
            dGroup.leave()
        }
        
        // 6. 所以数据都请求到，进行排序
        dGroup.notify(queue: DispatchQueue.main) {
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            
            finishCallback()
        }
    }
    
    // 请求无限轮播数据
    func requestCycleData(finishCallback : @escaping ()-> ()) {
        NetworkTools.requestData(.get, URLString: "http://www.douyutv.com/api/v1/slide/6", parameters: ["version" : "2.300"]) { (result) in
            // 1.获取整体字典数组
            guard let resultDict = result as? [String : NSObject] else { return }
            
            // 2.根据 dataDict 获取数据
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            // 3.字典转为模型
            for dict in dataArray {
                self.cycleModels.append(CycleModel(dict : dict))
            }
            
            finishCallback()
        }
    }
}
