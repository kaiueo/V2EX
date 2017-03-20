//
//  HomeTabBarCollectionViewCell.swift
//  V2EX
//
//  Created by 张克 on 2017/3/20.
//  Copyright © 2017年 zhangke. All rights reserved.
//

import UIKit

class HomeTabBarCollectionViewCell: UICollectionViewCell {
    

    @IBOutlet weak var backgroundColorView: UIView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var indicatorView: UIView!
    
    var cellName = "" {
        didSet{
            nameLabel.text = cellName
        }
    }
    
    func reset(){
        backgroundColorView.backgroundColor = UIColor(red:0.94, green:0.94, blue:0.95, alpha:1.00)
        indicatorView.isHidden = true
    }
    
    
}
