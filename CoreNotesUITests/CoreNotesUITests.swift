//
//  CoreNotesUITests.swift
//  CoreNotesUITests
//
//  Created by Jo Albright on 11/16/15.
//  Copyright © 2015 Jo Albright. All rights reserved.
//

import XCTest
import CoreData
@testable import CoreNotes

class CoreNotesUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCreateCategory() {
        
        let app = XCUIApplication()
        
        let categoryNames: [String] = []
        
        for name in categoryNames {
            
            app.navigationBars["CoreNotes.NotesTVC"].buttons["Organize"].tap()
            
            let textField = app.childrenMatchingType(.Window).elementBoundByIndex(0).childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.TextField).element
            
            textField.tap()
            textField.typeText(name)
            
            app.buttons["Return"].tap()
            
            app.buttons["Create"].tap()
            
        }
        
        
    }
    
    func testCreateNote() {
        
        let app = XCUIApplication()
        
//        var categoryCount = 7
        
//        let request = NSFetchRequest(entityName: "Category")
//        
//        guard let _appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate else { return }
//        
//        categoryCount = (try? _appDelegate.managedObjectContext.executeFetchRequest(request))?.count ?? 0
        
        for _ in 0...5 {
            
            app.navigationBars["CoreNotes.NotesTVC"].buttons["Add"].tap()
            
//            let random = arc4random_uniform(UInt32(categoryCount)) + 1
            
//            app.pickerWheels["1 of 7"].tap()
//            app.pickerWheels["\(random) of \(categoryCount)"].tap()
            
            app.buttons["Create"].tap()
            
        }
        
    }
    
    func testDeleteAllRows() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let tablesQuery = XCUIApplication().tables
        
        let cellCount = tablesQuery.childrenMatchingType(.Cell).count
        
        for _ in 0..<cellCount {
            
            tablesQuery.childrenMatchingType(.Cell).elementBoundByIndex(0).staticTexts["Note"].swipeLeft()
            
            tablesQuery.buttons["Delete"].tap()
            
        }
        
    }
    
}
