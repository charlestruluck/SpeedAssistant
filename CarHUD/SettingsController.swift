//
//  SettingsController.swift
//  CarHUD
//
//  Created by Charles on 10/7/15.
//  Copyright © 2015 Charles. All rights reserved.
//

import Foundation
import UIKit
import Fabric
import Crashlytics
import Answers

var isInPerformanceMode = true
var usingUnit = Int(Utilities().currentSpeedUnit())
var topSpeed = Double(Utilities().setTopSpeed())
var usingAreaNum = Int(Utilities().setArea())

let setAreaData = NSUserDefaults.standardUserDefaults()
let defaults = NSUserDefaults.standardUserDefaults()
let setTopSpeedData = NSUserDefaults.standardUserDefaults()

class SettngsController: UIViewController {
    
    @IBOutlet weak var modeSelector: UISegmentedControl!
    @IBOutlet weak var settingTopSpeed: UISlider!
    @IBOutlet weak var unitOfMeasurement: UISegmentedControl!
    @IBOutlet weak var powerMode: UISegmentedControl!
    @IBOutlet weak var topSpeedLabel: UILabel!
    @IBOutlet weak var areaType: UISegmentedControl!
    
    var pastTopSpeed = Int()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        topSpeed = Double(Utilities().setTopSpeed())
        pastTopSpeed = usingUnit!
        
        if usingAreaNum != nil {
            areaType.selectedSegmentIndex = usingAreaNum!
        } else {
            usingAreaNum = 0
            areaType.selectedSegmentIndex = usingAreaNum!
        }
        
        if usingUnit != nil {
            unitOfMeasurement.selectedSegmentIndex = usingUnit!
        } else {
            usingUnit = 0
            unitOfMeasurement.selectedSegmentIndex = usingUnit!
        }
        
        if topSpeed != nil {
            settingTopSpeed.value = Float(topSpeed! / 270)
            topSpeedLabel.text = String(Int(topSpeed!))
        } else {
            topSpeed = 70
            settingTopSpeed.value = Float(topSpeed! / 270)
            topSpeedLabel.text = String(Int(topSpeed!))
        }
        
        if isInPerformanceMode == false {
            modeSelector.selectedSegmentIndex = 1
        } else {
            modeSelector.selectedSegmentIndex = 0
        }
        
        if usingUnit == 0 {
            topSpeedLabel.text! += " KPH"
        }
            
        else if usingUnit == 1 {
            topSpeedLabel.text! += " MPH"
        }
            
        else {
            topSpeedLabel.text! += " KN"
        }
        
    }
    
    @IBAction func selectedPowerMode(sender: AnyObject) {
        
        switch self.powerMode.selectedSegmentIndex {
        case 0:
            isInPerformanceMode = true
        case 1:
            isInPerformanceMode = false
        default:
            isInPerformanceMode = true
        }
        
    }
    @IBAction func updateStatistics(sender: AnyObject) {
        if pastTopSpeed != usingUnit! {
            print(usingUnit!)
            print(pastTopSpeed)
        }
    }
    
    @IBAction func changedUnit(sender: AnyObject) {
        
        switch self.unitOfMeasurement.selectedSegmentIndex {
        case 0:
            usingUnit = 0
        case 1:
            usingUnit = 1
        case 2:
            usingUnit = 2
        default:
            usingUnit = 0
        }
        
        if usingUnit == 0 {
            topSpeedLabel.text! = String(Int(settingTopSpeed.value) * 270)
            topSpeedLabel.text! += " KPH"
        }
            
        else if usingUnit == 1 {
            topSpeedLabel.text! = String(Int(settingTopSpeed.value) * 270)
            topSpeedLabel.text! += " MPH"
        }
            
        else {
            topSpeedLabel.text! = String(Int(settingTopSpeed.value) * 270)
            topSpeedLabel.text! += " KN"
        }
        
        defaults.setObject(usingUnit, forKey: "unit")
        
    }
    
    @IBAction func slidingNow(sender: AnyObject) {
        
        setTopSpeedData.setObject(String(settingTopSpeed.value * 270), forKey: "spee")
        
        topSpeedLabel.text! = String(Int(settingTopSpeed.value * 270))
        
        if usingUnit == 0 {
            topSpeedLabel.text! += " KPH"
        }
        
        else if usingUnit == 1 {
            topSpeedLabel.text! += " MPH"
        }
        
        else {
            topSpeedLabel.text! += " KN"
        }
        
        settingTopSpeed.tintColor = UIColor(red: CGFloat(settingTopSpeed.value), green: CGFloat(0.2), blue: CGFloat(0), alpha: CGFloat(1.0))
        
    }
    
    @IBAction func changedArea(sender: AnyObject) {
        
        switch self.areaType.selectedSegmentIndex {
        case 0:
            usingAreaNum = 0
        case 1:
            usingAreaNum = 1
        case 2:
            usingAreaNum = 2
        case 3:
            usingAreaNum = 3
        default:
            usingAreaNum = 0
        }
        
        setAreaData.setObject(String(usingAreaNum!), forKey: "area")
        
        print(Utilities().setArea())
        
    }
    
    @IBAction func backButton(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

class Utilities { func currentSpeedUnit() -> String {
    
    let currentSpeedUnit = defaults.stringForKey("unit")
    if let currentSpeedUnit = currentSpeedUnit { return currentSpeedUnit } else { return "1" }
    
    }
    
    func setTopSpeed() -> String {
    
    let setTopSpeed = setTopSpeedData.stringForKey("spee")
    if let setTopSpeed = setTopSpeed { return setTopSpeed } else { return "60" }
        
    }
    
    func setArea() -> String {
        
        let setArea = setAreaData.stringForKey("area")
        if let setArea = setArea { return setArea } else { return "0" }
        
    }
    
}
