//
//  GameViewController.swift
//  QP_DouYu
//
//  Created by JackieQu on 2017/2/21.
//  Copyright © 2017年 JackieQu. All rights reserved.
//

import UIKit

private let kEdgmargin : CGFloat = 10
private let kItemW : CGFloat = (kScreenW - 2 * kEdgmargin) / 3
private let kItemH : CGFloat = kItemW * 6 / 5

private let kGameCellID = "kGameCellID"

class GameViewController: UIViewController {

    // MARK:- 懒加载属性
    fileprivate lazy var gameVM : GameViewModel = GameViewModel()
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
        
        // 1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: kEdgmargin, bottom: 0, right: kEdgmargin)
        
        // 2.创建 UICollectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.register(UINib(nibName: "CollectionViewGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        collectionView.dataSource = self
        return collectionView
    }()
    
    // MARK:- 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        loadData()
    }

}

// MARK:- 设置 UI
extension GameViewController {
    fileprivate func setupUI() {
        view.addSubview(collectionView)
    }
}

// MARK:- 请求数据
extension GameViewController {
    fileprivate func loadData() {
        gameVM.loadAllGameData { 
            self.collectionView.reloadData()
        }
    }
}

// MARK:- 遵守 UICollectionView 数据源协议
extension GameViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameVM.games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1.获取 cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionViewGameCell
        
//        cell.backgroundColor = UIColor.randomColor()
        
        cell.baseGame = gameVM.games[indexPath.item]
        
        return cell
    }
}
