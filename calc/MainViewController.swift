//
//  ViewController.swift
//  calc
//
//  Created by Cassius Chen on 2016/10/10.
//  Copyright © 2016年 Cassius Chen. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet private var resultLabel: UILabel!
    @IBOutlet private var stateLabel: UILabel!
    
    private var isInTypingMode = false
    private var brain : CalculatorBrain = CalculatorBrain()
    private var displayValue : Double! {
        get {
            return Double(resultLabel.text!)!
        }
        set {
            resultLabel.text = String(newValue)
        }
    }

    @IBAction private func numberTouchedDown(_ sender: UIButton) {
        let number = sender.titleLabel!.text!
        
        if isInTypingMode {
            //stateLabel.text = stateLabel.text! + number
            resultLabel.text = resultLabel.text! + number
        } else {
            //stateLabel.text = number
            resultLabel.text = number
        }
        isInTypingMode = true
    }
    
    @IBAction private func CETouched(_ sender: UIButton) {
        displayValue = 0
        stateLabel.text = ""
    }
    
    @IBAction private func mathematicSymbolTouchedDown(_ sender: UIButton) {
        if isInTypingMode {
            brain.setOperand(operand: displayValue)
            isInTypingMode = false
        }
        if let symbol = sender.titleLabel {
            brain.performOperand(symbol: symbol.text!)
        }
        displayValue = brain.result
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

