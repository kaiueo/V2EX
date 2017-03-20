//
//  StoryBoardConfigs.swift
//  V2EX
//
//  Created by 张克 on 2017/3/13.
//  Copyright © 2017年 zhangke. All rights reserved.
//

import Foundation

struct StoryBoardConfigs {
    static let LoginSegueIdentifier = "LoginSegue"
    static let TopicCellIdentifier = "TopicCell"
    static let HotTopicTableViewControllerIdentifier = "HotTopicTableViewController"
    static let LatestTopicTableViewControllerIdentifier = "LatestTopicTableViewController"
    static let TopicDetailCellIdentifier = "TopicDetailCell"
    static let TopicCommentCellIdentifier = "TopicCommentCell"
    static let LatestToDetailSegueIdentifier = "LatestToDetailSegue"
    static let HotToDetailSegueIdentifier = "HotToDetailSegue"
    static let TopicDetailTableViewControllerIdentifier = "TopicDetailTableViewController"
    static let UniversalTopicTableViewControllerIdentifier = "UniversalTopicTableViewController"
    static let UniversalToDetailSegueIdentifier = "UniversalToDetailSegue"
    static let HomeTabBarCellIdentifier = "HomeTabBarCell"
    
    
}

struct UIConstantConfigs {
    static let PageIndicatorViewWidth = 120
    static let PageIndicatorViewHeight = 25

}

struct UserDefaultsStrings {
    static let SelfInfoString = "self-info"
    static let UserLikesNodes = "user-likes-nodes"
}
