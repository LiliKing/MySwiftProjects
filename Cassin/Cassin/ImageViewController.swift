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
        //if let url = imageURL {
           //let imageData = NSData(contentsOfURL: url)
           // if imageData != nil {
            //    image = UIImage(data: imageData!)
           // }else {
            //    image = nil
            //}
        
        //}
        
        
        let aString = "http://comm.stanford.edu/wp-content/uploads/2013/01/stanford-campus.png"
        let url = NSURL(string: aString)
        let data = NSData(contentsOfURL: url!)
        if data != nil {
            image = UIImage(data: data!)
        }else {
            image = nil
        }
//        let strUrl = "http://e.hiphotos.baidu.com/baike/c0%3Dbaike80%2C5%2C5%2C80%2C26/sign=410619fb3d01213fdb3e468e358e5db4/9f510fb30f2442a71525d087d543ad4bd11302ec.jpg"
//        
//        //url
//        
//        let url = NSURL(string: strUrl)
//        
//        //图片数据
//        
//        var data = NSData(contentsOfURL:url!)
//        if data != nil {
//                        image = UIImage(data: data!)
//                    }else {
//                        image = nil
//                    }
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
        imageView = UIImageView()
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
