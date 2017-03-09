//
//  FunnyViewModel.swift
//  QP_DouYu
//
//  Created by JackieQu on 2017/3/9.
//  Copyright © 2017年 JackieQu. All rights reserved.
//

import UIKit

class FunnyViewModel : BaseViewModel {

}

extension FunnyViewModel {
    func loadFunnyData(finishedCallback : @escaping() ->()) {
        loadAnchorData(isGroupData: false, URLString: "http://capi.douyucdn.cn/api/v1/getColumnRoom/3", parameters: ["limit" : 30, "offset" : 0], finishedCallback: finishedCallback)
    }
}
