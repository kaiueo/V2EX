//
//  HotTopicTableViewController.swift
//  V2EX
//
//  Created by 张克 on 2017/3/14.
//  Copyright © 2017年 zhangke. All rights reserved.
//

import UIKit
import SwiftyJSON

class HotTopicTableViewController: UITableViewController {
    
    var hotTopics: JSON! = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableViewAutomaticDimension
        
        refreshControl?.addTarget(self, action: #selector(HotTopicTableViewController.refreshData), for: .valueChanged)
        loadData()
    }
    
    func refreshData(){
        loadData()
    }
    
    func loadData(){
        V2EXNetworkHelper.getHotTopics { (json) in
            if json != nil{
                self.hotTopics = json!
                self.tableView.reloadData()
                self.refreshControl?.endRefreshing()
            }
        }
    }



    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return hotTopics.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StoryBoardConfigs.TopicCellIdentifier, for: indexPath) as! TopicTableViewCell
        cell.topic = hotTopics[indexPath.row]
        return cell
    }
    
    
    // MARK: TableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

}
