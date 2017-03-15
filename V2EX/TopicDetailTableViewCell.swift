//
//  TopicDetailTableViewCell.swift
//  V2EX
//
//  Created by 张克 on 2017/3/15.
//  Copyright © 2017年 zhangke. All rights reserved.
//

import UIKit
import SwiftyJSON
import SwiftDate

class TopicDetailTableViewCell: UITableViewCell {
    
    var topic: JSON! {
        didSet{
            initCell()
        }
    }

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: DesignableLabel!
    @IBOutlet weak var nodeButton: UIButton!
    @IBOutlet weak var detailLabel: DesignableLabel!
    
    
    func initCell(){
        titleLabel.text = topic["title"].string
        let detail = topic["content"].string!
        detailLabel.text = detail
        let date = DateInRegion(absoluteDate: Date(timeIntervalSince1970: TimeInterval(topic["created"].int!)))
        dateLabel.text = try? date.colloquialSinceNow().colloquial
        nodeButton?.setTitle(" " + topic["node"]["title"].string! + " ", for: .normal)
        V2EXNetworkHelper.getImage(url: topic["member"]["avatar_large"].string!) { image in
            self.avatarImageView.image = image
        }
        authorLabel.text = topic["member"]["username"].string
    }
    
    
}
