//
//  FormOptionsSelectorController.swift
//  SwiftForms
//
//  Created by Miguel Ángel Ortuño Ortuño on 23/08/14.
//  Copyright (c) 2016 Miguel Angel Ortuño. All rights reserved.
//

import UIKit

open class FormOptionsSelectorController: UITableViewController, FormSelector {
    
    // MARK: FormSelector
    
    open var formCell: FormBaseCell?
    
    // MARK: Init
    
    public init() {
        super.init(style: .grouped)
    }
    
    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = formCell?.rowDescriptor?.title
    }
    
    // MARK: UITableViewDataSource
    
    open override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    open override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let options = formCell?.rowDescriptor?.configuration.selection.options , !options.isEmpty else { return 0 }
        return options.count
    }
    
    open override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let reuseIdentifier = NSStringFromClass(type(of: self))
        
        var cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: reuseIdentifier)
        }
        
        let options = formCell!.rowDescriptor!.configuration.selection.options
        let optionValue = options[(indexPath as NSIndexPath).row]
        
        cell?.textLabel?.text = formCell?.rowDescriptor?.configuration.selection.optionTitleClosure?(optionValue)
        
        if let selectedOptions = formCell?.rowDescriptor?.value as? [AnyObject] {
            if let _ = selectedOptions.index(where: { $0 === optionValue }) {
                cell?.accessoryType = .checkmark
            } else {
                cell?.accessoryType = .none
            }
            
        } else if let selectedOption = formCell?.rowDescriptor?.value {
            if optionValue === selectedOption {
                cell?.accessoryType = .checkmark
            } else {
                cell?.accessoryType = .none
            }
        }

        return cell!
    }
    
    // MARK: UITableViewDelegate
    
    open override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        
        var allowsMultipleSelection = false
        if let allowsMultipleSelectionValue = formCell?.rowDescriptor?.configuration.selection.allowsMultipleSelection {
            allowsMultipleSelection = allowsMultipleSelectionValue
        }
        
        let options = formCell!.rowDescriptor!.configuration.selection.options
        let selectedOption = options[(indexPath as NSIndexPath).row]
        
        if allowsMultipleSelection {
            if var selectedOptions = formCell?.rowDescriptor?.value as? [AnyObject] {
                if let index = selectedOptions.index(where: { $0 === selectedOption }) {
                    selectedOptions.remove(at: index)
                    cell?.accessoryType = .none
                } else {
                    selectedOptions.append(selectedOption)
                    cell?.accessoryType = .checkmark
                }
                formCell?.rowDescriptor?.value = selectedOptions as AnyObject
                
            } else {
                formCell?.rowDescriptor?.value = [AnyObject](arrayLiteral: selectedOption) as AnyObject
                cell?.accessoryType = .checkmark
            }

        } else {
            formCell?.rowDescriptor?.value = selectedOption
        }
        
        formCell?.update()
        
        if allowsMultipleSelection {
            tableView.deselectRow(at: indexPath, animated: true)
        } else {
            let _ = self.navigationController?.popViewController(animated: true)
        }
    }
}
