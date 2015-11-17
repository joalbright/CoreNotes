//
//  NotesTVC.swift
//  CoreNotes
//
//  Created by Jo Albright on 11/16/15.
//  Copyright © 2015 Jo Albright. All rights reserved.
//

import UIKit
import CoreData

class NotesTVC: UITableViewController {

    var categories: [[String:AnyObject]] = []
    
//    [ // array of categories
//    
//        [ // category dictionary
//
//            "category" : NSManagedObject, // category object
//
//            "notes" : [ // notes array
//            
//                NSManagedObject, // note object
//                NSManagedObject // note object
//            
//            ]
//            
//        ]
//    
//    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // make a fetch request to fill tableview with notes where sections = categories
        
        guard let appD = UIApplication.sharedApplication().delegate as? AppDelegate else { return }
        
        let categoryRequest = NSFetchRequest(entityName: "Category")
        
        let foundCategories = (try? appD.managedObjectContext.executeFetchRequest(categoryRequest) as? [NSManagedObject] ?? []) ?? []
        
        for category in foundCategories {
            
            let newCatDictionary = [
            
                "category" : category,
                "notes" : []
            
            ]
            
            categories.append(newCatDictionary)
            
        }
        
        print(categories)
        
        tableView.reloadData()
        
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return categories.count
   
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        let category = categories[section]
        let notes = category["notes"] as? [AnyObject]
        return notes?.count ?? 0
    
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("NoteCell", forIndexPath: indexPath)

        // get current note and set content

        return cell
        
    }

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
            
            // remove note from core data
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
        }
        
    }
    
    // section header layout methods

    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let category = categories[section]
        let managedObject = category["category"] as? NSManagedObject
        let name = managedObject?.valueForKey("name") as? String
        
        let view = UIView(frame: CGRect(x: 20, y: 0, width: 200, height: 40))
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        let label = UILabel(frame: view.frame)
        label.textColor = UIColor.whiteColor()
        label.text = name
        view.addSubview(label)
        
        return view
        
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 40
        
    }
    
}
