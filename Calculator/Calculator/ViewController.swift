//
//  ViewController.swift
//  Calculator
//
//  Created by wanghuamin on 2019/6/17.
//  Copyright © 2019 wanghuamin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTyping = false
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        brain.addUnaryOperation(name: "✅"){[unowned self] in
//            self.display.textColor = UIColor.green
//            return sqrt($0)
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        brain.addUnaryOperation(name: "✅"){[weak weakSelf = self] in
            weakSelf?.display.textColor = UIColor.green
            return sqrt($0)
        }
    }
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        }else{
            if digit != "0"{
                display.text = digit
                userIsInTheMiddleOfTyping = true
            }
        }
        
       // print("\(digit) was touched")
    }

    
    var displayValue: Double{
        get{
            return Double(display.text!)!
        }
        set{
            if newValue == Double.zero{
                display.text! = String(0)
            }else{
                display.text! = String(newValue)
            }
        }
    }
    
  //  private var brain: CalculatorBrain = CalculatorBrain()
      private var brain = CalculatorBrain()
    
    @IBAction func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        }
        if let mathematicalSymbol = sender.currentTitle{
            brain.performOperation(mathematicalSymbol)
        }
        if let result = brain.result {
            displayValue = result
        }
    }
    
}

