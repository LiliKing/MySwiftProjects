//
//  ViewController.swift
//  Calculator
//
//  Created by Xiangli Jin on 16/1/13.
//  Copyright © 2016年 Xiangli Jin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    var userIsInTheMiddleOfTypingANumber :Bool = false
    var brain = CalculatorBrain()

    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if(userIsInTheMiddleOfTypingANumber){
            display.text = display.text! + digit
        } else {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
    }

    
    @IBAction func operate(sender: UIButton) {
      
        if (userIsInTheMiddleOfTypingANumber) {
            enter()
        }
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation) {
                displayValue = result
            } else {
                displayValue = 0
            }
        }
    }

  
    func perfomOperation(operation:(Double,Double) -> Double){
        if(operandStack.count >= 2){
             displayValue = operation(operandStack.removeLast(),operandStack.removeLast())
            enter()
        }
    }

    var operandStack = Array<Double>()
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
        } else {
            displayValue = 0
        }
    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        
        set {
          display.text = "\(newValue)"
          userIsInTheMiddleOfTypingANumber = false
        }
    }
    
}

