//
//  ANF_Code_TestTests.swift
//  ANF Code TestTests
//


import XCTest
@testable import ANF_Code_Test

class ANFExploreCardTableViewControllerTests: XCTestCase {

    var testInstance: ANFExploreCardTableViewController!
    
    override func setUp() {
        let details = AFDetailModel(title: "TOPS STARTING AT $12", backgroundImage: "anf-20160527-app-m-shirts.jpg", content: [ContentDetailModel(target: "https://www.abercrombie.com/shop/us/mens-new-arrivals", title: "Shop Men")], promoMessage: "USE CODE: 12345", topDescription: "A&F", bottomDescription: "*In stores & online. <a href=\\\"http://www.abercrombie.com/anf/media/legalText/viewDetailsText20160602_Tier_Promo_US.html\\\">Exclusions apply. See Details</a>")
        testInstance = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ANFExploreCardTableViewController") as? ANFExploreCardTableViewController
        testInstance.exploreDataList.append(details)
    }
    
    func testViewDidLoad() {
        XCTAssertNoThrow(testInstance.view)
    }

    func test_numberOfSections_ShouldBeOne() {
        let numberOfSections = testInstance.numberOfSections(in: testInstance.tableView)
        XCTAssert(numberOfSections == 1, "table view should have 1 section")
    }
    
    func test_numberOfRows_ShouldBeTen() {
        let numberOfRows = testInstance.tableView(testInstance.tableView, numberOfRowsInSection: 0)
        XCTAssert(numberOfRows == 1, "table view should have 10 cells")
    }
    
    func test_cellForRowAtIndexPath_titleText_shouldNotBeBlank() {
        let firstCell = testInstance.tableView(testInstance.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        let title = firstCell.viewWithTag(1) as? UILabel
        XCTAssert(title?.text?.count ?? 0 > 0, "title should not be blank")
    }
}
