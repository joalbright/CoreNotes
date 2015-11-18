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
    
    @IBOutlet weak var categoryPicker: UIPickerView! {
        didSet { categoryPicker.dataSource = self; categoryPicker.delegate = self }
    }
    
    @IBAction func cancel(sender: AnyObject) { dismissViewControllerAnimated(true, completion: nil) }
    
    @IBAction func create(sender: AnyObject) {
        
        createNote()
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        fetchCategories()
        
    }
    
    var categories: [Category] = []

}

extension NewNoteVC: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return categories.count
        
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        
        return 1
        
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        
        let rowView = view ?? UIView(frame: CGRect(x: 0, y: 0, width: pickerView.frame.width, height: 40))
        
        rowView.backgroundColor = categories[row].color
        
        let label = UILabel(frame: rowView.frame)
        label.textAlignment = .Center
        label.text = categories[row].name
        rowView.addSubview(label)
        
        return rowView
        
    }
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        
        return 40
        
    }
    
}




