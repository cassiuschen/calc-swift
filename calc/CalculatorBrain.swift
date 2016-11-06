//
//  CalculatorBrain.swift
//  calc
//
//  Created by Cassius Chen on 2016/10/31.
//  Copyright © 2016年 Cassius Chen. All rights reserved.
//

import Foundation

func multiply(attr1: Double, attr2: Double) -> Double {
    return attr1 * attr2
}
class CalculatorBrain {
    struct PendingBinaryOperationInfo {
        var binaryOperand : (Double, Double) -> Double
        var firstAccumlator : Double
    }
    private var pending : PendingBinaryOperationInfo?
    private var accumulator = 0.0
    func setOperand(operand: Double) {
        accumulator = operand
    }
    
    var operators : Dictionary<String, Operation> = [
        "π"  : Operation.Constant(M_PI),
        "e"  : Operation.Constant(M_E),
        "cos": Operation.UnaryOperation(cos),
        "sin": Operation.UnaryOperation(sin),
        "+"  : Operation.BinaryOperation({ $0 + $1 }),
        "-"  : Operation.BinaryOperation({ $0 - $1 }),
        "×"  : Operation.BinaryOperation({ $0 * $1 }),
        "÷"  : Operation.BinaryOperation({ $0 / $1 }),
        "="  : Operation.Equals,
        "±"  : Operation.UnaryOperation({ -$0 }),
        "%"  : Operation.UnaryOperation({ 0.01 * $0 })
    ]
    
    enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equals
    }
    
    private func execPendingBinaryOperation() {
        if pending != nil {
            accumulator = pending!.binaryOperand(pending!.firstAccumlator, accumulator)
            pending = nil
        }
    }
    
    func performOperand(symbol: String) {
        if let operation = operators[symbol] {
            switch operation {
            case .Constant(let constantValue) :
                accumulator = constantValue
            case .UnaryOperation(let calcFunc):
                accumulator = calcFunc(accumulator)
            case .BinaryOperation(let calcFunc):
                execPendingBinaryOperation()
                pending = PendingBinaryOperationInfo(binaryOperand: calcFunc, firstAccumlator: accumulator)
            case .Equals:
                execPendingBinaryOperation()
            }
        }
    }
    
    var result : Double {
        get {
            return accumulator
        }
    }
}
