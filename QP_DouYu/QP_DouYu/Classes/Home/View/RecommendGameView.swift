//
//  RecommendGameView.swift
//  QP_DouYu
//
//  Created by JackieQu on 2017/2/19.
//  Copyright © 2017年 JackieQu. All rights reserved.
//

import UIKit

private let kGameCellID = "kGameCellID"
private let kEdgeInsetsMargin : CGFloat = 10

class RecommendGameView: UIView {
    // MARK:- 定义数据的属性
    var groups : [AnchorGroup]? {
        didSet {
            groups?.removeFirst()
            groups?.removeFirst()
            groups?.remove(at: 1)
            groups?.remove(at: 1)

            
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            groups?.append(moreGroup)
            
            collectionView.reloadData()
        }
    }
    
    // MARK:- 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK:- 系统回调
    override func awakeFromNib() {
        super.awakeFromNib()
        
        autoresizingMask = .init(rawValue: 0)
        
        // 注册 cell
        collectionView.register(UINib(nibName: "CollectionViewGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        
        // 设置 collectionView 内边距
        collectionView.contentInset = UIEdgeInsets(top: 0, left: kEdgeInsetsMargin, bottom: 0, right: kEdgeInsetsMargin)
    }
}

// MARK:- 提供快速创建的类方法
extension RecommendGameView {
    class func recommendGameView() -> RecommendGameView {
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }
}

// MARK:- 遵守 UICollectionView 的数据源协议
extension RecommendGameView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionViewGameCell
        
        cell.group = groups![indexPath.item]
        
//        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.red : UIColor.blue
        
        return cell
    }
}
