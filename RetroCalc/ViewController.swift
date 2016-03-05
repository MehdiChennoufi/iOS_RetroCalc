//
//  ViewController.swift
//  RetroCalc
//
//  Created by Mehdi Chennoufi on 28/02/2016.
//  Copyright © 2016 Mehdi Chennoufi. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    // ========== CONSTANTS & VARIABLES ========== //
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Add = "+"
        case Substract = "-"
        case Empty = "Empty"
    }
    
    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    var currentOperation: Operation = Operation.Empty
    
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
     
    // ========== ON START ========== //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. ===
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        
        // 2. ===
        let soundURL = NSURL(fileURLWithPath: path!)
        
        // 3. ===
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }

    
    // =========== @IBACTION FUNCTIONS  ===========
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
   
    @IBAction func onSubstractPressed(sender: AnyObject) {
        processOperation(Operation.Substract)
    }

    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    @IBAction func numberPressed(btn: UIButton!) {
        playSound()
        
        runningNumber += "\(btn.tag)"
        outputLbl.text = runningNumber
    }
    
    @IBAction func clreaPressed(sender: AnyObject) {
        clearEverything()
    }
    
    
    //============== DO MATH ======================//
    
    func processOperation(op: Operation) {
        
        playSound()
        
        if currentOperation != Operation.Empty {
            //Run some Math
            
            // A user selected operator, but then selected another operator without
            // first entering a number
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                
                // Here I transformed into Switch/case statement and add a security if the user
                // pressed an operator first without pressed any number (the app was crashing otherwise)
                switch currentOperation {
                
                    case Operation.Multiply:
                        if (leftValStr != "") {
                            result = "\(Double(leftValStr)! *  Double(rightValStr)!)"
                        }
                        
                        else {
                            leftValStr = "\(0)"
                            result = "\(Double(leftValStr)! *  Double(rightValStr)!)"
                        }
                    
                    case Operation.Divide:
                        if (leftValStr != "") {
                            result = "\(Double(leftValStr)! /  Double(rightValStr)!)"
                        }
                        
                        else {
                            leftValStr = "\(0)"
                            result = "\(Double(leftValStr)! /  Double(rightValStr)!)"
                        }
                    
                    case Operation.Substract:
                        if (leftValStr != "") {
                            result = "\(Double(leftValStr)! -  Double(rightValStr)!)"
                        }
                        
                        else {
                            leftValStr = "\(0)"
                            result = "\(Double(leftValStr)! -  Double(rightValStr)!)"
                        }
                    
                    case Operation.Add:
                        if (leftValStr != "") {
                            result = "\(Double(leftValStr)! +  Double(rightValStr)!)"
                        }
                        
                        else {
                            leftValStr = "\(0)"
                            result = "\(Double(leftValStr)! +  Double(rightValStr)!)"
                        }
                
                    default:
                        leftValStr = "\(0)"
                        rightValStr = "\(0)"
                        outputLbl.text = "\(0)"
                        currentOperation = op
                    
                    }
            }
            
            leftValStr = result
            outputLbl.text = result
            currentOperation = op
            
            
            
        } else {
            //This is the first time an operator has beeen pressed
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = op
        }
        
    }
    
    //============== OTHERS FUNCTIONS =================//
    
    func playSound() {
        if btnSound.playing {
            btnSound.stop()
        }
        
        btnSound.play()
    }
    
    
    func clearEverything() {
       leftValStr = ""
       rightValStr = ""
       result = ""
       runningNumber = ""
       currentOperation = Operation.Empty
       outputLbl.text = "\(0)"
    }
}

