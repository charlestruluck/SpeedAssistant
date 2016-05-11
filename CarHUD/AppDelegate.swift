//
//  AppDelegate.swift
//  CarHUD
//
//  Created by Charles on 9/30/15.
//  Copyright © 2015 Charles. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics
import Answers

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions: [NSObject: AnyObject]?) -> Bool {
        
        Fabric.with([Crashlytics.self()])
        
        return true
    }
    
    func application(application: UIApplication, performActionForShortcutItem shortcutItem: UIApplicationShortcutItem, completionHandler: Bool -> Void) {
        let handledShortCutItem = handleShortCutItem(shortcutItem)
        
        completionHandler(handledShortCutItem)
    }

    func applicationWillResignActive(application: UIApplication) {
        
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        
    }

    func applicationDidBecomeActive(application: UIApplication) {
        
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func handleShortCutItem(shortcutItem: UIApplicationShortcutItem) -> Bool {
        var handled = false
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var vc = UIViewController()
        
        vc = storyboard.instantiateViewControllerWithIdentifier("MapViewController") as! MapViewController
        
        handled = true
        
        window!.rootViewController?.presentViewController(vc, animated: false, completion: nil)
        
        return handled
    }


}

