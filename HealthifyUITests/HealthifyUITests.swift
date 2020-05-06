//
//  HealthifyUITests.swift
//  HealthifyUITests
//

import XCTest


class HealthifyUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

  
    
       // MARK: - ▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼ TEST CASES ▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼
              
       // MARK: - ▼▼▼ TEST ON INITIAL LAUNCH ▼▼▼
       /*
        ▼▼▼ TO TEST : -
        the screen which will appear at the inital launch of the application
        1. check the elements like , UserName textfield exists or not.
        2. check the elements like , Passowrd secure textfield exists or not.
        2. check the elements like , Right Arrow button button exists or not.
        */
       func testValidLaunch() {
        
           let elementsQuery = XCUIApplication().scrollViews.otherElements
           XCTAssert(elementsQuery.textFields[NSLocalizedString("UserName", comment: "")].exists)
           XCTAssert(elementsQuery.secureTextFields[NSLocalizedString("Password", comment: "")].exists)
           XCTAssert(elementsQuery.buttons[NSLocalizedString("right arrow", comment: "")].exists)
                      
          }
       
       
       
       // MARK: - ▼▼▼ TEST MISSING CREDENTIALS AT LOGIN ▼▼▼
       /*
        ▼▼▼ TO TEST : -
        the credentials being put at the time of login
        1. check the elements like , input textfield blank or not.
        2. check the elements like , Alert Popup view exists or not.
        */
       
       func testMissingCredentialsLogin() {
           
           let app = XCUIApplication()
           let scrollViewsQuery = app.scrollViews
           let elementsQuery = scrollViewsQuery.otherElements
           let usernameTextField = elementsQuery.textFields["UserName"]
           usernameTextField.tap()
           
           let passwordSecureTextField = elementsQuery.secureTextFields["Password"]
           passwordSecureTextField.tap()
           
           let rightArrowButton = elementsQuery.buttons["right arrow"]
           rightArrowButton.tap()
           
           let okButton = app.alerts["Alert"].scrollViews.otherElements.buttons["Ok"]
           okButton.tap()
           
       }
       
       
       // MARK: - ▼▼▼ TEST INVALID - EMAIL  AT LOGIN ▼▼▼
       /*
        ▼▼▼ TO TEST : -
        the email being put at the time of login
        1. check the elements like , UserName textfield has valid email input or not.
        2. If not then Alertview should popup including specified message
        */
       
       func testInvalidEmailCredentials() {
        
           let app = XCUIApplication()
           
           let invalidUserName = "test012"
           
           let userNametxtfield = app.textFields["UserName"]
           userNametxtfield.tap()
           userNametxtfield.typeText(invalidUserName)
           
           let rightArrowButton = app.buttons["right arrow"]
           rightArrowButton.tap()
           
           let elementsQuery = app.alerts["Alert"].scrollViews.otherElements
           XCTAssertTrue(elementsQuery.staticTexts["Please enter valid userName"].exists)
           
       }
       
       
       
       // MARK: - ▼▼▼ TEST INVALID - PASSWORD  AT LOGIN ▼▼▼
       /*
        ▼▼▼ TO TEST : -
        the email being put at the time of login
        1. check the elements like , Password secureTexfield has valid password input lenght or not.
        2. If not then Alertview should popup including specified message
        */
       func testInvalidPassword() {
           
           let app = XCUIApplication()
    
           let invalidPassword = "test12"
           
           let validUserName = "crew@mailinator.com"
           let userNametxtfield = app.textFields["UserName"]
           userNametxtfield.tap()
           userNametxtfield.typeText(validUserName)


           let passwordtxtfield = app.secureTextFields["Password"]
           passwordtxtfield.tap()
           passwordtxtfield.typeText(invalidPassword)
           
          let rightArrowButton = app.buttons["right arrow"]
           rightArrowButton.tap()
           
           let elementsQuery = app.alerts["Alert"].scrollViews.otherElements
           XCTAssertTrue(elementsQuery.staticTexts["Password should be atleast 8 digit and max 15 digit"].exists)
           
       }
       
    // MARK: - ▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼ **** ▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼


    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
