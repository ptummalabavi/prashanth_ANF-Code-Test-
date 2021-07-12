
import XCTest
@testable import ANF_Code_Test

class AFDetailsViewModelTests: XCTestCase {
    let viewModel = AFDetailsViewModel()
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testAPIService() {
        let promise = expectation(description: "API service integration.")
        viewModel.getAFDetails { (model) in
            promise.fulfill()
            if let notNilModels = model {
                XCTAssertTrue(notNilModels.count > 0)
            } else {
                XCTFail("API service failed.")
            }
        }
        wait(for: [promise], timeout: 5.0)
    }

}
