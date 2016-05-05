//
//  ViewController.swift
//  Calculator
//
//  Created by Sam Fox on 4/17/16.
//  Copyright (c) 2016 Sam Fox. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var stackDisplay: UILabel!
    
    var userIsInTheMiddleOfTypingANumber = false
    var decimalEntered = false
    var brain = CalculatorBrains()
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
        }
        else {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
    }
    
    @IBAction func pi() {
        userIsInTheMiddleOfTypingANumber = true
        display.text = "\(M_PI)"
    }
    
    @IBAction func appendDecimal() {
        
        if !decimalEntered {
            if userIsInTheMiddleOfTypingANumber {
                display.text = display.text! + "."
            }
            else {
                display.text = "0."
            }
        }
        decimalEntered = true
        userIsInTheMiddleOfTypingANumber = true
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
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
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        decimalEntered = false
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
        } else {
            displayValue = 0
        }
    }
    
    @IBAction func clear(sender: UIButton) {
        brain.clear()
        displayValue = 0
    }
    
    var displayValue: Double {
        get {
            println("\(NSNumberFormatter().numberFromString(display.text!)!.doubleValue)")
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }
    
    var stackDisplayValue: String {
        get {
            return ""
        }
        set {
            
        }
    }
    
}

