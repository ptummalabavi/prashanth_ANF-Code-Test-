//
//  AppUtilityTests.swift
//  ANF Code TestTests
//
//  Created by Prashanth reddy on 7/11/21.
//

import XCTest
@testable import ANF_Code_Test

class AppUtilityTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSingleton() {
        let appUtility = AppUtility.shared
        XCTAssertNotNil(appUtility)
    }
}
