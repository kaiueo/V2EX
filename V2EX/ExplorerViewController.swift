//
//  ExplorerViewController.swift
//  V2EX
//
//  Created by 张克 on 2017/3/14.
//  Copyright © 2017年 zhangke. All rights reserved.
//

import UIKit

class ExplorerViewController: UIViewController {
    
    var pageViewController: UIPageViewController!
    var hotTopicTableViewController: HotTopicTableViewController!
    var latestTopicTableViewController: LatestTopicTableViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageViewController = self.childViewControllers.first as! UIPageViewController
        pageViewController.dataSource = self
        hotTopicTableViewController = storyboard?.instantiateViewController(withIdentifier: StoryBoardConfigs.HotTopicTableViewControllerIdentifier) as! HotTopicTableViewController
        latestTopicTableViewController = storyboard?.instantiateViewController(withIdentifier: StoryBoardConfigs.LatestTopicTableViewControllerIdentifier) as! LatestTopicTableViewController
        pageViewController.setViewControllers([hotTopicTableViewController], direction: .forward, animated: true, completion: nil)
        
        

        // Do any additional setup after loading the view.
    }

    
}

// MARK: UIPageViewControllerDataSource

extension ExplorerViewController: UIPageViewControllerDataSource{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if viewController.isKind(of: LatestTopicTableViewController.self) {
            return hotTopicTableViewController
        }else {
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if viewController.isKind(of: HotTopicTableViewController.self){
            return latestTopicTableViewController
        }else {
            return nil
        }
    }
    
    
}
