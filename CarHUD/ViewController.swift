//
//  ViewController.swift
//  CarHUD (cleardisplay)
//
//  Created by Charles on 9/30/15.
//  Copyright © 2015 Charles. All rights reserved.
//
//  CarHUD was taken- resorting to ClearDisplay.
//

import UIKit
import Foundation
import CoreLocation
import Crashlytics
import Answers

let manager = CLLocationManager()

var currentColor = UIColor()
var touchCount = false
var forceTouched = false

class ViewController: UIViewController, CLLocationManagerDelegate {
    var didCalibration = false
    
    @IBOutlet weak var degree: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var directionLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var batteryLabel: UILabel!
    @IBOutlet weak var mphLabel: UILabel!
    @IBOutlet weak var batteryLabelLabel: UILabel!
    @IBOutlet weak var rotationLabelLabel: UILabel!
    
    var locationTimer = NSTimer()
    var setTopSpeed: String = ""
    var backgroundProtector = UIView()
    var powerModeTried = false
    
    override func viewDidAppear(animated: Bool) {
        
        let launchedBefore = NSUserDefaults.standardUserDefaults().boolForKey("launchedBefore")
        if launchedBefore  {
            print("Launched before... Continuing.")
        }
        else {
            print("Setup for first launch!")
            
            let vc = self.storyboard!.instantiateViewControllerWithIdentifier("InitialAppLaunch")
            self.presentViewController(vc, animated: false, completion: nil)
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "launchedBefore")
        }
        
