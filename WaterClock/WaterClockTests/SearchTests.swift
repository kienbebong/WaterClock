import XCTest
@testable import WaterClock

final class SearchTests: XCTestCase {
    var vc: SearchViewController!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        vc = SearchViewController()
        vc.loadViewIfNeeded()
    }
    
    override func tearDownWithError() throws {
        vc = nil
        try super.tearDownWithError()
    }
    
    func testInitialFilterDataIsFulledData() throws {
        XCTAssertEqual(vc.filteredData.count, vc.data.count, "Filterd data is not equal to fulled data")
    }
    
    func testFilterFuncional() throws {
        let textSearch = "nước"
        vc.didUpdateSearchText(textSearch)
        
        let fileterKeys = vc.data.keys.filter {
            $0.lowercased().contains(textSearch.lowercased())
        }
        
        XCTAssertEqual(vc.filteredData.count, fileterKeys.count, "Filterd data is not equal to filtered keys")
    }
    
    func testTableViewNumberOfRowsMatchesFilteredData() throws {
        vc.didUpdateSearchText("nước")
        XCTAssertEqual(vc.tableView.numberOfRows(inSection: 0), vc.filteredData.count, "Table view number of rows is not equal to filtered data")
    }
}
