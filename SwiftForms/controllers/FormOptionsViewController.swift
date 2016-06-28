//
//  FormOptionsSelectorController.swift
//  SwiftForms
//
//  Created by Miguel Ángel Ortuño Ortuño on 23/08/14.
//  Copyright (c) 2016 Miguel Angel Ortuño. All rights reserved.
//

import UIKit

public class FormOptionsSelectorController: UITableViewController, FormSelector {
    
    // MARK: FormSelector
    
    public var formCell: FormBaseCell?
    
    // MARK: Init
    
    public init() {
        super.init(style: .Grouped)
    }
    
    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = formCell?.rowDescriptor?.title
    }
    
    // MARK: UITableViewDataSource
    
    public override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    public override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let options = formCell?.rowDescriptor?.configuration.selection.options where !options.isEmpty else { return 0 }
        return options.count
    }
    
    public override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    public override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let reuseIdentifier = NSStringFromClass(self.dynamicType)
        
        var cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: reuseIdentifier)
        }
        
        let options = formCell!.rowDescriptor!.configuration.selection.options
        let optionValue = options[indexPath.row]
        
        cell?.textLabel?.text = formCell?.rowDescriptor?.configuration.selection.optionTitleClosure?(optionValue)
        
        if let selectedOptions = formCell?.rowDescriptor?.value as? [AnyObject] {
            if let _ = selectedOptions.indexOf({ $0 === optionValue }) {
                cell?.accessoryType = .Checkmark
            } else {
                cell?.accessoryType = .None
            }
            
        } else if let selectedOption = formCell?.rowDescriptor?.value {
            if optionValue === selectedOption {
                cell?.accessoryType = .Checkmark
            } else {
                cell?.accessoryType = .None
            }
        }

        return cell!
    }
    
    // MARK: UITableViewDelegate
    
    public override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        
        var allowsMultipleSelection = false
        if let allowsMultipleSelectionValue = formCell?.rowDescriptor?.configuration.selection.allowsMultipleSelection {
            allowsMultipleSelection = allowsMultipleSelectionValue
        }
        
        let options = formCell!.rowDescriptor!.configuration.selection.options
        let selectedOption = options[indexPath.row]
        
        if allowsMultipleSelection {
            if var selectedOptions = formCell?.rowDescriptor?.value as? [AnyObject] {
                if let index = selectedOptions.indexOf({ $0 === selectedOption }) {
                    selectedOptions.removeAtIndex(index)
                    cell?.accessoryType = .None
                } else {
                    selectedOptions.append(selectedOption)
                    cell?.accessoryType = .Checkmark
                }
                formCell?.rowDescriptor?.value = selectedOptions
                
            } else {
                formCell?.rowDescriptor?.value = [AnyObject](arrayLiteral: selectedOption)
                cell?.accessoryType = .Checkmark
            }

        } else {
            formCell?.rowDescriptor?.value = selectedOption
        }
        
        formCell?.update()
        
        if allowsMultipleSelection {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        } else {
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
}