        if isInPerformanceMode {
            
            degree.text = "˚"
            rotationLabelLabel.text = "Direction: "
            
            manager.startUpdatingHeading()
            
            var locationTimer = NSTimer.scheduledTimerWithTimeInterval(60, target: self, selector: #selector(ViewController.checkLocation), userInfo: nil, repeats: true)
            
            if Int(Utilities().setArea()) == 0 {
                locationTimer = NSTimer.scheduledTimerWithTimeInterval(60, target: self, selector: #selector(ViewController.checkLocation), userInfo: nil, repeats: true)
            } else if Int(Utilities().setArea()) == 1 {
                locationTimer = NSTimer.scheduledTimerWithTimeInterval(50, target: self, selector: #selector(ViewController.checkLocation), userInfo: nil, repeats: true)
            } else if Int(Utilities().setArea()) == 2 {
                locationTimer = NSTimer.scheduledTimerWithTimeInterval(40, target: self, selector: #selector(ViewController.checkLocation), userInfo: nil, repeats: true)
            } else {
                locationTimer = NSTimer.scheduledTimerWithTimeInterval(20, target: self, selector: #selector(ViewController.checkLocation), userInfo: nil, repeats: true)
            }
            
            locationTimer.fire()
            
        } else {
            
            degree.text = ""
            directionLabel.text = ""
            rotationLabelLabel.text = ""
            locationLabel.text = "Low Power Mode"
            
            Answers.logCustomEventWithName("Power Type",
                                           customAttributes: [
                                            "mode" : "Energy"
                ])
            
            locationTimer.invalidate()
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(powerModeTried)
        
        if NSProcessInfo.processInfo().lowPowerModeEnabled {
            isInPerformanceMode = false
            powerModeTried = true
        }
        
        manager.startUpdatingLocation()
        
        manager.headingOrientation = .LandscapeRight
        
        backgroundProtector = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        
        backgroundProtector.backgroundColor = UIColor(red: 0.41, green: 0.41, blue: 0.41, alpha: 1.0)
        
        self.view.addSubview(backgroundProtector)
        self.view.sendSubviewToBack(backgroundProtector)
        
        locationTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(ViewController.checkLocation), userInfo: nil, repeats: true)
        
        UIApplication.sharedApplication().idleTimerDisabled = true
        UIDevice.currentDevice().batteryMonitoringEnabled = true
    
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        manager.distanceFilter = kCLDistanceFilterNone
        manager.headingFilter = 1.0
        
        let timeTimer = NSTimer.scheduledTimerWithTimeInterval(60, target: self, selector: #selector(ViewController.updateTime), userInfo: nil, repeats: true)
        
        timeTimer.fire()
        
        if isInPerformanceMode {
            
            degree.text = "˚"
            rotationLabelLabel.text = "Direction: "
            
            manager.startUpdatingHeading()
            
            var locationTimer = NSTimer.scheduledTimerWithTimeInterval(60, target: self, selector: #selector(ViewController.checkLocation), userInfo: nil, repeats: true)
            
            if Int(Utilities().setArea()) == 0 {
                locationTimer = NSTimer.scheduledTimerWithTimeInterval(60, target: self, selector: #selector(ViewController.checkLocation), userInfo: nil, repeats: true)
            } else if Int(Utilities().setArea()) == 1 {
                locationTimer = NSTimer.scheduledTimerWithTimeInterval(50, target: self, selector: #selector(ViewController.checkLocation), userInfo: nil, repeats: true)
            } else if Int(Utilities().setArea()) == 2 {
                locationTimer = NSTimer.scheduledTimerWithTimeInterval(40, target: self, selector: #selector(ViewController.checkLocation), userInfo: nil, repeats: true)
            } else {
                locationTimer = NSTimer.scheduledTimerWithTimeInterval(20, target: self, selector: #selector(ViewController.checkLocation), userInfo: nil, repeats: true)
            }
            
            locationTimer.fire()
            
        } else {
            
            degree.text = ""
            directionLabel.text = ""
            rotationLabelLabel.text = ""
            locationLabel.text = "Low Power Mode"
            
            Answers.logCustomEventWithName("Power Type",
                customAttributes: [
                    "mode" : "Energy"
                ])
            
            locationTimer.invalidate()
            
        }
        
        if CLLocationManager.authorizationStatus() == .Denied || CLLocationManager.authorizationStatus() == .Restricted {
            performSegueWithIdentifier("locationIssues", sender: self)
        }
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let x: CGFloat = touchCount ? 1.0 : -1.0
        
        
        
        self.view.transform = CGAffineTransformMakeScale(1, x)
        
        switch touchCount {
            
        case true:
            touchCount = false
            manager.headingOrientation = CLDeviceOrientation.LandscapeLeft
            
        case false:
            touchCount = true
            manager.headingOrientation = CLDeviceOrientation.LandscapeRight
            
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        
        var currentSpeed = 0.0
        batteryLabel.text = "\(Int(batteryLevel() * 100))"
        
        if Int(Utilities().currentSpeedUnit()) == 0 {
            
            currentSpeed = 0.1 * round((newLocation.speed * 3.6) / 0.1)
            mphLabel.text = "KPH"
            
        } else if Int(Utilities().currentSpeedUnit()) == 1 {
            
            currentSpeed = 0.1 * round((newLocation.speed * 2.236) / 0.1)
            mphLabel.text = "MPH"
            
        } else if Int(Utilities().currentSpeedUnit()) == 2 {
            
            currentSpeed = 0.1 * round((newLocation.speed * 1.94384449) / 0.1)
            mphLabel.text = "KN"
            
        } else {
            
            currentSpeed = 0.1 * round((newLocation.speed * 3.6) / 0.1)
            mphLabel.text = "KPH"
        }
        
        if currentSpeed < 0.0 {
            currentSpeed = 0.0
        }
        
        self.speedLabel.text = String(currentSpeed)
        
        setTopSpeed = Utilities().setTopSpeed()
        
        UIView.animateWithDuration(1.5, delay: 0.0, options: UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
                self.backgroundProtector.backgroundColor = UIColor(red: CGFloat(0.66), green: CGFloat(0.20), blue: CGFloat(0.14), alpha: CGFloat(currentSpeed / Double(self.setTopSpeed)! + 0.01))
        }, completion: nil)
        
        currentColor = self.view.backgroundColor!
        
        if isInPerformanceMode == false {
            
            manager.stopUpdatingHeading()
            
        }
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        
        if isInPerformanceMode {
        
            let currentHeadingDegrees = newHeading.magneticHeading
            
            if(currentHeadingDegrees > 23 && currentHeadingDegrees <= 67) {
                
                directionLabel.text = "NE"
                
            } else if (currentHeadingDegrees > 68 && currentHeadingDegrees <= 112) {
                
                directionLabel.text = "E"
                
            } else if (currentHeadingDegrees > 113 && currentHeadingDegrees <= 167) {
                
                directionLabel.text = "SE"
                
            } else if (currentHeadingDegrees > 168 && currentHeadingDegrees <= 202) {
                
                directionLabel.text = "S"
                
            } else if (currentHeadingDegrees > 203 && currentHeadingDegrees <= 247) {
                
                directionLabel.text = "SW"
                
            } else if (currentHeadingDegrees > 248 && currentHeadingDegrees <= 293) {
                
                directionLabel.text = "W"
                
            } else if (currentHeadingDegrees > 294 && currentHeadingDegrees <= 337) {
                
                directionLabel.text = "NW"
                
            } else if (currentHeadingDegrees >= 338 || currentHeadingDegrees <= 22) {
                
                directionLabel.text = "N"
                
            }
            
            self.degree.text = String(Int16(round(newHeading.magneticHeading)))
            self.degree.text! += "\u{02DA}"
            
        } else {
            return
        }
        
        if CLLocationManager.authorizationStatus() == .Denied || CLLocationManager.authorizationStatus() == .Restricted {
            performSegueWithIdentifier("locationIssues", sender: self)
        }
        
    }
    
    func checkLocation() {
        
        if isInPerformanceMode {
        
            if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            
                if let location = manager.location where location.horizontalAccuracy >= 0 {
                    CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
                        guard error == nil else {
                            return
                        }
                        
                        if let placemark = placemarks?.first {
                            
                            if Int(Utilities().setArea()) == 0 {
                                self.locationLabel.text = placemark.administrativeArea
                            } else if Int(Utilities().setArea()) == 1 {
                                self.locationLabel.text = placemark.subAdministrativeArea
                            } else if Int(Utilities().setArea()) == 2 {
                                if placemark.subLocality == "" {
                                    self.locationLabel.text = "Not Avalible."
                                } else {
                                    self.locationLabel.text = placemark.subLocality
                                }
                            } else {
                                self.locationLabel.text = placemark.thoroughfare
                            }
                            
                            self.locationLabel.font = UIFont(name: self.locationLabel.font!.fontName, size: 52)
                            
                            if self.locationLabel.text?.characters.count > 17 {
                                
                                self.locationLabel.font = UIFont(name: self.locationLabel.font!.fontName, size: self.locationLabel.font!.pointSize / 1.5)
                                
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
            }
            
        } else {
            print("Not performing CLGeolocation updates.")
        }
        
    }
    
    func updateTime() {
        
        let date = NSDate()
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        dateFormatter.timeZone = NSTimeZone()
        
        let localDate = dateFormatter.stringFromDate(date)
        self.timeLabel.text = "\(localDate)"
        
    }

    func locationManagerShouldDisplayHeadingCalibration(manager: CLLocationManager) -> Bool {
        if didCalibration == false {
            Answers.logCustomEventWithName("Calibration attempt",
                customAttributes: [
                    "Calibrated" : "Yes"
                ])
            didCalibration = true
            return true
        } else {
            Answers.logCustomEventWithName("Calibration attempt",
                customAttributes: [
                    "Calibrated" : "No"
                ])
            return false
        }
        
    }
    
    func batteryLevel() -> Float {
        return UIDevice.currentDevice().batteryLevel
    }
    
}
