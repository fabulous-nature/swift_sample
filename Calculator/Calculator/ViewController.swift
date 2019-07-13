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
    
    //所有视图加载到内存后调用
    override func viewDidLoad() {
        super.viewDidLoad()
        //以下是使用尾随闭包进行函数调用
        //尾随闭包是一个书写在函数括号之后的闭包表达式，函数支持将其作为最后一个参数调用。
        brain.addUnaryOperation(name: "✅"){[weak weakSelf = self] in //弱引用 解决闭包 循环依赖问题
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

