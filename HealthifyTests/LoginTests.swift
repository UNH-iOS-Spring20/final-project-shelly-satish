//
//  LoginTests.swift
//  HealthifyTests
//


import XCTest
@testable import Healthify

class LoginTests: XCTestCase {
    
    var newUserCreated: String = ""
    var newUserPassword: String = ""
    var isAlreadyConfigured: Bool = false
    
    // MARK: - ▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼ TEST CASES ▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼
    
    // MARK: - ▼▼▼ TEST LOGIN ▼▼▼
    /*
     ▼▼▼ TO TEST : -
     the if user able to login with valid credentials via firebase
     */
    func testIfUserLoggedIn() {
        
        if  !isAlreadyConfigured {
            FirebaseApp.configure()
        }
        
        // valid credentials
        newUserCreated = "thomasEl@mailinator.com"
        newUserPassword = "test1234"
        let expectation = self.expectation(description: "Logging In")
        
        Auth.auth().signIn(withEmail: newUserCreated, password: newUserPassword) { authResult, error in
            XCTAssertNil(error)
            expectation.fulfill()
            //LoaderView.kill()
            //Util.showAlertWithMessage(error!.localizedDescription, title: Key_Alert)
            return
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    
    // MARK: - ▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼ TEST CASES ▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼
    
    // MARK: - ▼▼▼ TEST SIGNUP ▼▼▼
    /*
     ▼▼▼ TO TEST : -
     the if user able to Signup with valid credentials via firebase
     */
    
    func testSignup() {
        
        FirebaseApp.configure()
        isAlreadyConfigured = true
        
        let expectation = self.expectation(description: "Signing Up")
        
        Auth.auth().createUser(withEmail: "thomasEl@mailinator.com", password: "test1234") { authResult, error in
            XCTAssertNil(error)
            expectation.fulfill()
            return
            
        }
        waitForExpectations(timeout: 10) { (error) in
            XCTAssertNil(error)
            self.testIfUserLoggedIn()
        }
        
    }
    
}
