//
//  NewTopicTableViewController.swift
//  V2EX
//
//  Created by 张克 on 2017/3/14.
//  Copyright © 2017年 zhangke. All rights reserved.
//

import UIKit
import SwiftyJSON

class LatestTopicTableViewController: UITableViewController {

    var latestTopics: JSON! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableViewAutomaticDimension
        view.showLoading()
        
        refreshControl?.addTarget(self, action: #selector(LatestTopicTableViewController.refreshData), for: .valueChanged)
        navigationItem.title = "最新"
        loadData()
    }
    
    func refreshData(){
        loadData()
    }
    
    func loadData(){
        
        V2EXNetworkHelper.getLatestTopics { (json) in
            if json != nil{
                self.latestTopics = json!
                self.tableView.reloadData()
                self.view.hideLoading()
                self.refreshControl?.endRefreshing()
            }
        }
    }
    
    
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return latestTopics.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StoryBoardConfigs.TopicCellIdentifier, for: indexPath) as! TopicTableViewCell
        cell.topic = latestTopics[indexPath.row]
        cell.delegate = self
        return cell
    }
    
    
    // MARK: TableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: StoryBoardConfigs.LatestToDetailSegueIdentifier, sender: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK: PrepareSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == StoryBoardConfigs.LatestToDetailSegueIdentifier{
            let toViewController = segue.destination as! TopicDetailTableViewController
            let indexPath = sender as! IndexPath
            toViewController.topic = latestTopics[indexPath.row]
        }
    }
}

extension LatestTopicTableViewController: TopicTableViewCellDelegate{
    func topicTableViewCellNodeButtonDidTouch(_ sender: [String : Int]) {
        let toViewController = storyboard?.instantiateViewController(withIdentifier: StoryBoardConfigs.UniversalTopicTableViewControllerIdentifier) as! UniversalTopicTableViewController
        toViewController.nodeId = sender.first?.value
        toViewController.navigationItem.title = sender.first?.key
        navigationController?.pushViewController(toViewController, animated: true)
    }
}




