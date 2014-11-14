//
//  FormSelectorCell.swift
//  SwiftForms
//
//  Created by Miguel Ángel Ortuño Ortuño on 23/08/14.
//  Copyright (c) 2014 Miguel Angel Ortuño. All rights reserved.
//

import UIKit

class FormSelectorCell: FormValueCell {
    
    /// MARK: FormBaseCell
    
    override func update() {
 
        titleLabel.text = rowDescriptor.title

        var title: String!
        
        if let selectedValues = rowDescriptor.value as? [NSObject] { // multiple values
            
            for optionValue in rowDescriptor.options {
                if find(selectedValues, optionValue) != nil {
                    let optionTitle = rowDescriptor.titleForOptionValue(optionValue)
                    if title != nil {
                        title = title + ", \(optionTitle)"
                    }
                    else {
                        title = optionTitle
                    }
                }
            }
        }
        else if let selectedValue = rowDescriptor.value { // single value
            title = rowDescriptor.titleForOptionValue(selectedValue)
        }
        
        if title != nil && countElements(title) > 0 {
            valueLabel.text = title
            valueLabel.textColor = UIColor.blackColor()
        }
        else {
            valueLabel.text = rowDescriptor.placeholder
            valueLabel.textColor = UIColor.lightGrayColor()
        }
    }
    
    override class func formViewController(formViewController: FormViewController, didSelectRow selectedRow: FormBaseCell) {
        if let row = selectedRow as? FormSelectorCell {
            
            formViewController.view.endEditing(true)
            
            var selectorClass: UIViewController.Type!
            
            if row.rowDescriptor.selectorControllerClass == nil { // fallback to default cell class
                selectorClass = FormOptionsSelectorController.self
            }
            else {
                selectorClass = row.rowDescriptor.selectorControllerClass as? UIViewController.Type
            }
            
            if selectorClass != nil {
                let selectorController = selectorClass()
                if let formRowDescriptorViewController = selectorController as? FormSelector {
                    formRowDescriptorViewController.formCell = row
                    formViewController.navigationController?.pushViewController(selectorController, animated: true)
                }
                else {
                    fatalError("selectorControllerClass must conform to FormSelector protocol.")
                }
            }
        }
    }
}
