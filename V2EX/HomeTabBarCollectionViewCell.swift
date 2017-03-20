//
//  HomeTabBarCollectionViewCell.swift
//  V2EX
//
//  Created by 张克 on 2017/3/20.
//  Copyright © 2017年 zhangke. All rights reserved.
//

import UIKit

class HomeTabBarCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var backgroundColorView: UIView!{
        didSet{
            backgroundColorView.layer.cornerRadius = 1
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var indicatorView: UIView!
    
    var cellName = "" {
        didSet{
            nameLabel.text = cellName
        }
    }
    
    func reset(){
        UIView.animate(withDuration: 0.3) {
            self.indicatorView.alpha = 0
            self.nameLabel.font = UIFont.systemFont(ofSize: 12)
            self.nameLabel.textColor = UIColor(red:0.18, green:0.24, blue:0.31, alpha:1.00)
        }
        indicatorView.isHidden = true
        
    }
    
    func active(){
        indicatorView.isHidden = false
        indicatorView.alpha = 0
        UIView.animate(withDuration: 0.3) {
            self.indicatorView.alpha = 1
            self.nameLabel.font = UIFont.systemFont(ofSize: 14)
            self.nameLabel.textColor = UIColor.black
        }
    }
}
