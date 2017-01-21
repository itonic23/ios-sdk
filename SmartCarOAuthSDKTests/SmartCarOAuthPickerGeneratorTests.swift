//
//  SmartCarOAuthPickerGeneratorTests.swift
//  SmartCarOAuthSDK
//
//  Created by Jeremy Zhang on 1/14/17.
//  Copyright © 2017 SmartCar Inc. All rights reserved.
//

import XCTest
@testable import SmartCarOAuthSDK

class SmartCarOAuthPickerGeneratorTests: XCTestCase {
    
    var viewController = UIViewController()
    let defaultOEM = [OEMName.acura, OEMName.audi, OEMName.bmw, OEMName.bmwConnected]
    let smartCarRequest = SmartCarOAuthRequest(clientID: "4a1b01e5-0497-417c-a30e-6df6ba33ba46", redirectURI: "smartcar://oidc.com", scope: ["read_vehicle_info", "read_odometer"], state: "ABC-123-DEFG")
    var sdk: SmartCarOAuthSDK?
    var gen: SmartCarOAuthPickerGenerator?
    
    override func setUp() {
        super.setUp()
        sdk = SmartCarOAuthSDK(request: smartCarRequest)
        gen = SmartCarOAuthPickerGenerator(sdk: sdk!, viewController: viewController, oemList: defaultOEM)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPickerButtonGeneration() {
        let button = gen!.generatePicker(frame: CGRect(x: 0, y: 0, width: 250, height: 50), with: .red)
        
        XCTAssertNotNil(button)
        XCTAssertNotEqual(button.titleLabel?.text, "CONNECT A VEHICLE")
        XCTAssertNotEqual(button.allTargets.count, 0)
        XCTAssertEqual(button.backgroundColor, .red)
        XCTAssertEqual(gen!.oemList.count, 4)
    }
    
    func testHidePickerButtonPress() {
        let button = gen!.generatePicker(frame: CGRect(x: 0, y: 0, width: 250, height: 50), with: .red)
        viewController.view.addSubview(button)
        
        gen!.pickerButtonPressed()
        gen!.hidePickerView()
        
        XCTAssertTrue(gen!.picker.isHidden)
        XCTAssertTrue(gen!.invisButton.isHidden)
        XCTAssertTrue(gen!.toolBar.isHidden)
    }
}
