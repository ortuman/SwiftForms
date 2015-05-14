//
//  FormSwitchCell.swift
//  SwiftForms
//
//  Created by Miguel Angel Ortuno on 21/08/14.
//  Copyright (c) 2014 Miguel Angel Ortuño. All rights reserved.
//

import UIKit

public class FormSwitchCell: FormTitleCell {

    /// MARK: Cell views
    
    public let switchView = UISwitch()
    
    /// MARK: FormBaseCell
    
    public override func configure() {
        super.configure()
        
        selectionStyle = .None
        
        switchView.addTarget(self, action: "valueChanged:", forControlEvents: .ValueChanged)
        accessoryView = switchView
    }
    
    public override func update() {
        super.update()
        
        titleLabel.text = rowDescriptor.title
        
        if rowDescriptor.value != nil {
            switchView.on = rowDescriptor.value as! Bool
        }
        else {
            switchView.on = false
            rowDescriptor.value = false
        }
    }
    
    /// MARK: Actions
    
    internal func valueChanged(_: UISwitch) {
        if switchView.on != rowDescriptor.value {
            rowDescriptor.value = switchView.on as Bool
        }
    }
}
