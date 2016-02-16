//
//  ImageViewController.swift
//  Cassin
//
//  Created by Xiangli Jin on 16/2/16.
//  Copyright © 2016年 Xiangli Jin. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    var imageURL: NSURL?
    private var imageView = UIImageView() {
        didSet{
            image = nil
            if view.window != nil{
                fetchImage()
            }
        }
    }
    
    private func fetchImage(){
        if let url = imageURL {
           let imageData = NSData(contentsOfURL: url)
            if imageData != nil {
                image = UIImage(data: imageData!)
            }else {
                image = nil
            }
        }
    }
    
    private var image: UIImage? {
        get { return imageView.image }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        
        if image == nil{
            imageURL = DemoURL.Stanford
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if image == nil {
            fetchImage()
        }
    }
}
