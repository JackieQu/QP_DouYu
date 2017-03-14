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
private let kHeaderViewH : CGFloat = 50

private let kGameViewH : CGFloat = 90

private let kGameCellID = "kGameCellID"
private let kHeaderViewID = "kHeaderViewID"

class GameViewController: BaseViewController {

    // MARK:- 懒加载属性
    fileprivate lazy var gameVM : GameViewModel = GameViewModel()
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
        // 1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: kEdgmargin, bottom: 0, right: kEdgmargin)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        
        // 2.创建 UICollectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.register(UINib(nibName: "CollectionViewGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)

        collectionView.dataSource = self
        return collectionView
    }()
    fileprivate lazy var topHeaderView : CollectionHeaderView = {
        let headerView = CollectionHeaderView.collectionHeaderView()
        headerView.frame = CGRect(x: 0, y: -(kHeaderViewH + kGameViewH), width: kScreenW, height: kHeaderViewH)
        headerView.titleLabel.text = "常见"
        headerView.iconImageView.image = UIImage(named: "Img_orange")
        headerView.moreBtn.isHidden = true
        return headerView
    }()
    fileprivate lazy var gameView : RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
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
    override func setupUI() {
        // 0.给 contentView 赋值
        contentView = collectionView
        
        // 1.添加 UICollectionView
        view.addSubview(collectionView)
        
        // 2.添加顶部的 HeaderView
        collectionView.addSubview(topHeaderView)
        
        // 3.将常用游戏的 view 添加到 collectioView 中
        collectionView.addSubview(gameView)
        
        // 设置 collectioView 的内边距
        collectionView.contentInset = UIEdgeInsets(top: kHeaderViewH + kGameViewH, left: 0, bottom: 0, right: 0)
        
        super.setupUI()
    }
}

// MARK:- 请求数据
extension GameViewController {
    fileprivate func loadData() {
        gameVM.loadAllGameData {
            // 1.展示全部游戏
            self.collectionView.reloadData()
            
            // 2.展示常用游戏
//            var tempArray = [BaseGameModel]()
//            for i in 0..<10 {
//                tempArray.append(self.gameVM.games[i])
//            }
            self.gameView.groups = Array(self.gameVM.games[0..<10])
            
            self.loadDataFinished()
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
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 1.取出 headerView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        
        // 2.给 headerView 设置属性
        headerView.titleLabel.text = "全部"
        headerView.iconImageView.image = UIImage(named: "Img_orange")
        headerView.moreBtn.isHidden = true
   
        return headerView
    }
}
