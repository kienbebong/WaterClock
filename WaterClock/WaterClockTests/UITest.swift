import Foundation
import XCTest
@testable import WaterClock

final class UITest: XCTestCase {
    var signInView: SignInHomeView!
    var headerView: HeaderView!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        signInView = SignInHomeView()
        headerView = HeaderView()
        signInView.updateViewVisibility()
        headerView.updateViewVisibility()
    }
    
    override func tearDownWithError() throws {
        signInView = nil
        headerView = nil
        try super.tearDownWithError()
    }
    
    func testViewHiddenAfterSignedInSuccess() throws {
        UserDefaults.standard.set(true, forKey: "isUserSignedIn")
        
        signInView.updateViewVisibility()
        headerView.updateViewVisibility()
        
        XCTAssertTrue(signInView.isHidden, "sign in view not hideen")
        XCTAssertTrue(headerView.isHidden, "headr view not hideen")
    }
    
    
}
