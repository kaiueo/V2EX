//
//  SelfViewController.swift
//  V2EX
//
//  Created by 张克 on 2017/3/13.
//  Copyright © 2017年 zhangke. All rights reserved.
//

import UIKit
import SafariServices

class SelfViewController: UIViewController, LoginViewControllerDelegate {

    @IBOutlet weak var loginButton: UIBarButtonItem!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var createdLabel: UILabel!
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var twitterButton: UIButton!
    @IBOutlet weak var githubButton: UIButton!
    @IBOutlet weak var websiteButton: UIButton!
    @IBOutlet weak var biographyTextView: UITextView!
    
    var user: [String: Any]!
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButtonDidTouch(_ sender: Any) {
        if isLogin() {
            UserDefaults.standard.removeObject(forKey: UserDefaultsStrings.SelfInfoString)
            resetDefaultInfo()
        }
        else{
            performSegue(withIdentifier: StoryBoardConfigs.LoginSegueIdentifier, sender: self)
        }
    }
    func initViews(){
        loadSelfInfo()
        if isLogin(){
            loginButton.image = UIImage(named: "self-logout")
        }
        else{
            loginButton.image = UIImage(named: "self-login")
        }
        
        
    }
    
    func loadSelfInfo(){
        let userInfo = UserDefaults.standard.object(forKey: "self-info")
        if let user = userInfo as? [String: Any] {
            self.user = user
            fillWithUserInfo()
        }
    }
    func fillWithUserInfo(){
        usernameLabel.text = user["username"] as! String?
        createdLabel.text = "V2EX第 " + String(user["id"] as! Int) + " 号会员，加入于 " + (user["created"] as! String!)
        biographyTextView.text = user["bio"] as! String?
        V2EXNetworkHelper.getImage(url: user["avatar"] as! String){
            image in
            self.avatarImageView.image = image
        }
        if user["location"] as! String != "" {
            user["location"] = "https://www.google.com/maps?q=" + (user["location"] as! String)
            locationButton.isEnabled = true
        }
        if user["twitter"] as! String != "" {
            twitterButton.isEnabled = true
        }
        if user["github"] as! String != "" {
            githubButton.isEnabled = true
        }
        if user["website"] as! String != "" {
            websiteButton.isEnabled = true
        }

    }
    func isLogin() -> Bool{
        let userInfo = UserDefaults.standard.object(forKey: "self-info")
        if userInfo == nil {
            return false
        }
        else{
            return true
        }
    }
    
    func resetDefaultInfo(){
        user = nil
        avatarImageView.image = UIImage(named: "self-avatar-default")
        usernameLabel.text = "未登录"
        createdLabel.text = ""
        websiteButton.isEnabled = false
        twitterButton.isEnabled = false
        githubButton.isEnabled = false
        locationButton.isEnabled = false
        biographyTextView.text = ""
        loginButton.image = UIImage(named: "self-login")
    }

    
    @IBAction func selfInfoButtonsDidTouch(_ sender: UIButton) {
        let buttonType = sender.currentTitle!
        let targetURLString = user[buttonType]
        let targetURL = URL(string: targetURLString as! String)
        let safariViewController = SFSafariViewController(url: targetURL!)
        present(safariViewController, animated: true, completion: nil)
    }
    
    // MARK: PrepareSegues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == StoryBoardConfigs.LoginSegueIdentifier {
            let toView = segue.destination as! LoginViewController
            toView.delegate = self
        }
    }
    
    // MARK: LoginViewControllerDelegate
    func loginViewControllerDidTouchLogin(_ sender: Any) {
        initViews()
    }

    
}
