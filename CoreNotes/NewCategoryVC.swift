//
//  NewCategoryVC.swift
//  CoreNotes
//
//  Created by Jo Albright on 11/16/15.
//  Copyright © 2015 Jo Albright. All rights reserved.
//

import UIKit
import CoreData

class NewCategoryVC: UIViewController {

    @IBOutlet weak var categoryNameField: UITextField!

    @IBOutlet weak var categoryDatePicker: UIDatePicker!
    
    @IBAction func cancel(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func create(sender: AnyObject) {
        
        guard let appD = UIApplication.sharedApplication().delegate as? AppDelegate else { return }
        
        // entity description
        let newCategory = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: appD.managedObjectContext)
        
        newCategory.setValue(categoryNameField.text, forKey: "name")
        
        // run saveContext()
        appD.saveContext()
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
}
