//
//  FormPickerCell.swift
//  SwiftForms
//
//  Created by Miguel Angel Ortuno on 22/08/14.
//  Copyright (c) 2016 Miguel Angel Ortuño. All rights reserved.
//

import UIKit

public class FormPickerCell: FormValueCell, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // MARK: Properties
    
    private let picker = UIPickerView()
    private let hiddenTextField = UITextField(frame: CGRectZero)
    
    // MARK: FormBaseCell
    
    public override func configure() {
        super.configure()
        accessoryType = .None
        
        picker.delegate = self
        picker.dataSource = self
        hiddenTextField.inputView = picker
        
        contentView.addSubview(hiddenTextField)
    }
    
    public override func update() {
        super.update()
        picker.reloadAllComponents()
        
        if let showsInputToolbar = rowDescriptor?.configuration.cell.showsInputToolbar where showsInputToolbar && hiddenTextField.inputAccessoryView == nil {
            hiddenTextField.inputAccessoryView = inputAccesoryView()
        }
        
        titleLabel.text = rowDescriptor?.title
        
        if let selectedValue = rowDescriptor?.value {
            valueLabel.text = rowDescriptor?.configuration.selection.optionTitleClosure?(selectedValue)
            if let options = rowDescriptor?.configuration.selection.options where !options.isEmpty {
                var selectedIndex: Int?
                for (index, value) in options.enumerate() {
                    if value === selectedValue {
                        selectedIndex = index
                        break
                    }
                }
                if let index = selectedIndex {
                    picker.selectRow(index, inComponent: 0, animated: false)
                }
            }
        }
    }
    
    public override func firstResponderElement() -> UIResponder? {
        return hiddenTextField
    }
    
    public override class func formViewController(formViewController: FormViewController, didSelectRow selectedRow: FormBaseCell) {
        guard let row = selectedRow as? FormPickerCell else { return }
        
        if selectedRow.rowDescriptor?.value == nil {
            guard let options = selectedRow.rowDescriptor?.configuration.selection.options where !options.isEmpty else { return }
            let value = options[0]
            selectedRow.rowDescriptor?.value = value
            row.valueLabel.text = selectedRow.rowDescriptor?.configuration.selection.optionTitleClosure?(value)
            row.hiddenTextField.becomeFirstResponder()
        } else {
            guard let value = selectedRow.rowDescriptor?.value else { return }
            row.valueLabel.text = selectedRow.rowDescriptor?.configuration.selection.optionTitleClosure?(value)
            row.hiddenTextField.becomeFirstResponder()
        }
    }
    
    // MARK: UIPickerViewDelegate
    
    public func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let options = rowDescriptor?.configuration.selection.options where !options.isEmpty else { return nil }
        guard row < options.count else { return nil }
        return rowDescriptor?.configuration.selection.optionTitleClosure?(options[row])
    }
    
    public func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let options = rowDescriptor?.configuration.selection.options where !options.isEmpty else { return }
        guard row < options.count else { return }
        let newValue = options[row]
        rowDescriptor?.value = newValue
        valueLabel.text = rowDescriptor?.configuration.selection.optionTitleClosure?(newValue)
    }
    
    // MARK: UIPickerViewDataSource
    
    public func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let options = rowDescriptor?.configuration.selection.options else { return 0 }
        return options.count
    }
}
