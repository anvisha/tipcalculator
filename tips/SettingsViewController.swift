//
//  SettingsViewController.swift
//  tips
//
//Users/anvisha/tips/tips/SettingsViewController.swift/  Created by Anvisha Pai on 8/13/15.
//  Copyright (c) 2015 Anvisha Pai. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var defaultTipAmount: UITextField!
    @IBOutlet weak var minTipAmount: UITextField!
    @IBOutlet weak var maxTipAmount: UITextField!
    @IBOutlet weak var settingsDone: UIBarButtonItem!
    @IBOutlet weak var tipDefault: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        println("hellosettings")
        super.viewWillAppear(animated)
        var defaults = NSUserDefaults.standardUserDefaults()
        defaultTipAmount.text = String(format: "%0.f%%", defaults.doubleForKey("defaultTip")*100)
        minTipAmount.text = String(format: "%.0f%%", defaults.doubleForKey("minTip")*100)
        maxTipAmount.text = String(format: "%.0f%%", defaults.doubleForKey("maxTip")*100)
    }

    
    @IBAction func settingsDoneClicked(sender: AnyObject) {
        //set default tip amounts in format [default, min, max]
        
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setDouble(defaultTipAmount.text._bridgeToObjectiveC().doubleValue/100, forKey: "defaultTip")
        defaults.setDouble(minTipAmount.text._bridgeToObjectiveC().doubleValue/100, forKey: "minTip")
        defaults.setDouble(maxTipAmount.text._bridgeToObjectiveC().doubleValue/100, forKey: "maxTip")

        defaults.synchronize()
        dismissViewControllerAnimated(true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
