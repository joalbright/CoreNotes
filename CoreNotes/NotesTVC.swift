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

    var categories: [CategoryDictionary] = []
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        fetchCategoriesAndNotes()
        
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return categories.count
   
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return categories[section].notes.count ?? 0
    
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("NoteCell", forIndexPath: indexPath)

        cell.textLabel?.text = "Note"
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
                
        let view = UIView(frame: CGRect(x: 20, y: 0, width: 200, height: 40))
        view.backgroundColor = categories[section].category.color ?? UIColor(white: 0, alpha: 0.5)
        
        let label = UILabel(frame: view.frame)
        label.textColor = UIColor.whiteColor()
        label.text = categories[section].category.name
        view.addSubview(label)
        
        return view
        
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 40
        
    }
    
}

