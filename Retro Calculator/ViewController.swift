//
//  ViewController.swift
//  Retro Calculator
//
//  Created by Angel Contreras on 3/10/16.
//  Copyright © 2016 Angel Contreras. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String{
        case Divide = "/"
        case Multiply = "*"
        case Subract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    var currentOperation:Operation = Operation.Empty
    
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        outputLbl.text = "0"
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do{
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay()
        } catch let err as NSError{
            print(err.debugDescription)
        }
    }
    
    @IBAction func clearPressed(btn: UIButton!){
        reset()
    }
    
    @IBAction func numberPressed(btn: UIButton!){
        playSound()
        appendToOutput(btn.tag)
        //TODO: Left of on 42 mins
        
    }
    
    @IBAction func onDividePress(btn: UIButton!) {
        pressedOperation(Operation.Divide)
//        rightValStr = self.runningNumber
//        runningNumber = ""
        currentOperation = Operation.Divide
    }
    
    @IBAction func onMultiplyPressed(sender: UIButton) {
        pressedOperation(Operation.Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: UIButton) {
        pressedOperation(Operation.Subract)
    }
    
    @IBAction func onAddPressed(sender: UIButton) {
        pressedOperation(Operation.Add)
    }
    
    @IBAction func onEqualPressed(sender: UIButton) {
        pressedOperation(currentOperation)
//        var equals: Float?
//        equals = Float(rightValStr)! / Float(runningNumber)!
//        outputLbl.text = "\(equals!)"
//        equals = nil
//        reset()
    }

    
    func appendToOutput(btnValue: Int){
        self.runningNumber += "\(btnValue)"
        outputLbl.text = runningNumber
    }
    
    func reset(){
        playSound()
        outputLbl.text = "0"
        rightValStr = ""
        leftValStr = ""
        runningNumber = ""
        currentOperation = Operation.Empty
    }
    
    func pressedOperation(op:Operation){
        playSound()
        
        if currentOperation != Operation.Empty{
            
            if runningNumber != ""{
            rightValStr = runningNumber
            runningNumber = ""
            
            if currentOperation == Operation.Multiply {
                result = "\(Double(leftValStr)! * Double(rightValStr)!)"
            } else if currentOperation == Operation.Divide {
                result = "\(Double(leftValStr)! / Double(rightValStr)!)"
            } else if currentOperation == Operation.Subract {
                result = "\(Double(leftValStr)! - Double(rightValStr)!)"
            } else if currentOperation == Operation.Add {
                result = "\(Double(leftValStr)! + Double(rightValStr)!)"
            }
            
            leftValStr = result
            outputLbl.text = result
            }
            currentOperation = op
            
        } else {
            //TODO: first time operator is being pressed
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = op
        }
    }
    
    func playSound(){
        if btnSound.playing{
            btnSound.stop()
        }
        btnSound.play()
    }
    
    
}

