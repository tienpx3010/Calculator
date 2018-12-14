//
//  ViewController.swift
//  Calculator
//
//  Created by pham.xuan.tien on 12/12/18.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var resultLabel: UILabel!
    var currentNumber = 0.0
    var previousNumber = 0.0
    var operation = ""
    var hasOperation = false

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func buttonClicked(sender: UIButton) {
        guard let text = sender.titleLabel?.text else {
            return
        }
        switch text {
        case "+", "x", "/", "-":
            if hasOperation {
                return
            }
            operation = text
            hasOperation = true
            previousNumber = Double(resultLabel.text!)!
            break
        case "=":
            calculate()
            break
        case "C":
            reset()
            break
        case ".":
            resultLabel.text = resultLabel.text! + "."
            break
        case "%":
            break
        case "+/-":
            if(currentNumber < 0) {
                currentNumber = fabs(currentNumber)
            } else {
                currentNumber = -currentNumber
            }
            printResult()
            break
        default:
            if(resultLabel.text == "0") {
                resultLabel.text = ""
            }
            if hasOperation {
                resultLabel.text = text
                hasOperation = false
            } else {
                resultLabel.text = resultLabel.text! + text
            }
            currentNumber = Double(resultLabel.text!)!
            break
        }
    }

    func reset() {
        currentNumber = 0.0
        previousNumber = 0.0
        operation = ""
        resultLabel.text = "0"
    }

    func calculate() {
        let result = doMath()
        if result <= 9999999 {
            currentNumber = result
            printResult()
        }
    }

    func printResult() {
        if currentNumber.truncatingRemainder(dividingBy: 1) == 0 {
            resultLabel.text = String(Int(currentNumber))
        } else {
            resultLabel.text = String(currentNumber)
        }
    }

    func doMath() -> Double {
        switch operation {
        case "+":
            return previousNumber + currentNumber
        case "-":
            return previousNumber - currentNumber
        case "x":
            return previousNumber * currentNumber
        case "/":
            return previousNumber / currentNumber
        default:
            return 0
        }
    }

}
