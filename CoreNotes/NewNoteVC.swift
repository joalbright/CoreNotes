//
//  NewNoteVC.swift
//  CoreNotes
//
//  Created by Jo Albright on 11/16/15.
//  Copyright © 2015 Jo Albright. All rights reserved.
//

import UIKit
import CoreData

class NewNoteVC: UIViewController {

    @IBOutlet weak var noteTextView: UITextView!
    
    @IBOutlet weak var categoryPicker: UIPickerView!
    
    @IBAction func cancel(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func create(sender: AnyObject) {
        
        createNote()
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        categoryPicker.dataSource = self
        fetchCategories()
        
    }
    
    var categories: [Category] = []

}

extension NewNoteVC: UIPickerViewDataSource {
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return categories.count
        
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        
        return 1
        
    }
    
}




