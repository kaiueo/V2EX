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
            //let username = usernameTextField.text
            //let user1 = V2EXNetworkHelper.getUserInfo(username: username!)
//            print(user1)
//            guard let user = V2EXNetworkHelper.getUserInfo(username: username!) else {
//                errorHandle(errorMessage: "找不到该用户")
//
//                return
//            }
//            loginView.animation = "slideUp"
//            loginView.animateNext { [weak self] in
//                self?.delegate?.loginViewControllerDidTouchLogin(user)
//                self?.dismiss(animated: true, completion: nil)
//            }
            
            
        }
    }
    
    func errorHandle(errorMessage: String){
        errorMessageTextField.isHidden = false
        errorMessageTextField.text = errorMessage
        loginView.animation = "shake"
        loginView.animate()
    }
    

    
}
