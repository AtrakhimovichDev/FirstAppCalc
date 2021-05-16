//
//  Calculator.swift
//  Homework_10_Calc
//
//  Created by Andrei Atrakhimovich on 13.05.21.
//

import Foundation

class Calculator {
    
    private var firstNumber: Double?
    private var seconfNumber: Double?
    private var mathAction: ButtonsActions?
    private var result: Double?
    private var isBothNumberEntered = false
    private var showResult = false
    
    func makeAction(pressedAction: ButtonsActions) {
        switch pressedAction {
        case .delete:
            deleteData()
        case .equals:
            makeMathAction()
        case .percent:
            makePercentAction()
        default:
            makeMathAction()
            self.mathAction = pressedAction
        }
    }
    
    func saveNewNumber(labelValue: String) {
        if firstNumber == nil {
            firstNumber = Double(labelValue)
        } else if seconfNumber == nil {
            seconfNumber = Double(labelValue)
            isBothNumberEntered = true
        }
    }
    
    func getResult() -> String {
        if result == nil {
            return "Не определено"
        } else if result! - Double(Int(result!)) == 0 {
           return String(Int(result!))
        } else {
            return String(result!)
        }
    }
    
    func getShowResult() -> Bool {
        return showResult
    }
    
    func deleteData() {
        firstNumber = nil
        seconfNumber = nil
        mathAction = nil
        result = 0
        isBothNumberEntered = false
        showResult = false
    }
    
    private func makeMathAction() {
        guard let mathAction = self.mathAction else {
            return
        }
        if isBothNumberEntered {
            switch mathAction {
            case .plus:
                result = firstNumber! + seconfNumber!
            case .minus:
                result = firstNumber! - seconfNumber!
            case .multiply:
                result = firstNumber! * seconfNumber!
            case .divide:
                if seconfNumber == 0 {
                    result = nil
                } else {
                    result = firstNumber! / seconfNumber!
                }
            default:
                break
            }
           updateValues(result: result)
        } else {
            showResult = false
        }
    }
    
    private func makePercentAction() {
        if firstNumber != nil {
            result = firstNumber! / 100
            updateValues(result: result)
        }
    }
    
    private func updateValues(result: Double?) {
        firstNumber = result
        seconfNumber = nil
        showResult = true
        isBothNumberEntered = false
    }
}
