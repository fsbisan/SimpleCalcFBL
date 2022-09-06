//
//  CalcService.swift
//  SimpleCalcFBL
//
//  Created by Александр Макаров on 05.09.2022.
//

import Foundation


final class CalcService {
    
    // MARK: - Properties
    
    var isRunning = true
    var currentNumber = "0"
    var firstNumber = 0.0
    var secondNumber = 0.0
    var result = ""
    var currentOperation = Operations.noAction
    var displayView: ViewController
    
    init(displayView: ViewController) {
        self.displayView = displayView
    }
    
    //MARK: - Methods
    func numberAction(number: Int) {
        if currentNumber != "0" {
            currentNumber.append(String(number))
            displayView.updateDisplay(text: currentNumber)
        } else {
            currentNumber = String(number)
            displayView.updateDisplay(text: currentNumber)
        }
    }
    
    func makeCalculation(operation: Operations) {
        if currentOperation != .noAction {
            if currentNumber != "" {
                secondNumber = Double(currentNumber) ?? 0.0
                switch operation {
                case .addition:
                    result = String(firstNumber + secondNumber)
                case .subtraction:
                    result = String(firstNumber - secondNumber)
                case .multiplication:
                    result = String(firstNumber * secondNumber)
                case .division:
                    guard secondNumber != 0 else {
                        return
                    }
                    result = String(firstNumber / secondNumber)
                default:
                    break
                }
                
                guard let doubleResult = Double(result) else { return }
                firstNumber = doubleResult
                if doubleResult.truncatingRemainder(dividingBy: 1) == 0 {
                    result = String(Int(doubleResult))
                }
                currentNumber = result
                displayView.updateDisplay(text: currentNumber)
                currentOperation = operation
            }
        } else {
            firstNumber = Double(currentNumber) ?? 0.0
            currentNumber = ""
            displayView.updateDisplay(text: currentNumber)
            currentOperation = operation
        }
        
    }
    func addition() {
        makeCalculation(operation: .addition)
    }
    
    func subtraction() {
        makeCalculation(operation: .subtraction)
    }
    
    func multiplication () {
        makeCalculation(operation: .multiplication)
    }
    
    func division () {
        makeCalculation(operation: .division)
    }
    
    func makeResult() {
        makeCalculation(operation: currentOperation)
    }
    
    func acAction() {
        currentNumber = "0"
        firstNumber = 0.0
        secondNumber = 0.0
        result = ""
        currentOperation = Operations.noAction
        displayView.updateDisplay(text: currentNumber)
    }
    
    func changeSign() {
        var temp  = currentNumber
        if temp.contains("-") {
            let sign = ["-"]
            temp = String(temp.filter { !sign.contains(String($0)) })
            displayView.updateDisplay(text: temp)
            currentNumber = temp
        } else {
            temp = "-" + currentNumber
            displayView.updateDisplay(text: temp)
            currentNumber = temp
        }
    }
    
    func percent() {
        guard let doubletCurrentNumber = Double(currentNumber) else { return }
        currentNumber = String(doubletCurrentNumber / 100)
        displayView.updateDisplay(text: currentNumber)
        result = currentNumber
        guard let result = Double(result) else { return }
        firstNumber = result
    }
    
    func dot() {
        if currentNumber.contains(".") {
            return
        } else {
            currentNumber += "."
            displayView.updateDisplay(text: currentNumber)
        }
    }
}
