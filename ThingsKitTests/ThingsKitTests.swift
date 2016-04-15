//
//  ThingsKitTests.swift
//  ThingsKitTests
//
//  Created by Zubair Hamed on 13/4/16.
//  Copyright © 2016 Zubair Hamed. All rights reserved.
//

import XCTest
@testable import ThingsKit

class ThingsKitTests: XCTestCase {
    var tk: ThingsKit = ThingsKit(user: "xxx", password: "xxx", token: "xxx", endpoint: "https://things.apps.bosch-iot-cloud.com/cr/1")
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testThings() {
        let expect = expectationWithDescription("things")
        
        self.tk.listThings([":b583fcbb-e520-42e1-837b-803d00188ae1"]) {
            (things: [Thing]) in
            expect.fulfill()
        }
        sleep(5)
        
        self.tk.getThing(":b583fcbb-e520-42e1-837b-803d00188ae1") { (thing) in
            print(thing)
        }
        sleep(5)
        
        self.waitForExpectationsWithTimeout(30) { error in
            XCTAssertNil(error, "Something went horribly wrong")
        }
        
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
