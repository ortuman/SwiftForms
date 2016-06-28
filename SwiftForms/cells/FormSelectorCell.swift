//
//  FormSelectorCell.swift
//  SwiftForms
//
//  Created by Miguel Ángel Ortuño Ortuño on 23/08/14.
//  Copyright (c) 2016 Miguel Angel Ortuño. All rights reserved.
//

import UIKit

public class FormSelectorCell: FormValueCell {
    
    // MARK: FormBaseCell
    
    public override func update() {
        super.update()
        
        titleLabel.text = rowDescriptor?.title
        
        var title: String?
        if let multipleValues = rowDescriptor?.value as? [AnyObject] {
            var multipleValuesTitle = ""
            for (index, selectedValue) in multipleValues.enumerate() {
                guard let selectedValueTitle = rowDescriptor?.configuration.selection.optionTitleClosure?(selectedValue) else { continue }
                if index != 0 {
                    multipleValuesTitle += ", "
                }
                multipleValuesTitle += selectedValueTitle
            }
            title = multipleValuesTitle
        } else if let singleValue = rowDescriptor?.value {
            title = rowDescriptor?.configuration.selection.optionTitleClosure?(singleValue)
        }
        
        if let title = title where title.characters.count > 0 {
            valueLabel.text = title
            valueLabel.textColor = UIColor.blackColor()
        } else {
            valueLabel.text = rowDescriptor?.configuration.cell.placeholder
            valueLabel.textColor = UIColor.lightGrayColor()
        }
    }
    
    public override class func formViewController(formViewController: FormViewController, didSelectRow selectedRow: FormBaseCell) {
        guard let row = selectedRow as? FormSelectorCell else { return }
        
        formViewController.view.endEditing(true)
            
        var selectorControllerClass: UIViewController.Type
            
        if let controllerClass = row.rowDescriptor?.configuration.selection.controllerClass as? UIViewController.Type {
            selectorControllerClass = controllerClass
        } else { // fallback to default cell class
            selectorControllerClass = FormOptionsSelectorController.self
        }
        
        let selectorController = selectorControllerClass.init()
        guard let formRowDescriptorViewController = selectorController as? FormSelector else { return }
        
        formRowDescriptorViewController.formCell = row
        formViewController.navigationController?.pushViewController(selectorController, animated: true)
    }
}
