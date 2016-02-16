//
//  ViewController.swift
//  AutoLayout
//
//  Created by Xiangli Jin on 16/2/3.
//  Copyright © 2016年 Xiangli Jin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    var loggedInUser: User? {
        didSet{
            updateUI()
        }
    }
    var secure: Bool = false {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        passwordField.secureTextEntry = secure
        passwordLabel.text = secure ? "Secured Password" : "Password"
        nameLabel.text = loggedInUser?.name
        companyLabel.text = loggedInUser?.company
        imageView.image = loggedInUser?.image
    }
   
    @IBAction func login() {
        loggedInUser = User.login(loginField.text ?? "", password: passwordField.text ?? "")
    }
    
    @IBAction func toggleSecurity() {
        secure = !secure
    }
    
    
  

}
extension User {
    var image: UIImage? {
        if let image = UIImage(named: login) {
            return image
        }else {
            return UIImage(named: "defult")
        }
    }
}
