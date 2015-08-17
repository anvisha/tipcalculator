//
//  SettingsViewController.swift
//  tips
//
//Users/anvisha/tips/tips/SettingsViewController.swift/  Created by Anvisha Pai on 8/13/15.
//  Copyright (c) 2015 Anvisha Pai. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var defaultTipAmount: UISlider!
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
    
    @IBAction func settingsDoneClicked(sender: AnyObject) {
        var defaultTip = defaultTipAmount.value
        println(defaultTip)
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(18, forKey: "defaultTip")
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
