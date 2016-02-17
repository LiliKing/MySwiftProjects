//
//  ImageViewController.swift
//  Cassin
//
//  Created by Xiangli Jin on 16/2/16.
//  Copyright © 2016年 Xiangli Jin. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {
    var imageURL: NSURL? {
        didSet {
            image = nil
            if view.window != nil {
                fetchImage()
            }
        }
    }
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.contentSize = imageView.frame.size
            scrollView.delegate = self
            scrollView.maximumZoomScale = 1.0
            scrollView.minimumZoomScale = 0.03
        }
    }
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    private var imageView = UIImageView()
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
            scrollView?.contentSize = imageView.frame.size
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        
     
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if image == nil {
            fetchImage()
        }
    }
}
