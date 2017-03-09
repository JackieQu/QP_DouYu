//
//  BaseViewModel.swift
//  QP_DouYu
//
//  Created by JackieQu on 2017/3/4.
//  Copyright © 2017年 JackieQu. All rights reserved.
//

import UIKit

class BaseViewModel {
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()

}

extension BaseViewModel {
    func loadAnchorData(isGroupData : Bool, URLString : String, parameters : [String : Any]? = nil, finishedCallback : @escaping () -> ()) {
        NetworkTools.requestData(.get, URLString: URLString, parameters: parameters) { (result) in
            // 1.处理数据
            guard let resultDict = result as? [String : Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            
            // 2.判断是否分组数据
            if isGroupData {
                // 2.1.遍历数组中的字典
                for dict in dataArray {
                    self.anchorGroups.append(AnchorGroup(dict: dict))
                }
            } else {
                // 2.1.创建组
                let group = AnchorGroup()
                
                // 2.2.遍历 dataArray 的所有字典
                for dict in dataArray {
                    group.anchors.append(AnchorModel(dict: dict))
                }
                
                // 2.3.将 group 添加到 anchorGroups
                self.anchorGroups.append(group)
            }
            
            // 3.完成回调
            finishedCallback()
        }
    }
}
