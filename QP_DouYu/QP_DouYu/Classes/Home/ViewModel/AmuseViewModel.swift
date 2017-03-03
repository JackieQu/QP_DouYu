//
//  AmuseViewModel.swift
//  QP_DouYu
//
//  Created by JackieQu on 2017/3/3.
//  Copyright © 2017年 JackieQu. All rights reserved.
//

import UIKit

class AmuseViewModel {
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
}

extension AmuseViewModel {
    func loadAmuseData(finishedCallback : @escaping () -> ()) {
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2") { (result) in
            // 1.处理数据
            guard let resultDict = result as? [String : Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            
            // 2.遍历数组中的字典
            for dict in dataArray {
                self.anchorGroups.append(AnchorGroup(dict: dict))
            }
            
            // 3.完成回调
            finishedCallback()
        }
    }
}
