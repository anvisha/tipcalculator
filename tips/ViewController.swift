//
//  ViewController.swift
//  tips
//
//  Created by Anvisha Pai on 8/10/15.
//  Copyright (c) 2015 Anvisha Pai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        billField.becomeFirstResponder()}
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Helper method to get tip value
    func getTipValue() -> Double {
        var defaults = NSUserDefaults.standardUserDefaults()
        var defaultTip = defaults.integerForKey("defaultTip")
        if defaultTip == 0 { //First time we load tip, want to set a default
            return 0.18
        }
        else {
            return Double(defaultTip)/100
        }
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        
//        var tipPercentages = [0.18, 0.2, 0.22]
//        var tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        var billAmount = billField.text._bridgeToObjectiveC().doubleValue
        println(getTipValue())
        var tip = billAmount * getTipValue()
        var total = billAmount + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)

    }

    @IBAction func onTotalDragged(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translationInView(self.view)
        if let view = recognizer.view {
            view.center = CGPoint(x:view.center.x + translation.x,
                y:view.center.y + translation.y)
        }
        recognizer.setTranslation(CGPointZero, inView: self.view)
        println("hi")
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
}

