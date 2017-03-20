//
//  HomeViewController.swift
//  V2EX
//
//  Created by 张克 on 2017/3/16.
//  Copyright © 2017年 zhangke. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    var pageViewController: UIPageViewController!
    var viewControllers: [UniversalTopicTableViewController] = []
    var currentPage = 0 {
        didSet{
            collectionView.reloadData()
            let indexPath = IndexPath(row: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    var lastPage = 0
    var likeNodes: [[String: Int]] = []
    var willTransituinToPage = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        self.navigationItem.title = "主页"
        
        pageViewController = self.childViewControllers.first as! UIPageViewController
        pageViewController.dataSource = self
        pageViewController.delegate = self
        
        setupViewControllers()
        
        pageViewController.setViewControllers([viewControllers.first!], direction: .forward, animated: true, completion: nil)
        let indexPath = IndexPath(row: currentPage, section: 0)
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
    
    func setupViewControllers(){
        
        likeNodes = UserDefaults.standard.object(forKey: UserDefaultsStrings.UserLikesNodes) as! [[String: Int]]
        var pageIndex = 0
        
        for node in likeNodes {
            let topicTableViewController = storyboard?.instantiateViewController(withIdentifier: StoryBoardConfigs.UniversalTopicTableViewControllerIdentifier) as! UniversalTopicTableViewController
            topicTableViewController.nodeId = node.first?.value
            topicTableViewController.pageIndex = pageIndex
            
            viewControllers.append(topicTableViewController)
            pageIndex = pageIndex + 1
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == StoryBoardConfigs.AllNodesSeugeIdentifier{
            let toView = segue.destination as! AllNodesTableViewController
            toView.delegate = self
        }
    }
}

// MARK: UIPageViewControllerDataSource

extension HomeViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentViewController = viewController as! UniversalTopicTableViewController
        if currentViewController.pageIndex == 0{
            return nil
        }else {
            return viewControllers[currentViewController.pageIndex - 1]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentViewController = viewController as! UniversalTopicTableViewController
        if currentViewController.pageIndex == viewControllers.count - 1 {
            return nil
        }
        else {
            return viewControllers[currentViewController.pageIndex + 1]
        }
    }
}

// MARK: UICollectionViewDataSource

extension HomeViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return likeNodes.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoryBoardConfigs.HomeTabBarCellIdentifier, for: indexPath) as! HomeTabBarCollectionViewCell
        cell.reset()
        
        cell.cellName = (likeNodes[indexPath.row].first?.key)!
        if indexPath.row == currentPage {
            cell.backgroundColorView.backgroundColor = UIColor(red:0.98, green:0.98, blue:0.98, alpha:1.00)
            cell.indicatorView.isHidden = false
            //collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        }
        else{
            cell.backgroundColorView.backgroundColor = UIColor(red:0.94, green:0.94, blue:0.95, alpha:1.00)
            cell.indicatorView.isHidden = true
            
        }
        
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIConstantConfigs.PageIndicatorViewWidth, height: UIConstantConfigs.PageIndicatorViewHeight)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        let cell = collectionView.cellForItem(at: indexPath) as? HomeTabBarCollectionViewCell
        if let cell = cell {
            cell.backgroundColorView.backgroundColor = UIColor(red:0.98, green:0.98, blue:0.98, alpha:1.00)
            cell.indicatorView.isHidden = false
        }
        let fromIndexPath = IndexPath(row: lastPage, section: 0)
        self.collectionView(collectionView, didDeselectItemAt: fromIndexPath)
        lastPage = currentPage
        currentPage = indexPath.row
        DispatchQueue.main.async {
            self.pageViewController.setViewControllers([self.viewControllers[indexPath.row]], direction: .forward, animated: false, completion: nil)
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? HomeTabBarCollectionViewCell
        if let cell = cell{
            cell.backgroundColorView.backgroundColor = UIColor(red:0.94, green:0.94, blue:0.95, alpha:1.00)
            cell.indicatorView.isHidden = true
            lastPage = indexPath.row
        }
        
    }
    
}

// MARK: UIPageViewControllerDelegate
extension HomeViewController: UIPageViewControllerDelegate{
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed{
            let toIndexPath = IndexPath(row: willTransituinToPage, section: 0)
            lastPage = currentPage
            currentPage = willTransituinToPage
            collectionView.selectItem(at: toIndexPath, animated: true, scrollPosition: .centeredHorizontally)
            
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        if let toView = pendingViewControllers.first as? UniversalTopicTableViewController{
            if let pageIndex = viewControllers.index(of: toView) {
                willTransituinToPage = pageIndex
            }
        }
    }
}

// MARK: AllNodesTableViewControllerDelegate
extension HomeViewController: AllNodesTableViewControllerDelegate{
    func allNodesTableViewControllerDidChangeLikeNodes() {
        currentPage = 0
        lastPage = 0
        willTransituinToPage = 0
        viewControllers.removeAll()
        setupViewControllers()
        pageViewController.setViewControllers([viewControllers.first!], direction: .forward, animated: true, completion: nil)
        collectionView.reloadData()
    }
}


