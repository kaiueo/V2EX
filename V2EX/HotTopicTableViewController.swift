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
        view.showLoading()
        refreshControl?.addTarget(self, action: #selector(HotTopicTableViewController.refreshData), for: .valueChanged)
        navigationItem.title = "热门"
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
                self.view.hideLoading()
                self.refreshControl?.endRefreshing()
            }
        }
    }



    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return hotTopics.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StoryBoardConfigs.TopicCellIdentifier, for: indexPath) as! TopicTableViewCell
        cell.topic = hotTopics[indexPath.row]
        return cell
    }
    
    
    // MARK: TableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: StoryBoardConfigs.HotToDetailSegueIdentifier, sender: indexPath)
    
        tableView.deselectRow(at: indexPath, animated: true)
    }


    // MARK: PrepareForSegue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == StoryBoardConfigs.HotToDetailSegueIdentifier {
            let toViewController = segue.destination as! TopicDetailTableViewController
            let indexPath = sender as! IndexPath
            toViewController.topic = hotTopics[indexPath.row]
        }
    }

}
