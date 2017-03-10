//
//  LoginViewController.swift
//  V2EX
//
//  Created by 张克 on 2017/3/10.
//  Copyright © 2017年 zhangke. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
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
            errorMessageTextField.isHidden = false
            loginView.animation = "shake"
            loginView.animate()
        }
    }
    

    
}
