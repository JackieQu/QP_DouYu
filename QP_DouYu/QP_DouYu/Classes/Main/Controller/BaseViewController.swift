//
//  BaseViewController.swift
//  QP_DouYu
//
//  Created by JackieQu on 2017/3/12.
//  Copyright © 2017年 JackieQu. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    // MARK:- 定义属性
    var contentView : UIView?
    
    // MARK:- 懒加载属性
    fileprivate lazy var animImageView : UIImageView = { [unowned self] in
        let imageView = UIImageView(image: UIImage(named: "img_loading_1"))
        imageView.center = self.view.center
        imageView.animationImages = [UIImage(named: "img_loading_1")!, UIImage(named: "img_loading_2")!]
        imageView.animationDuration = 0.5
        imageView.animationRepeatCount = LONG_MAX
        imageView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin]
        return imageView
    }()
    
    // MARK:- 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
}

extension BaseViewController {
    func setupUI() {
        // 1.隐藏内容 view
        contentView?.isHidden = true
        
        // 2.添加动画
        view.addSubview(animImageView)
        
        // 3.给 animImageView 执行动画
        animImageView.startAnimating()
        
        // 4.设置背景颜色
        view.backgroundColor = UIColor(r: 249, g: 249, b: 249)
    }
    
    func loadDataFinished() {
        // 1.停止动画
        animImageView.stopAnimating()
        
        // 2.隐藏 animImageView
        animImageView.isHidden = true
        
        // 3.显示 contentView
        contentView?.isHidden = false
    }
}
