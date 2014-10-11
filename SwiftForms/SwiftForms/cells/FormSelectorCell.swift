//
//  FormSelectorCell.swift
//  SwiftForms
//
//  Created by Miguel Ángel Ortuño Ortuño on 23/08/14.
//  Copyright (c) 2014 Miguel Angel Ortuño. All rights reserved.
//

import UIKit

class FormSelectorCell: FormBaseCell {

    override func configure() {
        super.configure()
        accessoryType = .DisclosureIndicator
    }
    
    override func update() {
        super.update()
        textLabel?.text = rowDescriptor.title

        if let selectedValues = rowDescriptor.value as? [NSObject] {
            
            var title: String! = nil
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
            
            detailTextLabel?.text = title
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
