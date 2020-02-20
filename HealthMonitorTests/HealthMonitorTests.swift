//
//  HealthMonitorTests.swift
//  HealthMonitorTests
//
//  Created by shelly choudhary on 2/20/20.
//  Copyright © 2020 shelly choudhary. All rights reserved.
//

import XCTest
@testable import HealthMonitor

class HealthMonitorTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testBreakFastItemSucceds() {
        let SandwichItem = BreakFast.init(item: "sandwich",quantity: 1,calories: 350)
        XCTAssertNotNil(SandwichItem)
        let BoiledEggItem = BreakFast.init(item: "Boiled egg",quantity: 1,calories: 10)
        XCTAssertNotNil(BoiledEggItem)
    }
    func testBreakFastItemFails() {
        let noDescriptionItem = BreakFast.init(item: "",quantity: 1,calories: 200)
        XCTAssertNil(noDescriptionItem)
        let negativeCaloriesItem = BreakFast.init(item: "sandwich",quantity: 1,calories: -50)
        XCTAssertNil(negativeCaloriesItem)
    }
    func testTotalCalories() {
        let SandwichItem = BreakFast.init(item: "sandwich",quantity: 1,calories: 350)
        let BoiledEggItem = BreakFast.init(item: "Boiled egg",quantity: 1,calories: 10)
        let TotalCalories = Total.init()
        XCTAssertEqual(0, TotalCalories.items.count)
        TotalCalories.addItem(calories: SandwichItem)
        XCTAssertEqual(1, TotalCalories.items.count)
        TotalCalories.addItem(calories: BoiledEggItem)
        XCTAssertEqual(2, TotalCalories.items.count)
    }
    func testTotalCaloriesReturn(){
        let SandwichItem = BreakFast.init(item: "sandwich",quantity: 1,calories: 350)
        let BoiledEggItem = BreakFast.init(item: "Boiled egg",quantity: 1,calories: 10)
        let TotalCalories = Total.init()
        TotalCalories.addItem(calories: SandwichItem)
        TotalCalories.addItem(calories: BoiledEggItem)
        XCTAssertEqual(360,TotalCalories.returnTotal())
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
