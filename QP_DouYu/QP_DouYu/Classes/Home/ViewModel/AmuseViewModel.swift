//
//  AmuseViewModel.swift
//  QP_DouYu
//
//  Created by JackieQu on 2017/3/3.
//  Copyright © 2017年 JackieQu. All rights reserved.
//

import UIKit

class AmuseViewModel : BaseViewModel {
}

extension AmuseViewModel {
    func loadAmuseData(finishedCallback : @escaping () -> ()) {
        loadAnchorData(isGroupData: true, URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", finishedCallback: finishedCallback)
    }
}
