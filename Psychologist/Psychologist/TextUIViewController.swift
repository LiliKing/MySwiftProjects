//
//  TextUIViewController.swift
//  Psychologist
//
//  Created by Xiangli Jin on 16/2/1.
//  Copyright © 2016年 liliking. All rights reserved.
//

import UIKit

class TextUIViewController: UIViewController {

    @IBOutlet weak var textview: UITextView! {
        didSet {
            textview.text = text
        }
    }
    
    
    var text: String = "" {
        didSet{
            textview.text = text
        }
    }
}
