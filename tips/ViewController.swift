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
    
    var tipRightNow = 0.20
    var minTip = 0.18
    var defaultTip = 0.20
    var maxTip = 0.22
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        handleDefaults()
        
        // Do any additional setup after loading the view, typically from a nib.
        dismissViewControllerAnimated(true, completion: nil)
        billField.becomeFirstResponder()}
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func handleDefaults() {
        var defaults = NSUserDefaults.standardUserDefaults()
        if defaults.doubleForKey("defaultTip") == 0 {
            defaults.setDouble(0.20, forKey: "defaultTip")
            defaults.setDouble(0.18, forKey: "minTip")
            defaults.setDouble(0.22, forKey: "maxTip")
            defaults.synchronize()
            
        }
        defaultTip = defaults.doubleForKey("defaultTip")
        minTip = defaults.doubleForKey("minTip")
        maxTip = defaults.doubleForKey("maxTip")
        
        tipRightNow = defaultTip

    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateState() {
        tipLabel.text = String(format: "$%.2f", tipRightNow)
        var billAmount = billField.text._bridgeToObjectiveC().doubleValue
        var tip = billAmount * tipRightNow
        var total = billAmount + tip
        
        totalLabel.text = String(format: "$%.2f", total)
    }
    
   
    @IBAction func onEditingChanged(sender: AnyObject) {
        
        updateState()

    }
    
    var xStart: Double = 0.0
    
    @IBAction func onTotalDragged(recognizer: UIPanGestureRecognizer) {
        var translation = recognizer.translationInView(self.view)
        if recognizer.state == UIGestureRecognizerState.Began {
            xStart = tipRightNow
        }
        
        else if recognizer.state == UIGestureRecognizerState.Changed {
            var translation = Float(translation.x)
            var delta = Double(Float(xStart) - translation / 2000)
            delta = delta > maxTip ? maxTip : delta
            delta = delta < minTip ? minTip : delta
            tipRightNow = Double(round(delta*100)/100)
            updateState()
        }
//        println(translation.x)
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
}

