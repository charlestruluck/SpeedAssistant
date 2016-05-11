//
//  LocationService.swift
//  CarHUD
//
//  Created by Charles on 10/4/15.
//  Copyright © 2015 Charles. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import Crashlytics
import Fabric
import Answers

class LocationService: UIViewController {
    
    var checkIfAllowed = NSTimer()
    
    override func viewDidAppear(animated: Bool) {
        
        Answers.logCustomEventWithName("Location Services",
            customAttributes: [
                "Authentication" : "Denied"
            ])
        
        checkIfAllowed = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: #selector(LocationService.unwindSegue), userInfo: nil, repeats: true)
        checkIfAllowed.fire()
    }
    
    override func viewDidDisappear(animated: Bool) {
        checkIfAllowed.invalidate()
    }
    
    @IBAction func enableLocation(sender: AnyObject) {
        
        UIApplication.sharedApplication().openURL(NSURL(string: UIApplicationOpenSettingsURLString)!)
        
    }
    
    func unwindSegue() {
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            checkIfAllowed.invalidate()
            Answers.logCustomEventWithName("Location Services",
                customAttributes: [
                    "Authentication" : "Allowed"
                ])
            dismissViewControllerAnimated(false, completion: nil)
        }
        
    }
    
}