//
//  OWLTestUITests.swift
//  OWLTestUITests
//
//  Created by Rafael Andres Amezquita Mejia on 6/13/19.
//  Copyright © 2019 Rafael Andres Amezquita Mejia. All rights reserved.
//

import XCTest

class OWLTestUITests: XCTestCase {
  
  var app: XCUIApplication!
  
  override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    continueAfterFailure = false
    
    app = XCUIApplication()
    
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    app.launch()
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testExample() {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
  }
  
  func testShowFeed() {
        
    
  }
  
}
