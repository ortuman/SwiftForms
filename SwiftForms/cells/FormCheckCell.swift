//
//  FormCheckCell.swift
//  SwiftForms
//
//  Created by Miguel Angel Ortuno on 22/08/14.
//  Copyright (c) 2016 Miguel Angel Ortuño. All rights reserved.
//

import UIKit

public class FormCheckCell: FormTitleCell {
    
    // MARK: FormBaseCell
    
    public override func configure() {
        super.configure()
        selectionStyle = .Default
        accessoryType = .None
    }
    
    public override func update() {
        super.update()
        
        titleLabel.text = rowDescriptor?.title
        
        var rowValue: Bool
        if let value = rowDescriptor?.value as? Bool {
            rowValue = value
        } else {
            rowValue = false
            rowDescriptor?.value = rowValue
        }
        
        accessoryType = (rowValue) ? .Checkmark : .None
    }
    
    public override class func formViewController(formViewController: FormViewController, didSelectRow selectedRow: FormBaseCell) {
        guard let row = selectedRow as? FormCheckCell else { return }
        row.check()
    }
    
    // MARK: Private interface
    
    private func check() {
        var newValue: Bool
        if let value = rowDescriptor?.value as? Bool {
            newValue = !value
        }
        else {
            newValue = true
        }
        rowDescriptor?.value = newValue
        update()
    }
}
