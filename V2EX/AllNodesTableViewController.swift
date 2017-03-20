//
//  AllNodesTableViewController.swift
//  V2EX
//
//  Created by 张克 on 2017/3/20.
//  Copyright © 2017年 zhangke. All rights reserved.
//

import UIKit

protocol AllNodesTableViewControllerDelegate:class {
    func allNodesTableViewControllerDidChangeLikeNodes()
}

class AllNodesTableViewController: UITableViewController {
    

    weak var delegate: AllNodesTableViewControllerDelegate?
    var allNodes: [[String: Int]] = []
    var likeNodesId = Set<Int>()
    
    var likeNodes: [[String: Int]] = []{
        didSet{
            likeNodesId.removeAll()
            for node in likeNodes {
                likeNodesId.insert((node.first?.value)!)
            }
            UserDefaults.standard.set(likeNodes, forKey: UserDefaultsStrings.UserLikesNodes)
            delegate?.allNodesTableViewControllerDidChangeLikeNodes()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        likeNodes = UserDefaults.standard.object(forKey: UserDefaultsStrings.UserLikesNodes) as! [[String: Int]]
        getAllNodes()
        
        
    }
    
    func getAllNodes(){
        var nodes: [[String: Int]] = []
        V2EXNetworkHelper.getAllNodes { (json) in
            if let json = json{
                for anode in json.array!{
                    if !self.likeNodesId.contains(anode["id"].int!) {
                        let node = [anode["title"].string!: anode["id"].int!]
                        nodes.append(node)
                    }
                }
            }
            
            self.allNodes = nodes
            self.tableView.reloadData()
        }
    }
    
    @IBAction func editBarButtonDidTouch(_ sender: UIBarButtonItem) {
        if tableView.isEditing {
            tableView.setEditing(false, animated: true)
            sender.title = "编辑"
        }else {
            tableView.setEditing(true, animated: true)
            sender.title = "完成"
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0{
            return likeNodes.count
        }
        else{
            return allNodes.count
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StoryBoardConfigs.NodeNameCellIdentifier, for: indexPath)
        if indexPath.section == 0{
            cell.textLabel?.text = likeNodes[indexPath.row].first?.key
        }else {
            cell.textLabel?.text = allNodes[indexPath.row].first?.key
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerLabel = UILabel()
        headerLabel.backgroundColor = UIColor(red:0.94, green:0.94, blue:0.96, alpha:1.00)
        headerLabel.font = UIFont.systemFont(ofSize: 14)
        
        let indentForHeaderTitle = "    "
        
        if section == 0{
            headerLabel.text = indentForHeaderTitle + "收藏"
        }else{
            headerLabel.text = indentForHeaderTitle + "其他"
        }
        return headerLabel
    }

    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let node = likeNodes.remove(at: indexPath.row)
            allNodes.insert(node, at: 0)
        } else if editingStyle == .insert {
            let node = allNodes.remove(at: indexPath.row)
            likeNodes.append(node)
        }
        tableView.reloadData()
    }
    
    
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let sourceNode = likeNodes.remove(at: fromIndexPath.row)
        likeNodes.insert(sourceNode, at: to.row)
        
        
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        if indexPath.section == 0{
            return .delete
        }else {
            return .insert
        }
    }
    
    
    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section == 0{
            return true
        }
        return false
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        var node: [String: Int]
        if indexPath.section == 0{
            node = likeNodes[indexPath.row]
        }
        else {
            node = allNodes[indexPath.row]
        }
        
        let toViewController = storyboard?.instantiateViewController(withIdentifier: StoryBoardConfigs.UniversalTopicTableViewControllerIdentifier) as! UniversalTopicTableViewController
        toViewController.nodeId = node.first?.value
        toViewController.navigationItem.title = node.first?.key
        navigationController?.pushViewController(toViewController, animated: true)
    }
    
    
}
