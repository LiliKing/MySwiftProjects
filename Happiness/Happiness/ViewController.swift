//
//  ViewController.swift
//  Happiness
//
//  Created by Xiangli Jin on 16/1/25.
//  Copyright © 2016年 Xiangli Jin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, FaceViewDataSource {
    

    @IBOutlet weak var faceView: FaceView!{
        didSet{
            faceView.faceViewDataSource = self
        }
    }
    var happiness: Int = 100{
        didSet{
            happiness = min(max(happiness, 0), 100)
        
            upDataUI()
        }
    }
    
    private func upDataUI(){
        faceView.setNeedsDisplay()
    }
    
    func smilinessForFaceView(sender: FaceView)-> Double? {
        return (Double(happiness) - 50.0)/50.0
    }

}

