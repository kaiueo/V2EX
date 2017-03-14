//
//  V2EXNetworks.swift
//  V2EX
//
//  Created by 张克 on 2017/3/13.
//  Copyright © 2017年 zhangke. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

enum Router: URLRequestConvertible {
    static let baseURLString = "https://www.v2ex.com/api"
    
    case memberId(Int)
    case memberName(String)
    case hot
    
    func asURLRequest() throws -> URLRequest {
        let result: (path: String, params: Parameters) = {
            switch self {
            case .memberId(let id):
                let params = ["id": id]
                return ("/members/show.json", params)
            case .memberName(let username):
                let params = ["username": username]
                return ("/members/show.json", params)
            case .hot:
                let params: [String: Any] = [:]
                return ("/topics/hot.json", params)
            }
            
            
        }()
        
        let url = try Router.baseURLString.asURL()
        let urlRequest = URLRequest(url: url.appendingPathComponent(result.path))
        return try URLEncoding.default.encode(urlRequest, with: result.params)
    }
}

struct V2EXNetworkHelper {
    static func getUser(withId id: Int, complition: @escaping (User?) -> Void) {
        
        Alamofire.request(Router.memberId(id)).validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let user = getUser(withInfo: json)
                complition(user)
            case .failure(let error):
                print(error)
                complition(nil)
            }
        }
        
    }
    
    static func getUser(withUsername username: String, complition: @escaping (User?) -> Void) {

        Alamofire.request(Router.memberName(username)).validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let user = getUser(withInfo: json)
                complition(user)
            case .failure(let error):
                print(error)
                complition(nil)
            }
        }
    }
    
    static func getHotTopics(complition: @escaping (JSON?) -> Void){
        Alamofire.request(Router.hot).validate().responseJSON{
            response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                complition(json)
            case .failure(let error):
                print(error)
                complition(nil)
            }
        
        }
    }
    
    static func getImage(url: String, compllition: @escaping (UIImage?) -> Void){
        let imageUrl = "https:" + url
        Alamofire.request(imageUrl).responseData { response in
            switch response.result {
            case .success(let value):
                let image = UIImage(data: value)
                compllition(image)
            case .failure(let error):
                print(error)
                compllition(nil)
            }
        }
    }
    
    private static func getUser(withInfo json: JSON) -> User?{
        let user = User()
        guard json["status"].string! == "found" else {
            return nil
        }
        user.id = json["id"].int!
        user.username = json["username"].string!
        user.avatar = json["avatar_large"].string!
        user.website = json["website"].string
        user.twitter = json["twitter"].string
        user.github = json["github"].string
        user.location = json["location"].string
        user.bio = json["bio"].string
        user.created = Date(timeIntervalSince1970: TimeInterval(integerLiteral: json["created"].int64!))
        return user
        
    }
    
    static func test(){
        print("a")
        
        DispatchQueue.global().sync {
            for i in 1...100{
                print("\(i)")
            }
        }
        print("b")
    }
}
