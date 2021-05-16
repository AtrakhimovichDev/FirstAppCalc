//
//  ViewController.swift
//  Homework_10_Calc
//
//  Created by Andrei Atrakhimovich on 13.05.21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var allButtons: [UIButton]!
    @IBOutlet weak var labelInputField: UILabel!
    
    private let calculator = Calculator()
    private var needToSaveNumber = false
    private var equalsPressed = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelInputField.text = "0"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        makeButtonsRound()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: nil) { _ in
            self.makeButtonsRound()
        }
    }
    
    @IBAction func numberButtonPressed(_ sender: UIButton) {
        if let buttonValue = ButtonsValues.init(rawValue: sender.restorationIdentifier ?? "") {
            inputSymbol(buttonValue: buttonValue)
        }
    }
    
    @IBAction func actionButtonPressed(_ sender: UIButton) {
        if let buttonAction = ButtonsActions.init(rawValue: sender.restorationIdentifier ?? "") {
            inputAction(buttonAction: buttonAction)
        }
    }
    
    @IBAction func cButtonPressed(_ sender: Any) {
        deleteData()
    }
    
    private func inputSymbol(buttonValue: ButtonsValues) {
        switch buttonValue {
        case .zero:
            printSymbol(numberValue: "0")
        case .one:
            printSymbol(numberValue: "1")
        case .two:
            printSymbol(numberValue: "2")
        case .three:
            printSymbol(numberValue: "3")
        case .four:
            printSymbol(numberValue: "4")
        case .five:
            printSymbol(numberValue: "5")
        case .six:
            printSymbol(numberValue: "6")
        case .seven:
            printSymbol(numberValue: "7")
        case .eight:
            printSymbol(numberValue: "8")
        case .nine:
            printSymbol(numberValue: "9")
        case .comma:
            printSymbol(numberValue: ".")
        case .plusMinus:
            printSymbol(numberValue: "-")
        }
        
    }
        
    private func printSymbol(numberValue: String) {
        var addSymbol: Bool
        if equalsPressed {
            calculator.deleteData()
            equalsPressed = false
            addSymbol = false
        } else if !needToSaveNumber || labelInputField.text == "0"{
            addSymbol = false
        } else {
            addSymbol = true
        }
        changeLabelText(symbol: numberValue, addSymbol: addSymbol)
        needToSaveNumber = true
    }
    
    private func changeLabelText(symbol: String, addSymbol: Bool) {
        if symbol == "." {
            if !labelInputField.text!.contains(".") {
                labelInputField.text! += "."
            }
        } else if symbol == "-" {
            if labelInputField.text! != "0" {
                if labelInputField.text!.contains("-") {
                    labelInputField.text! = labelInputField.text!.replacingOccurrences(of: "-", with: "")
                } else {
                    labelInputField.text! = "-" + labelInputField.text!
                }
            }
        } else {
            if addSymbol {
                labelInputField.text! += symbol
            } else {
                labelInputField.text! = symbol
            }
        }
    }
    
    private func inputAction(buttonAction: ButtonsActions) {
        checkEqualsButtonPressed(buttonAction: buttonAction)
        if needToSaveNumber {
            calculator.saveNewNumber(labelValue: labelInputField.text!)
            needToSaveNumber = false
        }
        calculator.makeAction(pressedAction: buttonAction)
        if calculator.getShowResult() {
            labelInputField.text! = calculator.getResult()
        }
    }
    
    private func checkEqualsButtonPressed(buttonAction: ButtonsActions) {
        if buttonAction == .equals {
            equalsPressed = true
        } else {
            equalsPressed = false
        }
    }
    
    private func deleteData() {
        calculator.makeAction(pressedAction: .delete)
        labelInputField.text! = "0"
        equalsPressed = false
    }
    
    private func makeButtonsRound() {
        for button in allButtons {
            button.layer.cornerRadius = button.frame.height / 2
        }
    }
}

