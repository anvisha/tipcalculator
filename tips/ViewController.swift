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
    @IBOutlet var viewContainer: UIView!
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
    var darkMode = false
    var editingStarted = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStartState()
        handleDefaults()
        showOldData()
        // Do any additional setup after loading the view, typically from a nib.
        dismissViewControllerAnimated(true, completion: nil)
        billField.becomeFirstResponder()}
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        handleDefaults()
        if billField.text == "" {
            setStartState()
        }
        else {
            setEditingState()
        }
    }
    
    func handleDefaults() {
        var defaults = NSUserDefaults.standardUserDefaults()
        if defaults.doubleForKey("defaultTip") == 0 {
            defaults.setDouble(0.20, forKey: "defaultTip")
            defaults.setDouble(0.18, forKey: "minTip")
            defaults.setDouble(0.22, forKey: "maxTip")
            defaults.setBool(false, forKey: "darkMode")
            defaults.synchronize()
            
        }
        defaultTip = defaults.doubleForKey("defaultTip")
        minTip = defaults.doubleForKey("minTip")
        maxTip = defaults.doubleForKey("maxTip")
        darkMode = defaults.boolForKey("darkMode")
        
        println(darkMode)
        println("hellodarkmode")
        
        tipRightNow = defaultTip
        
//        defaults.setDouble(billAmount, forKey: "lastBillAmount")
//        defaults.setDouble(tipRightNow, forKey: "lastTipPercentage")
//        defaults.setObject(NSDate(), forKey: "lastDate")
    }
    
    func showOldData() {
        var defaults = NSUserDefaults.standardUserDefaults()
        let lastDate = defaults.objectForKey("lastDate") as! NSDate
        let elapsedTime = NSDate().timeIntervalSinceDate(lastDate)
        
        if elapsedTime < 600 {
            tipRightNow = defaults.doubleForKey("lastTipPercentage")
            billField.text = String(format: "%.2f", defaults.doubleForKey("lastBillAmount"))
            println("hello")
            billField.endEditing(true)
            updateState()
        }
    }

    func enableDarkMode() {
        self.viewContainer.backgroundColor = self.UIColorFromRGB(0x0C0C0C)
        self.billFieldContainer.backgroundColor = self.UIColorFromRGB(0x0C0C0C)
        self.totalLabelContainer.backgroundColor = self.UIColorFromRGB(0x300B1F)
        self.totalLabel.textColor = self.UIColorFromRGB(0xFFFFFF)
        self.billField.textColor = self.UIColorFromRGB(0xFFFFFF)
        self.tipLabel.textColor = self.UIColorFromRGB(0xFFFFFF)
    }
    
    func setStartState() {
        if darkMode {
            enableDarkMode()
        
        }
        else {
            self.viewContainer.backgroundColor = self.UIColorFromRGB(0xFFFFFF)
            self.billFieldContainer.backgroundColor = self.UIColorFromRGB(0xFFFFFF)
            self.billField.textColor = self.UIColorFromRGB(0x0C0C0C)
        }
        
        self.totalLabelContainer.hidden = true
        self.tipLabel.text = ""
                self.billFieldContainer.frame.origin.y = 176
        self.totalLabelContainer.frame.origin.y = 387

    }
    
    func setEditingState() {
        if darkMode {
            enableDarkMode()
        
        }
        else{
            self.viewContainer.backgroundColor = self.UIColorFromRGB(0xFFFFFFF)
            self.billFieldContainer.backgroundColor = self.UIColorFromRGB(0x82968C)
            self.tipLabel.textColor = self.UIColorFromRGB(0x0C0C0C)
            self.billField.textColor = self.UIColorFromRGB(0x0C0C0C)
            self.totalLabel.textColor = self.UIColorFromRGB(0x0C0C0C)
            self.totalLabelContainer.backgroundColor = self.UIColorFromRGB(0xFFCC66)
        }
        self.billFieldContainer.frame.origin.y = 62
        UIView.animateWithDuration(0.5, animations: {
            println("so this happened")
            self.totalLabelContainer.frame.origin.y = 234
            self.totalLabelContainer.hidden = false

        })
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateState() {
        tipLabel.text = String(format: "%.0f%%", tipRightNow*100)
        println(billField.text)
        var billAmount = billField.text._bridgeToObjectiveC().doubleValue
        println(billAmount)
        println(tipRightNow)
        var tip = billAmount * tipRightNow
        var total = billAmount + tip
        println(total)
        totalLabel.text = String(format: "$%.2f", total)
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setDouble(billAmount, forKey: "lastBillAmount")
        defaults.setDouble(tipRightNow, forKey: "lastTipPercentage")
        defaults.setObject(NSDate(), forKey: "lastDate")
        defaults.synchronize()
    }
    
   
    @IBAction func onEditingChanged(sender: AnyObject) {
        if billField.text == "" {
            editingStarted = false
            UIView.animateWithDuration(0.6, animations: {
                self.setStartState()
            })
        }
        if (billField.text != "") {
            if (editingStarted == false) {
                editingStarted = true
                UIView.animateWithDuration(0.4, animations: {
                    self.setEditingState()
                })
            }
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

