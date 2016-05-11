//
//  MapViewController.swift
//  ClearVision
//
//  Created by Charles Truluck on 4/20/16.
//  Copyright © 2016 Charles. All rights reserved.
//

import UIKit
import Mapbox

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var speedLabelMap: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var anyTouch: UIButton!
    let mapView = MGLMapView()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        anyTouch.userInteractionEnabled = false
        
        mapView.frame = UIScreen.mainScreen().bounds
        mapView.styleURL = NSURL(string: "mapbox://styles/chalets/cin9n0v05008oagm8s6rd1kbz")
        mapView.userTrackingMode = .FollowWithHeading
        mapView.setZoomLevel(18, animated: true)
        
        mapView.allowsTilting = false
        mapView.allowsZooming = false
        mapView.allowsRotating = false
        mapView.allowsScrolling = false
        
        mapView.subviews[2].alpha = 0

        self.view.addSubview(mapView)
        
        self.view.bringSubviewToFront(anyTouch)
        self.view.bringSubviewToFront(backButton)
        self.view.bringSubviewToFront(speedLabelMap)
        
        if touchCount {
            
            self.view.transform = CGAffineTransformMakeScale(1, -1)
            
        }
        
        anyTouch.userInteractionEnabled = true
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        manager.distanceFilter = kCLDistanceFilterNone
        manager.headingFilter = 1.0
        manager.startUpdatingLocation()
        
        speedLabelMap.textColor = UIColor.whiteColor()
        speedLabelMap.layer.borderColor = UIColor.whiteColor().CGColor
        speedLabelMap.layer.cornerRadius = (speedLabelMap.frame.size.height / 2)
        speedLabelMap.layer.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.3).CGColor
        
    }
    
    var runThing = false
    
    @IBAction func anyTouched(sender: AnyObject) {

        switch touchCount {

        case true:
            touchCount = false
            self.view.transform = CGAffineTransformMakeScale(1, -1)
            mapView.userTrackingMode = .FollowWithCourse

        case false:
            touchCount = true
            self.view.transform = CGAffineTransformMakeScale(1, 1)
            mapView.userTrackingMode = .FollowWithHeading
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        
        var currentSpeed = 0.0
        
        if Int(Utilities().currentSpeedUnit()) == 0 {
            
            currentSpeed = 0.1 * round((newLocation.speed * 3.6) / 0.1)
            
        } else if Int(Utilities().currentSpeedUnit()) == 1 {
            
            currentSpeed = 0.1 * round((newLocation.speed * 2.236) / 0.1)
            
        } else if Int(Utilities().currentSpeedUnit()) == 2 {
            
            currentSpeed = 0.1 * round((newLocation.speed * 1.94384449) / 0.1)
            
        } else {
            
            currentSpeed = 0.1 * round((newLocation.speed * 3.6) / 0.1)
        }
        
        speedLabelMap.text = String(currentSpeed)
    }
    
    @IBAction func backAction(sender: AnyObject) {
        
        self.view.backgroundColor = UIColor(red: 0.41, green: 0.41, blue: 0.41, alpha: 1.0)
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
}
