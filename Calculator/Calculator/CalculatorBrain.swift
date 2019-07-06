//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by wanghuamin on 2019/6/19.
//  Copyright © 2019 wanghuamin. All rights reserved.
//

import Foundation

func changeSign(_ operand :Double)->Double{
    return -operand
}

func add(op1:Double,op2:Double)->Double{
    return op1 + op2
}

struct CalculatorBrain {
    
    mutating func addUnaryOperation(name sysbol: String, _ operation: @escaping (Double) -> Double) {
        operations[sysbol] = Operation.unaryOperation(operation)
    }
    private var accumulator: Double?
    
    private enum Operation{
        case constant(Double)
        case clear
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double,Double) -> Double)
        case equals
    }
    
    private var operations: Dictionary<String,Operation> = [
        "∏" : Operation.constant(Double.pi),
        "e" : Operation.constant(M_E),
        "√" : Operation.unaryOperation(sqrt),
        "±" : Operation.unaryOperation({-$0}),
       // "+" : Operation.binaryOperation(add),
        "+" : Operation.binaryOperation({(op1, op2) in return op1 + op2}),
        "-" : Operation.binaryOperation({(op1:Double, op2:Double) -> Double in
                return op1 - op2
            }),
        "÷" : Operation.binaryOperation({(op1, op2) in op1 / op2}),
        "×" : Operation.binaryOperation({$0 * $1}),
        "=" : Operation.equals,
        "C" : Operation.clear
    ]
    
    mutating func performOperation(_ symbol: String){
//        switch symbol {
//        case "∏":
//            accumulator = Double.pi
//        // display.text! = String(Double.pi)
//        case "√":
//            if let operand = accumulator{
//                 accumulator = sqrt(operand)
//            }
//            //  let operand =  Double(display.text!)!
//        //display.text = String(sqrt(operand))
//        default:
//            break
//        }
        if let operation = operations[symbol]{
            switch operation{
            case .constant(let value):
                accumulator = value
            case .unaryOperation(let function):
                if accumulator != nil {
                    accumulator = function(accumulator!)
                }
            case .clear:
                accumulator = Double.zero
            case .binaryOperation(let function):
                if accumulator != nil{
                    pbo = PendingBinaryOperation(function: function,firstOperand:accumulator!)
                    accumulator = nil
                }
            case .equals:
                 performPendingBinargOperantion()
            }
        }
    }
    
    
    private mutating func performPendingBinargOperantion(){
        if pbo != nil && accumulator != nil{
             accumulator = pbo.perform(with: accumulator!)
            pbo = nil
        }
       
    }
    
    
    private var pbo: PendingBinaryOperation!
    
    private struct PendingBinaryOperation{
        let function: (Double,Double) -> Double
        let firstOperand: Double
        
        func perform(with secondOperand: Double) ->Double{
            return function(firstOperand,secondOperand)
        }
    }
    
    mutating func setOperand(_ operand: Double){
        accumulator = operand
    }
    
    var result: Double?{
        get {
            return accumulator
        }
    }
}
