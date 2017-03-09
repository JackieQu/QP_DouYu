//
//  FunnyViewController.swift
//  QP_DouYu
//
//  Created by JackieQu on 2017/3/9.
//  Copyright © 2017年 JackieQu. All rights reserved.
//

import UIKit

private let kTopMargin : CGFloat = 10

class FunnyViewController: BaseAnchorViewController {

}

extension FunnyViewController {
    override func setupUI() {
        super.setupUI()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize.zero
        collectionView.contentInset = UIEdgeInsets(top: kTopMargin, left: 0, bottom: 0, right: 0)
    }
}
