//
//  TopicTableViewCell.swift
//  V2EX
//
//  Created by 张克 on 2017/3/14.
//  Copyright © 2017年 zhangke. All rights reserved.
//

import UIKit
import SwiftyJSON
import SwiftDate

protocol TopicTableViewCellDelegate: class {
    func topicTableViewCellNodeButtonDidTouch(_ sender: [String: Int])
}
class TopicTableViewCell: UITableViewCell {
    
    var topic: JSON! {
        didSet{
            initCell()
        }
    }
    
    weak var delegate: TopicTableViewCellDelegate?

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var commnetNumberLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nodeButton: UIButton?
    
    var node: [String: Int] = [:]
    
    @IBAction func nodeButtonDidTouch(_ sender: UIButton) {
        
        delegate?.topicTableViewCellNodeButtonDidTouch(node)
        
        
        
    }
    func initCell(){
        titleLabel.text = topic["title"].string
        let detail = topic["content"].string!
        detailLabel.text = detail
        commnetNumberLabel.text = String(topic["replies"].int!)
        let date = DateInRegion(absoluteDate: Date(timeIntervalSince1970: TimeInterval(topic["created"].int!)))
        dateLabel.text = try? date.colloquialSinceNow().colloquial
        nodeButton?.setTitle(" " + topic["node"]["title"].string! + " ", for: .normal)
        V2EXNetworkHelper.getImage(url: topic["member"]["avatar_large"].string!) { image in
            self.avatarImageView.image = image
        }
        authorLabel.text = topic["member"]["username"].string
        
        node = [topic["node"]["title"].string!: topic["node"]["id"].int!]
        
    }
    
}
