//
//  HomeViewController.swift
//  QP_DouYu
//
//  Created by 曲鹏 on 2017/2/7.
//  Copyright © 2017年 JackieQu. All rights reserved.
//

import UIKit

private let kTitleViewH : CGFloat = 40

class HomeViewController: UIViewController {
    // MARK:- 懒加载属性
    fileprivate lazy var pageTitleView : PageTitleView = {[weak self] in
        let titleframe = CGRect(x: 0, y: kStatusBarH + kNavBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView(frame: titleframe, titles: titles)
        titleView.delegate = self
        return titleView
    }()
    
    fileprivate lazy var pageContentView : PageContentView = {[weak self] in
        // 1.确定内容的 frame
        let contentH = kScreenH - kStatusBarH - kNavBarH - kTitleViewH - kTabBarH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavBarH + kTitleViewH, width: kScreenW, height: contentH)
        
        // 2.确定所有的子控制器
        var childVCs = [UIViewController]()
        childVCs.append(RecommendViewController())
        childVCs.append(GameViewController())
        childVCs.append(AmuseViewController())
        childVCs.append(FunnyViewController())
//        for i in 0..<1 {
//            let vc = UIViewController()
//            vc.view.backgroundColor = UIColor(
//                r: CGFloat(arc4random_uniform(255)),
//                g: CGFloat(arc4random_uniform(255)),
//                b: CGFloat(arc4random_uniform(255))
//            )
//            childVCs.append(vc)
//        }
        
        let contentView = PageContentView(frame: contentFrame, childVCs: childVCs, parentViewController: self)
        contentView.delegate = self
        return contentView
    }()
    
    // MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()

        // 设置 UI 界面
        setupUI()
    }
    
}

// MARK:- 设置 UI 界面
extension HomeViewController {
    fileprivate func setupUI() {
        // 0.不需要调整 UIScrollView 的那边距
        automaticallyAdjustsScrollViewInsets = false
        
        // 1.设置导航栏
        setupNavBar()
        
        // 2.添加 titleView
        view.addSubview(pageTitleView)
        
        // 3.添加 contentView
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.orange
    }
    
    fileprivate func setupNavBar () {
        // 1.设置左侧 item
        /*
        let btn = UIButton()
        btn.setImage(UIImage(named: "logo"), for: .normal)
        btn.sizeToFit()
        */
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        // 2.设置右侧 items
        let size = CGSize(width: 40, height: 40)
        
        /*
        let historyItem = UIBarButtonItem.creatItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem.creatItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
        let qrcodeItem = UIBarButtonItem.creatItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        */
        
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)

        navigationItem.rightBarButtonItems = [historyItem, searchItem, qrcodeItem]
    }
}

// MARK:- 遵守 PageViewDelegate 协议
extension HomeViewController : PageTitleViewDelegate {
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}

// MARK:- 遵守 PageContentViewDelegate 协议
extension HomeViewController : PageContentViewDelegate {
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
