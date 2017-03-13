//
//  LoginViewController.swift
//  V2EX
//
//  Created by 张克 on 2017/3/10.
//  Copyright © 2017年 zhangke. All rights reserved.
//

import UIKit

protocol LoginViewControllerDelegate {
    func loginViewControllerDidTouchLogin(_ sender: Any)
}

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    var delegate: LoginViewControllerDelegate?
    
    @IBOutlet weak var loginView: DesignableView!
    @IBOutlet weak var usernameTextField: DesignableTextField!
    @IBOutlet weak var passwordTextField: DesignableTextField!
    @IBOutlet weak var errorMessageTextField: DesignableLabel!
    @IBAction func backButtonDidToucj(_ sender: Any) {
        loginView.animation = "fall"
        loginView.animateNext {
            self.dismiss(animated: true, completion: nil)
        }
    }
    @IBAction func loginButtonDidTouch(_ sender: Any) {
        if usernameTextField.text == "" || passwordTextField.text == "" {
            errorHandle(errorMessage: "请输入用户名或密码")
        }
        else{
            let username = usernameTextField.text
            V2EXNetworkHelper.getUser(withUsername: username!){ optionalUser in
                guard optionalUser != nil else {
                    self.errorHandle(errorMessage: "未找到该用户")
                    return
                }
                let user = optionalUser!
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                //dateFormatter.timeZone = TimeZone(abbreviation: "CST")
                let userInfo: [String: Any] = ["id": user.id,
                                "username": user.username,
                                "website": user.website ?? "",
                                "twitter": user.twitter ?? "",
                                "github": user.github ?? "",
                                "location": user.location ?? "",
                                "avatar": user.avatar,
                                "bio": user.bio ?? "",
                                "created": dateFormatter.string(from: user.created)
                                ]
                UserDefaults.standard.set(userInfo, forKey: UserDefaultsStrings.SelfInfoString)
                self.delegate?.loginViewControllerDidTouchLogin(sender)
                self.loginView.animation = "zoomOut"
                self.loginView.animateNext {
                    self.dismiss(animated: true, completion: nil)
                }
                
                
            }
            
        }
    }
    
    func errorHandle(errorMessage: String){
        errorMessageTextField.isHidden = false
        errorMessageTextField.text = errorMessage
        loginView.animation = "shake"
        loginView.animate()
    }
    

    
}
