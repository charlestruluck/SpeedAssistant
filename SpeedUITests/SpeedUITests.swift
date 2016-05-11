//
//  SpeedUITests.swift
//  SpeedUITests
//
//  Created by Charles Truluck on 4/23/16.
//  Copyright © 2016 Charles. All rights reserved.
//

import XCTest

class SpeedUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        XCUIDevice.sharedDevice().orientation = .FaceUp
        XCUIDevice.sharedDevice().orientation = .FaceUp
        XCUIDevice.sharedDevice().orientation = .LandscapeLeft
        XCUIDevice.sharedDevice().orientation = .FaceUp
        XCUIDevice.sharedDevice().orientation = .LandscapeLeft
        XCUIDevice.sharedDevice().orientation = .FaceUp
        XCUIDevice.sharedDevice().orientation = .LandscapeLeft
        XCUIDevice.sharedDevice().orientation = .FaceUp
        XCUIDevice.sharedDevice().orientation = .LandscapeLeft
        
        //let app = app2
        app.staticTexts["0.0"].tap()
        app.otherElements.containingType(.NavigationBar, identifier:"ClearVision.View").childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.tap()
        
        let mapsButton = app.buttons["maps"]
        mapsButton.tap()
        
        let button = app.otherElements.containingType(.NavigationBar, identifier:"ClearVision.MapView").childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Button).elementBoundByIndex(0)
        button.tap()
        button.tap()
        button.tap()
        
        let backButton = app.buttons["back"]
        backButton.tap()
        app.buttons["settings"].tap()
        
        let segmentedControlsQuery2 = app.segmentedControls
        let kilometersButton = segmentedControlsQuery2.buttons["Kilometers"]
        kilometersButton.tap()
        
        let batteryReserveModeButton = segmentedControlsQuery2.buttons["Battery Reserve Mode"]
        batteryReserveModeButton.tap()
        
        let knotsButton = segmentedControlsQuery2.buttons["Knots"]
        knotsButton.tap()
        
        let app2 = app
        app2.sliders["19%"].tap()
        
        let segmentedControlsQuery = app2.segmentedControls
        let milesButton = segmentedControlsQuery.buttons["Miles"]
        milesButton.tap()
        
        let changingTheMaximumSpeedWillChangeTheLevelThatMaximumRedGradientStartsToAppearAtStaticText = app2.staticTexts["Changing the maximum speed will change the level that maximum red gradient starts to appear at."]
        changingTheMaximumSpeedWillChangeTheLevelThatMaximumRedGradientStartsToAppearAtStaticText.tap()
        app2.sliders["33%"].tap()
        
        let window = app.childrenMatchingType(.Window).elementBoundByIndex(0)
        let element = window.childrenMatchingType(.Other).elementBoundByIndex(1).childrenMatchingType(.Other).element
        element.tap()
        kilometersButton.tap()
        
        let slider = app2.sliders["43%"]
        slider.swipeDown()
        slider.tap()
        
        let highPerformanceModeButton = segmentedControlsQuery.buttons["High Performance Mode"]
        highPerformanceModeButton.tap()
        milesButton.tap()
        
        let performanceIsBestForAccuracyWhileBatteryReserveModeDisablesFeaturesLikeCurrentRoadAndHeadingForBetterBatteryLifeStaticText = app2.staticTexts["Performance is best for accuracy, while battery reserve mode disables features like current road and heading for better battery life"]
        performanceIsBestForAccuracyWhileBatteryReserveModeDisablesFeaturesLikeCurrentRoadAndHeadingForBetterBatteryLifeStaticText.tap()
        performanceIsBestForAccuracyWhileBatteryReserveModeDisablesFeaturesLikeCurrentRoadAndHeadingForBetterBatteryLifeStaticText.tap()
        performanceIsBestForAccuracyWhileBatteryReserveModeDisablesFeaturesLikeCurrentRoadAndHeadingForBetterBatteryLifeStaticText.tap()
        element.tap()
        segmentedControlsQuery.buttons["City"].tap()
        element.tap()
        app2.sliders["56%"].tap()
        changingTheMaximumSpeedWillChangeTheLevelThatMaximumRedGradientStartsToAppearAtStaticText.tap()
        highPerformanceModeButton.tap()
        knotsButton.tap()
        performanceIsBestForAccuracyWhileBatteryReserveModeDisablesFeaturesLikeCurrentRoadAndHeadingForBetterBatteryLifeStaticText.tap()
        segmentedControlsQuery.buttons["Sub-Locality"].tap()
        
        let slider2 = app2.sliders["48%"]
        slider2.tap()
        slider2.tap()
        element.tap()
        element.tap()
        batteryReserveModeButton.tap()
        performanceIsBestForAccuracyWhileBatteryReserveModeDisablesFeaturesLikeCurrentRoadAndHeadingForBetterBatteryLifeStaticText.tap()
        milesButton.tap()
        performanceIsBestForAccuracyWhileBatteryReserveModeDisablesFeaturesLikeCurrentRoadAndHeadingForBetterBatteryLifeStaticText.tap()
        element.tap()
        segmentedControlsQuery.buttons["Street"].tap()
        app2.sliders["58%"].tap()
        performanceIsBestForAccuracyWhileBatteryReserveModeDisablesFeaturesLikeCurrentRoadAndHeadingForBetterBatteryLifeStaticText.tap()
        highPerformanceModeButton.tap()
        knotsButton.tap()
        backButton.tap()
        XCUIDevice.sharedDevice().orientation = .FaceUp
        XCUIDevice.sharedDevice().orientation = .LandscapeLeft
        XCUIDevice.sharedDevice().orientation = .FaceUp
        XCUIDevice.sharedDevice().orientation = .LandscapeLeft
        XCUIDevice.sharedDevice().orientation = .Portrait
        
        let element2 = window.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element
        element2.tap()
        XCUIDevice.sharedDevice().orientation = .LandscapeRight
        element2.tap()
        XCUIDevice.sharedDevice().orientation = .FaceUp
        XCUIDevice.sharedDevice().orientation = .LandscapeLeft
        element2.tap()
        XCUIDevice.sharedDevice().orientation = .FaceUp
        XCUIDevice.sharedDevice().orientation = .LandscapeLeft
        mapsButton.tap()
        XCUIDevice.sharedDevice().orientation = .FaceUp
        
        let button2 = element.childrenMatchingType(.Button).elementBoundByIndex(0)
        button2.tap()
        XCUIDevice.sharedDevice().orientation = .LandscapeLeft
        button2.tap()
        XCUIDevice.sharedDevice().orientation = .FaceUp
        XCUIDevice.sharedDevice().orientation = .LandscapeLeft
        button2.tap()
        backButton.tap()
        XCUIDevice.sharedDevice().orientation = .FaceUp
        
    }
    
}
