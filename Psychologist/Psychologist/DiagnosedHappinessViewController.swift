//
//  DiagnosedHappinessViewController.swift
//  Psychologist
//
//  Created by Xiangli Jin on 16/2/1.
//  Copyright © 2016年 liliking. All rights reserved.
//

import UIKit

class DiagnosedHappinessViewController: ViewController, UIPopoverPresentationControllerDelegate {
    
    override var happiness: Int {
        didSet{
            diagnosticHistory += [happiness]
        }
    }
    
    private let defaults = NSUserDefaults.standardUserDefaults()
    var diagnosticHistory : [Int]{
        get { return defaults.objectForKey(History.DefaultsKey) as? [Int] ?? [] }
        set { defaults.setObject(newValue, forKey: History.DefaultsKey)}
    }
    
    private struct History{
        static let SegurIdentifier = "Show Diagnostic History"
        static let DefaultsKey = "DiagnosedHappinessViewController.History"
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier{
                case History.SegurIdentifier:
                    if let tvc = segue.destinationViewController as? TextUIViewController{
                        if let ppc = tvc.popoverPresentationController{
                            ppc.delegate = self
                        }
                        print("\(diagnosticHistory)")
                        tvc.text = "\(diagnosticHistory)"
                    }
                default: break
            }
        }
    }
    
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle{
        return  UIModalPresentationStyle.None
    }
}
