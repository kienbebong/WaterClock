import XCTest
import CoreData
import Foundation
@testable import WaterClock

final class AccountCoreDataTests: XCTestCase {
    var dataPersistenceManager: DataPersistenceManager!
    var mockPersistanceContainer: NSPersistentContainer!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        mockPersistanceContainer = {
            let container = NSPersistentContainer(name: "WaterClock")
            let description = NSPersistentStoreDescription()
            description.type = NSInMemoryStoreType
            container.persistentStoreDescriptions = [description]
            container.loadPersistentStores { _, error in
                fatalError()
            }
            return container
        }()
        
        dataPersistenceManager  = DataPersistenceManager()
    }
    
    override func tearDownWithError() throws {
        dataPersistenceManager = nil
        mockPersistanceContainer = nil
        try super.tearDownWithError()
    }
    
    func testDownload() throws {
        let expectation =  XCTestExpectation(description: "Account should be saved successfullly")
        
        let mockAccount = Account(
            CODE: "123",
            MESSAGE: "456",
            USER_ID: "2024-12-01",
            USER_ACCOUNT: "Test message",
            USER_NAME: "Admin",
            USER_ADDRESS: "token123",
            USER_TEL: "2024-12-31",
            USER_EMAIL: "test_account",
            USER_TYPE: "123 Test Street",
            LASTACTIVE_TIME: "test@example.com",
            TOKEN: "Test User",
            TOKEN_EXPIRED: "1234567890",
            ROLE_NAME: "Test Type"
        )
        
        dataPersistenceManager.downloadAccount(accountLogin: mockAccount) { result in
            switch result {
            case .success():
                self.dataPersistenceManager.fetchAccount { fetchResult in
                    switch fetchResult {
                    case .success(let fetchedAccount):
                        XCTAssertEqual(fetchedAccount.userId, mockAccount.USER_ID)
                        XCTAssertEqual(fetchedAccount.userAccount, mockAccount.USER_ACCOUNT)
                        XCTAssertEqual(fetchedAccount.userName, mockAccount.USER_NAME)
                        XCTAssertEqual(fetchedAccount.userAddress, mockAccount.USER_ADDRESS)
                        XCTAssertEqual(fetchedAccount.userTel, mockAccount.USER_TEL)
                        XCTAssertEqual(fetchedAccount.userEmail, mockAccount.USER_EMAIL)
                        XCTAssertEqual(fetchedAccount.userType, mockAccount.USER_TYPE)
                        XCTAssertEqual(fetchedAccount.lastActiveTime, mockAccount.LASTACTIVE_TIME)
                        XCTAssertEqual(fetchedAccount.token, mockAccount.TOKEN)
                        XCTAssertEqual(fetchedAccount.tokenExpired, mockAccount.TOKEN_EXPIRED)
                        XCTAssertEqual(fetchedAccount.roleName, mockAccount.ROLE_NAME)
                        expectation.fulfill()
                    case .failure(let error):
                        XCTFail("Failed: \(error)")
                    }
                }
            case .failure(let error):
                XCTFail("Fail: \(error)")
            }
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testDeleteAccount() throws {
        let expectation = XCTestExpectation(description: "Account should be deleted successfully")
        
        let mockAccount = Account(
            CODE: "123",
            MESSAGE: "456",
            USER_ID: "2024-12-01",
            USER_ACCOUNT: "Test message",
            USER_NAME: "Admin",
            USER_ADDRESS: "token123",
            USER_TEL: "2024-12-31",
            USER_EMAIL: "test_account",
            USER_TYPE: "123 Test Street",
            LASTACTIVE_TIME: "test@example.com",
            TOKEN: "Test User",
            TOKEN_EXPIRED: "1234567890",
            ROLE_NAME: "Test Type"
        )
        
        dataPersistenceManager.downloadAccount(accountLogin: mockAccount) { result in
            switch result {
                case .success:
                self.dataPersistenceManager.fetchAccount { fetchResult in
                    switch fetchResult {
                    case .success(let account):
                        self.dataPersistenceManager.deleteAccount(accountLogin: account) { deletResult in
                            switch deletResult {
                            case .success:
                                self.dataPersistenceManager.fetchAccount { postDeleteResult in
                                    switch postDeleteResult {
                                    case .success:
                                        XCTFail("Still exist")
                                    case .failure:
                                        expectation.fulfill()
                                    }
                                }
                            case .failure(let error):
                                XCTFail("\(error)")
                            }
                        }
                    case .failure(let error):
                        XCTFail("\(error)")
                    }
                }
            case .failure(let error):
                XCTFail("\(error)")
            }
        }
    }
}
