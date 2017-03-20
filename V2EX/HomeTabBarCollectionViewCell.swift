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
    
    
}
