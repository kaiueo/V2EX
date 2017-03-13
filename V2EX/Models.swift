//
//  Models.swift
//  V2EX
//
//  Created by 张克 on 2017/3/13.
//  Copyright © 2017年 zhangke. All rights reserved.
//

import Foundation

class User: NSObject {
    var id: Int!
    var username: String!
    var website: String?
    var twitter: String?
    var github: String?
    var location: String?
    var bio: String?
    var avatar: String!
    var created: Date!
    
}
