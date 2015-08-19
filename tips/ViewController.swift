//
//  ViewController.swift
//  tips
//
//  Created by Anvisha Pai on 8/10/15.
//  Copyright (c) 2015 Anvisha Pai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //UI Labels
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var billFieldContainer: UIView!
    @IBOutlet weak var totalLabelContainer: UIView!
    //Global Vars
    var tipRightNow = 0.0
    var minTip = 0.0
    var defaultTip = 0.0
    var maxTip = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStartState()
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
    
    func setStartState() {
        self.totalLabelContainer.hidden = true
        self.tipLabel.text = ""
        self.billFieldContainer.backgroundColor = self.UIColorFromRGB(0xFFFFFF)
        self.billFieldContainer.frame.origin.y = 176
        self.totalLabelContainer.frame.origin.y = 387

    }
    
    func setEditingState() {
        self.billFieldContainer.backgroundColor = self.UIColorFromRGB(0x82968C)
        self.billFieldContainer.frame.origin.y = 62
        UIView.animateWithDuration(0.6, animations: {
            self.totalLabelContainer.frame.origin.y = 254
            self.totalLabelContainer.hidden = false
//            self.totalLabelContainer.backgroundColor = self.UIColorFromRGB(0x4C3B4D)

        })
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateState() {
        tipLabel.text = String(format: "%.0f%%", tipRightNow*100)
        var billAmount = billField.text._bridgeToObjectiveC().doubleValue
        var tip = billAmount * tipRightNow
        var total = billAmount + tip
        
        totalLabel.text = String(format: "$%.2f", total)
    }
    
   
    @IBAction func onEditingChanged(sender: AnyObject) {
        if billField.text == "" {
            self.totalLabel.hidden = true
            UIView.animateWithDuration(0.6, animations: {
                self.setStartState()
            })
        }
        if billField.text != "" {
            UIView.animateWithDuration(0.4, animations: {
                self.setEditingState()
            })
            updateState()
        }

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
    
    //HELPERS
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

}

