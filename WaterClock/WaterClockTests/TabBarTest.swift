//
//  TabBarTest.swift
//  WaterClockTests
//
//  Created by Dinh Chi Kien on 29/11/24.
//

import XCTest
@testable import WaterClock

class TabBarTest: XCTestCase {
    private var tabBar: TabBarViewController!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        tabBar = TabBarViewController()
        tabBar.loadViewIfNeeded()
    }
    
    override func tearDownWithError() throws {
        tabBar = nil
        try super.tearDownWithError()
    }
    
    func testTabTabBarControllerHasCorrectNumberfTabs() throws {
        let expected = 5
        XCTAssertEqual(tabBar.viewControllers?.count, expected, "Khong du so luong tab")
    }
    
    func testDefaultSelectedTab()  {
        XCTAssertEqual(tabBar.selectedIndex, 2, "HomeController khong duoc dat o vi tri mac dinh")
        
    }
    
    func testSwitchingTabs() throws {
        tabBar.selectedIndex = 0
        XCTAssertEqual(tabBar.selectedIndex, 0, "Khong mo duoc tab 1")
        
        tabBar.selectedIndex = 1
        XCTAssertEqual(tabBar.selectedIndex, 1, "Khong mo duoc tab 2")
        
        tabBar.selectedIndex = 2
        XCTAssertEqual(tabBar.selectedIndex, 2, "Khong mo duoc tab 3")
        
        tabBar.selectedIndex = 3
        XCTAssertEqual(tabBar.selectedIndex, 3, "Khong mo duoc tab 4")
        
        tabBar.selectedIndex = 4
        XCTAssertEqual(tabBar.selectedIndex, 4, "Khong mo duoc tab 5")
        
    }
}
