
import XCTest
@testable import ANF_Code_Test

class AFDetailsViewControllerTests: XCTestCase {

    var viewController: AFDetailViewController!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let details = AFDetailModel(title: "TOPS STARTING AT $12", backgroundImage: "anf-20160527-app-m-shirts.jpg", content: [ContentDetailModel(target: "https://www.abercrombie.com/shop/us/mens-new-arrivals", title: "Shop Men")], promoMessage: "USE CODE: 12345", topDescription: "A&F", bottomDescription: "*In stores & online. <a href=\\\"http://www.abercrombie.com/anf/media/legalText/viewDetailsText20160602_Tier_Promo_US.html\\\">Exclusions apply. See Details</a>")
        viewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "AFDetailViewController") as? AFDetailViewController
        viewController.afDetail = details
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testViewDidLoad() {
        XCTAssertNoThrow(viewController.view)
    }
    
    func testNumberOfRowsInSection() {
        let tableView = UITableView()
        viewController.tblContentList = tableView
        let numberOfRows = viewController.tableView(viewController.tblContentList, numberOfRowsInSection: 0)
        XCTAssert(numberOfRows == viewController.afDetail.content?.count, "table view should have 10 cells")
    }
    
    func testCellForRowAtIndexPath() {
        let tableView = UITableView()
        viewController.tblContentList = tableView
        viewController.tblContentList.register(UINib.init(nibName: "ContentTableViewCell", bundle: nil), forCellReuseIdentifier: "ContentTableViewCell")
        let cellInstance = viewController.tableView(viewController.tblContentList, cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertNoThrow(cellInstance)
    }
    
    func testConfigureRow() {
        let tableView = UITableView()
        viewController.tblContentList = tableView
        viewController.tblContentList.register(UINib.init(nibName: "ContentTableViewCell", bundle: nil), forCellReuseIdentifier: "ContentTableViewCell")
        guard let cellInstance = viewController.tableView(viewController.tblContentList, cellForRowAt: IndexPath(row: 0, section: 0)) as? ContentTableViewCell, let objModel = viewController.afDetail.content?[0]  else {
            return
        }
        XCTAssertNoThrow(cellInstance.confireCell(objModel))
    }
}


/*
 
 "title": "TOPS STARTING AT $12",
 "backgroundImage": "anf-20160527-app-m-shirts.jpg",
 "content": [
   {
     "target": "https://www.abercrombie.com/shop/us/mens-new-arrivals",
     "title": "Shop Men"
   },
   {
     "target": "https://www.abercrombie.com/shop/us/womens-new-arrivals",
     "title": "Shop Women"
   }
 ],
 "promoMessage": "USE CODE: 12345",
 "topDescription": "A&F ESSENTIALS",
 "bottomDescription": "*In stores & online. <a href=\\\"http://www.abercrombie.com/anf/media/legalText/viewDetailsText20160602_Tier_Promo_US.html\\\">Exclusions apply. See Details</a>"
 
 */
