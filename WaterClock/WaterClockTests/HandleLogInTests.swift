import Foundation
import XCTest
@testable import WaterClock

final class HandleLogInTests: XCTestCase {
    var signInVC: SignInViewController!
    var settingVC: SettingViewController!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        signInVC = SignInViewController()
        settingVC = SettingViewController()
    }
    
    override func tearDownWithError() throws {
        signInVC = nil
        settingVC = nil
        try super.tearDownWithError()
    }
    
    func testUserDefaultsAfterLoginSuccess() throws {
        UserDefaults.standard.removeObject(forKey: "isUserSignedIn")
        
        signInVC.handleLoginSuccess()
        
        let isUserSignedIn = UserDefaults.standard.bool(forKey: "isUserSignedIn")
        
        XCTAssertTrue(isUserSignedIn, "UserDefaults should set 'isUserSignedIn' to true after login success.")
    }
    
    func testUserDefaultAfterLogOutSuccess() throws {
        UserDefaults.standard.removeObject(forKey: "isUserSignedIn")
        
        signInVC.handleLoginSuccess()
        settingVC.handleSignOut()
        
        let isUserSignOut = UserDefaults.standard.bool(forKey: "isUserSignedIn")
        
        XCTAssertFalse(isUserSignOut, "UserDefaults should set 'isUserSignedIn' to false after logout success.")
    }
}
