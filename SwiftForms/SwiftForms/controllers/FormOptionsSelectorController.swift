//
//  FormOptionsSelectorController.swift
//  SwiftForms
//
//  Created by Miguel Ángel Ortuño Ortuño on 23/08/14.
//  Copyright (c) 2014 Miguel Angel Ortuño. All rights reserved.
//

import UIKit

class FormOptionsSelectorController: UITableViewController, FormSelector {

    /// MARK: FormSelector
    
    var formCell: FormBaseCell!
    
    /// MARK: Init 
    
    override init() {
        super.init(style: .Grouped)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = formCell.rowDescriptor.title
    }
    
    /// MARK: UITableViewDataSource

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return formCell.rowDescriptor.options.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let reuseIdentifier = NSStringFromClass(self.dynamicType)
        
        var cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier) as? UITableViewCell
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: reuseIdentifier)
        }
        
        let optionValue = formCell.rowDescriptor.options[indexPath.row]

        cell?.textLabel?.text = formCell.rowDescriptor.titleForOptionValue(optionValue)
        
        if let selectedOptions = formCell.rowDescriptor.value as? [NSObject] {
            if (find(selectedOptions, optionValue as NSObject) != nil) {
                if formCell.rowDescriptor.cellAccessoryView == nil {
                    cell?.accessoryType = .Checkmark
                }
                else {
                    cell?.accessoryView = formCell.rowDescriptor.cellAccessoryView
                }
            }
            else {
                cell?.accessoryType = .None
            }
        }
        return cell!
    }
    
    /// MARK: UITableViewDelegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        
        if formCell.rowDescriptor.value == nil {
            formCell.rowDescriptor.value = []
        }
        
        if var selectedOptions = formCell.rowDescriptor.value as? [NSObject] {

            let optionValue = formCell.rowDescriptor.options[indexPath.row]
            
            if let index = find(selectedOptions, optionValue) {
                selectedOptions.removeAtIndex(index)
                cell?.accessoryType = .None
            }
            else {
                selectedOptions.append(optionValue)
                if formCell.rowDescriptor.cellAccessoryView == nil {
                    cell?.accessoryType = .Checkmark
                }
                else {
                    cell?.accessoryView = formCell.rowDescriptor.cellAccessoryView
                }
            }
            
            formCell.rowDescriptor.value = selectedOptions
            
            formCell.update()
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
