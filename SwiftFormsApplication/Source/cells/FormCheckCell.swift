//
//  FormCheckCell.swift
//  SwiftForms
//
//  Created by Miguel Angel Ortuno on 22/08/14.
//  Copyright (c) 2014 Miguel Angel Ortuño. All rights reserved.
//

import UIKit

public class FormCheckCell: FormTitleCell {

    /// MARK: FormBaseCell
    
    public override func configure() {
        super.configure()
        selectionStyle = .Default
        accessoryType = .None
    }
    
    public override func update() {
        super.update()
        
        titleLabel.text = rowDescriptor.title
        
        if rowDescriptor.value == nil {
            rowDescriptor.value = false
        }
        
        accessoryType = (rowDescriptor.value as! Bool) ? .Checkmark : .None
    }
    
    public override class func formViewController(formViewController: FormViewController, didSelectRow selectedRow: FormBaseCell) {
        
        if let row = selectedRow as? FormCheckCell {
            row.check()
        }
    }
    
    /// MARK: Private interface
    
    private func check() {
        if rowDescriptor.value != nil {
            rowDescriptor.value = !(rowDescriptor.value as! Bool)
        }
        else {
            rowDescriptor.value = true
        }
        accessoryType = (rowDescriptor.value as! Bool) ? .Checkmark : .None
    }
}
