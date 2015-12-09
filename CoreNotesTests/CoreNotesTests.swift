//
//  CoreNotesTests.swift
//  CoreNotesTests
//
//  Created by Jo Albright on 11/16/15.
//  Copyright © 2015 Jo Albright. All rights reserved.
//

import XCTest
import CoreData
@testable import CoreNotes

class CoreNotesTests: XCTestCase, Fetchable {
    
    var button: UIButton?
    
    var categoriesCount = 0
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.

        button = UIButton(frame: CGRectZero)
        
        fetchEntity("Category", predicates: nil) { (found) -> () in
            
            self.categoriesCount = found.count
            
        }
    
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        // we are going to remove all categories
        
        guard let _appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate else { return }
        
        fetchEntity("Category", predicates: nil) { (found) -> () in
            
            let categories = found as? [NSManagedObject] ?? []
            
            for category in categories {
                
                _appDelegate.managedObjectContext.deleteObject(category)
                
            }
            
        }
        
        super.tearDown()
    }
    
    func testButtonDidSetTitle() {
        
        button?.setTitle("Push Me", forState: .Normal)
        
        XCTAssertTrue(!(button?.titleLabel?.text ?? "").isEmpty, "The button title text is empty.")
        
    }
    
    func testButtonDidNotSetTitle() {
        
        XCTAssertTrue((button?.titleLabel?.text ?? "").isEmpty, "The button title text is not empty.")
        
    }
    
    func testCreateNewCategory() {
        
        let newCategory = Category.category()
        newCategory?.name = "Robots"
        
        // run test to make sure the category has a value for "name"
        XCTAssertEqual(newCategory?.valueForKey("name") as? String ?? "", "Robots", "Category name was set incorrectly or not set at all.")
        
        XCTAssertEqual(newCategory?.name ?? "", "Robots", "Not able to get value for key \"name\" using the name property or was not set previously.")
        
        newCategory?.color = UIColor.softRed()
        
        // run test to make sure the category has a value for "color"
        
        guard let _appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate else { return }
        
        _appDelegate.saveContext()
        
        // run test to make sure you can fetch a category named "Robots"
        
        fetchEntity("Category", predicates: nil) { (found) -> () in
            
            let categories = found as? [NSManagedObject] ?? []
            
            let categoryNames = categories.map({ (c) -> String in
                
                return c.valueForKey("name") as? String ?? ""
                
            })
            
            XCTAssertTrue(categoryNames.contains("Robots"), "Unable to fetch the category named \"Robots\" or was never saved properly.")
            
            XCTAssertEqual(self.categoriesCount + 1, found.count, "Category count is not incrementing correctly.")
            
        }
        
    }
    
}
