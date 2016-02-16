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
        image = loggedInUser?.image
    }
   
    @IBAction func login() {
        loggedInUser = User.login(loginField.text ?? "", password: passwordField.text ?? "")
    }
    
    @IBAction func toggleSecurity() {
        secure = !secure
    }
    
    var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            if let constrainedView = imageView {
                if let newImage = newValue {
                    aspectRationConstraint = NSLayoutConstraint(item: constrainedView, attribute: .Width, relatedBy: .Equal, toItem: constrainedView, attribute: .Height, multiplier: newImage.aspectRatio, constant: 0)
                }
            }
        }
        
    }
    var aspectRationConstraint: NSLayoutConstraint? {
        willSet{
            if let existingConstraint = aspectRationConstraint {
                view.removeConstraint(existingConstraint)
            }
        }
        didSet{
            if let newConstraint = aspectRationConstraint {
                view.addConstraint(newConstraint)
            }
        }
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

extension UIImage {
    var aspectRatio: CGFloat {
        return size.height != 0 ? size.width / size.height : 0
    }
}
