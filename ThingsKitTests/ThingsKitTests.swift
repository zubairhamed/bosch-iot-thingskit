//
//  ThingsKitTests.swift
//  ThingsKitTests
//
//  Created by Zubair Hamed on 13/4/16.
//  Copyright © 2016 Zubair Hamed. All rights reserved.
//

import XCTest
import Alamofire
@testable import ThingsKit

class ThingsKitTests: XCTestCase {
    var tk: ThingsKit = ThingsKit(user: "xx", password: "xx", token: "xx")

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
        
    func testThingsServices() {
        var exp: XCTestExpectation = XCTestExpectation()
        
        var things = [Thing]()
        var thingsIds = [String]()
        let tc = 5
        
        // Create things
        for _ in 0..<tc {
            exp = expectationWithDescription("ThingsCreate")
            tk.createThing(Thing(), completion: {
                (createdThing, result) in
                
                XCTAssertNotNil(createdThing)
                things.append(createdThing)
                thingsIds.append(createdThing.thingId!)
                exp.fulfill()
            })
            waitForExpectationsWithTimeout(Double(tc) * 5.0, handler: nil)
        }
        XCTAssertEqual(things.count, tc)
        
        // List things
        exp = expectationWithDescription("ThingsList")
        
        tk.listThings(thingsIds) {
            (things, result) in
            
            XCTAssertEqual(things.count, tc)
            exp.fulfill()
        }
        waitForExpectationsWithTimeout(5.0, handler: nil)
        
        // Get Thing
        for i in 0..<tc {
            let id = thingsIds[i]
            exp = expectationWithDescription("ThingsCreate")
            tk.getThing(id, completion: {
                (thing, result) in
                
                XCTAssertEqual(thing.thingId, id)
                exp.fulfill()
            })
            waitForExpectationsWithTimeout(Double(tc) * 5.0, handler: nil)
        }
        
        // Update Thing
        for i in 0..<tc {
            let id = thingsIds[i]
            exp = expectationWithDescription("ThingsUpdate")
            let t = things[i]
            t.attributes!["updated"] = true
            self.tk.updateThing(id, thing: t, completion: {
                (thing, result) in
                
                XCTAssertTrue(result.isSuccess())
                
                self.tk.getThing(id, completion: {
                    (thing, result) in
                    
                    XCTAssertEqual(thing.attributes!["updated"] as? Bool, true)
                    exp.fulfill()
                })
            })
            waitForExpectationsWithTimeout(Double(tc) * 5.0, handler: nil)
        }
        
        // Delete Thing
        for i in 0..<tc {
            let id = thingsIds[i]
            exp = expectationWithDescription("ThingsDelete")
            tk.deleteThing(id, completion: {
                (result) in
                
                XCTAssertTrue(result.isSuccess())
                exp.fulfill()
            })
            waitForExpectationsWithTimeout(Double(tc) * 5.0, handler: nil)
        }
        
        // List again, assert 0 size
        exp = expectationWithDescription("ThingsListAfterDelete")
        
        tk.listThings(thingsIds) {
            (things, result) in
            
            XCTAssertEqual(things.count, 0)
            exp.fulfill()
        }
        waitForExpectationsWithTimeout(5.0, handler: nil)
    }
    
//    func testThingsAcl() {}
//    func testThingsAttributes() {}
//    func testFeatures() {}
//    func testRelations() {}
//    func testSearch() {}
//    func testMessages() {}
//    func testSubscriptions() {}
//    func testSolutions() {}
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
