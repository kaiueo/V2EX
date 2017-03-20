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
    
    @IBOutlet weak var latestButton: UIButton!
    @IBOutlet weak var hotButton: UIButton!
    @IBOutlet weak var pageIndicator: DesignableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "热门"
        
        pageViewController = self.childViewControllers.first as! UIPageViewController
        pageViewController.dataSource = self
        pageViewController.delegate = self
        hotTopicTableViewController = storyboard?.instantiateViewController(withIdentifier: StoryBoardConfigs.HotTopicTableViewControllerIdentifier) as! HotTopicTableViewController
        
        //hotTopicTableViewController.delegate = self
        latestTopicTableViewController = storyboard?.instantiateViewController(withIdentifier: StoryBoardConfigs.LatestTopicTableViewControllerIdentifier) as! LatestTopicTableViewController
        pageViewController.setViewControllers([hotTopicTableViewController], direction: .forward, animated: true, completion: nil)
        
        
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: PageViewIndicator
    
    enum ExplorerPage{
        case hot
        case latest
    }
    
    @IBAction func hotButtonDidTouch(_ sender: Any) {
        pageViewController.setViewControllers([hotTopicTableViewController], direction: .reverse, animated: true, completion: nil)
        movePageIndicator(page: .hot)
        
    }
    
    @IBAction func latestButtonDidTouch(_ sender: Any) {
        pageViewController.setViewControllers([latestTopicTableViewController], direction: .forward, animated: true, completion: nil)
        movePageIndicator(page: .latest)
        
    }
    
    func movePageIndicator(page :ExplorerPage){
        UIView.animate(withDuration: 0.3, animations: {
            switch page{
            case .hot:
                self.pageIndicator.center.x = self.hotButton.center.x
                self.navigationItem.title = "热门"
            case .latest:
                self.pageIndicator.center.x = self.latestButton.center.x
                self.navigationItem.title = "最新"
            }
            
        })
        
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

// MARK: UIPageViewControllerDelegate

extension ExplorerViewController: UIPageViewControllerDelegate{
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            if let fromView = previousViewControllers.first{
                if fromView.isKind(of: HotTopicTableViewController.self){
                    movePageIndicator(page: .latest)
                }
                else {
                    movePageIndicator(page: .hot)
                }
            }
        }
    }
    
}

