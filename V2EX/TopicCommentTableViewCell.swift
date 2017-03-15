//
//  TopicCommentTableViewCell.swift
//  V2EX
//
//  Created by 张克 on 2017/3/15.
//  Copyright © 2017年 zhangke. All rights reserved.
//

import UIKit
import SwiftyJSON
import SwiftDate

class TopicCommentTableViewCell: UITableViewCell {
    
    var comment: JSON! = []{
        didSet{
            initCell()
        }
    }

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    func initCell(){
        V2EXNetworkHelper.getImage(url: comment["member"]["avatar_large"].string!) { image in
            self.avatarImageView.image = image
        }
        authorLabel.text = comment["member"]["username"].string
        detailLabel.text = comment["content"].string
        let date = DateInRegion(absoluteDate: Date(timeIntervalSince1970: TimeInterval(comment["created"].int!)))
        dateLabel.text = try? date.colloquialSinceNow().colloquial
        
        
    }
    
}
