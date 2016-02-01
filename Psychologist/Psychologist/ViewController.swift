//
//  ViewController.swift
//  Happiness
//
//  Created by Xiangli Jin on 16/1/25.
//  Copyright © 2016年 Xiangli Jin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, FaceViewDataSource {
    
    var happiness: Int = 25{
        didSet{
            happiness = min(max(happiness, 0), 100)
            
            updateUI()
        }
    }
    
    private struct Constants{
        static let happinessGestureScale: CGFloat = 4
    }

    @IBAction func ChangeHappiness(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
            case .Ended:fallthrough
            case .Changed:
                let translation = gesture.translationInView(faceView)
                let happinessChange = (Int)(translation.y / Constants.happinessGestureScale)
                if happinessChange != 0{
                    happiness += happinessChange
                    gesture.setTranslation(CGPointZero, inView: faceView)
                }
        default: break
        }
        
    }
    @IBOutlet weak var faceView: FaceView!{
        didSet{
            faceView.faceViewDataSource = self
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: "scale:"))
          
        }
    }
   
    
    private func updateUI(){
        faceView?.setNeedsDisplay()
    }
    
    func smilinessForFaceView(sender: FaceView)-> Double? {
        return (Double(happiness) - 50.0)/50.0
    }

}

