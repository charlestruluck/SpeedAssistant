//
//  InitialLaunchController.swift
//  ClearVision
//
//  Created by Charles Truluck on 4/24/16.
//  Copyright © 2016 Charles. All rights reserved.
//

import UIKit
import CoreLocation

class InitialLaunchController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var gotItButton: UIButton!
    @IBOutlet weak var setupLabel: UILabel!
    @IBOutlet weak var initialLabel: UILabel!
    @IBOutlet weak var locationServicesDescription: UILabel!
    
    var repeated = 0
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(false)
        
        initialLabel.alpha = 0
        setupLabel.alpha = 0
        locationServicesDescription.alpha = 0
        gotItButton.alpha = 0
        
        initialLabel.frame.origin.y = (self.view.frame.height / 2) + 5
        
        UIView.animateWithDuration(1.3, delay: 1.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.1, options: .AllowUserInteraction, animations: {
            
            self.initialLabel.alpha = 1
            self.initialLabel.frame.origin.y = 10
            
            }, completion: { (true) in
                
                UIView.animateWithDuration(0.5, delay: 0.0, options: .AllowUserInteraction, animations: {
                    
                    self.setupLabel.alpha = 1
                    
                    self.animate(false)
                    
                }, completion: nil )
        })
    }
    
    @IBAction func pressedGotIt(sender: AnyObject) {
        manager.requestWhenInUseAuthorization()
        animate(true)
    }
    
    func animate(reverse: Bool) {
        
        let willReverse = reverse
        
        switch willReverse {
        case true:
            UIView.animateKeyframesWithDuration(1.0, delay: 1.0, options: .AllowUserInteraction, animations: {
                UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 0.5, animations: {
                    self.locationServicesDescription.alpha = 0
                })
                UIView.addKeyframeWithRelativeStartTime(0.6, relativeDuration: 1.0, animations: {
                    self.gotItButton.alpha = 0
                })
                
                self.repeated += 1
                
                }, completion: { (true) in
                    switch self.repeated {
                    case 1:
                        self.locationServicesDescription.text = "This app was designed to be a heads up display (or HUD) for your car. To enable this, tap the screen anywhere on the main screen of the app, then put your phone on your car's dash."
                        self.gotItButton.titleLabel?.text = "Cool"
                    case 2:
                        self.locationServicesDescription.text = "One last thing- please be safe and responsible when using Speed Assistant. We are not responsible for injuries, damage, or anything that happens when driving using Speed Assistant."
                        self.gotItButton.titleLabel?.text = "Ok"
                    default:
                        self.dismissViewControllerAnimated(true, completion: nil)
                    }
                    self.animate(false)
                })
        
        default:
                    
            UIView.animateKeyframesWithDuration(1.0, delay: 1.7, options: .AllowUserInteraction, animations: {
                    UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 0.5, animations: {
                        self.locationServicesDescription.alpha = 1
                    })
                    UIView.addKeyframeWithRelativeStartTime(0.6, relativeDuration: 1.0, animations: {
                        self.gotItButton.alpha = 1
                    })
                
                }, completion: nil)
        }
    }
}
