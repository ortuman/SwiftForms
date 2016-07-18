//
//  FormSwitchCell.swift
//  SwiftForms
//
//  Created by Miguel Angel Ortuno on 21/08/14.
//  Copyright (c) 2014 Miguel Angel Ortuño. All rights reserved.
//

import UIKit

public class FormSwitchCell: FormTitleCell {
    
    // MARK: Cell views
    
    public let switchView = UISwitch()
    
    // MARK: FormBaseCell
    
    public override func configure() {
        super.configure()
        
        selectionStyle = .None
        
        switchView.addTarget(self, action: #selector(FormSwitchCell.valueChanged(_:)), forControlEvents: .ValueChanged)
        accessoryView = switchView
    }
    
    public override func update() {
        super.update()
        
        titleLabel.text = rowDescriptor?.title
        
        if let value = rowDescriptor?.value as? Bool {
            switchView.on = value
        } else {
            switchView.on = false
            rowDescriptor?.value = false
        }
    }
    
    // MARK: Actions
    
    internal func valueChanged(_: UISwitch) {
        rowDescriptor?.value = switchView.on
        update()
    }
}
