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
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        }else{
            display.text = digit
            userIsInTheMiddleOfTyping = true
        }
        
        print("\(digit) was touched")
    }

    
    var displayValue: Double{
        get{
            return Double(display.text!)!
        }
        set{
            display.text! = String(newValue)
        }
    }
    
    
    @IBAction func performOperation(_ sender: UIButton) {
        userIsInTheMiddleOfTyping = false
        if let mathematicalSymbol = sender.currentTitle{
            switch mathematicalSymbol {
            case "∏":
                 displayValue = Double.pi
               // display.text! = String(Double.pi)
            case "√":
                displayValue = sqrt(displayValue)
              //  let operand =  Double(display.text!)!
                //display.text = String(sqrt(operand))
            default:
                break
            }
        }
    }
    
}

