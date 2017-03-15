//
//  TopicDetailTableViewController.swift
//  V2EX
//
//  Created by 张克 on 2017/3/15.
//  Copyright © 2017年 zhangke. All rights reserved.
//

import UIKit
import SwiftyJSON

class TopicDetailTableViewController: UITableViewController {
    
    var topic: JSON!
    var comments: JSON! = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        view.showLoading()
        navigationItem.title = "话题详情"
        refreshControl?.addTarget(self, action: #selector(TopicDetailTableViewController.refreshData), for: .valueChanged)
        
        loadData()
    }
    
    func refreshData(){
        loadData()
    }
    
    func loadData(){
        let topicId = topic["id"].int!
        V2EXNetworkHelper.getComments(withTopicId: topicId) { (json) in
            if json != nil {
                self.comments = json
                self.tableView.reloadData()
                self.view.hideLoading()
                self.refreshControl?.endRefreshing()
            }
        }
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + comments.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: StoryBoardConfigs.TopicDetailCellIdentifier, for: indexPath) as! TopicDetailTableViewCell
            cell.topic = topic
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: StoryBoardConfigs.TopicCommentCellIdentifier) as! TopicCommentTableViewCell
            cell.comment = comments[indexPath.row - 1]
            return cell
        }


    }
    

    
}
