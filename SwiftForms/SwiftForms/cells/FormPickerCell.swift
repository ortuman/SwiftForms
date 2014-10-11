//
//  FormPickerCell.swift
//  SwiftForms
//
//  Created by Miguel Angel Ortuno on 22/08/14.
//  Copyright (c) 2014 Miguel Angel Ortuño. All rights reserved.
//

import UIKit

class FormPickerCell: FormBaseCell, UIPickerViewDelegate, UIPickerViewDataSource {
    
    /// MARK: Properties
    
    private let hiddenTextField = UITextField(frame: CGRectZero)
    private let picker = UIPickerView()
    
    /// MARK: FormBaseCell
    
    override func configure() {
        super.configure()
        contentView.addSubview(hiddenTextField)
        picker.delegate = self
        picker.dataSource = self
        hiddenTextField.inputView = picker
    }
    
    override func update() {
        super.update()
        textLabel?.text = rowDescriptor.title
        
        if rowDescriptor.value != nil {
            detailTextLabel?.text = rowDescriptor.titleForOptionValue(rowDescriptor.value)
        }
    }
    
    override class func formViewController(formViewController: FormViewController, didSelectRow selectedRow: FormBaseCell) {
        
        if selectedRow.rowDescriptor.value == nil {
            if let row = selectedRow as? FormPickerCell {
                let optionValue = selectedRow.rowDescriptor.options[0]
                selectedRow.rowDescriptor.value = optionValue
                selectedRow.detailTextLabel?.text = selectedRow.rowDescriptor.titleForOptionValue(optionValue)
                row.hiddenTextField.becomeFirstResponder()
            }
        }
    }
    
    /// MARK: UIPickerViewDelegate
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return rowDescriptor.titleForOptionAtIndex(row)
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let optionValue = rowDescriptor.options[row]
        rowDescriptor.value = optionValue
        detailTextLabel?.text = rowDescriptor.titleForOptionValue(optionValue)
    }
    
    /// MARK: UIPickerViewDataSource
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return rowDescriptor.options.count
    }
}
