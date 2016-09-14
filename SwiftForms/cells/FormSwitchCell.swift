//
//  FormSwitchCell.swift
//  SwiftForms
//
//  Created by Miguel Angel Ortuno on 21/08/14.
//  Copyright (c) 2014 Miguel Angel Ortuño. All rights reserved.
//

import UIKit

open class FormSwitchCell: FormTitleCell {
    
    // MARK: Cell views
    
    open let switchView = UISwitch()
    
    // MARK: FormBaseCell
    
    open override func configure() {
        super.configure()
        
        selectionStyle = .none
        
        switchView.addTarget(self, action: #selector(FormSwitchCell.valueChanged(_:)), for: .valueChanged)
        accessoryView = switchView
    }
    
    open override func update() {
        super.update()
        
        titleLabel.text = rowDescriptor?.title
        
        if let value = rowDescriptor?.value as? Bool {
            switchView.isOn = value
        } else {
            switchView.isOn = false
            rowDescriptor?.value = false as AnyObject
        }
    }
    
    // MARK: Actions
    
    internal func valueChanged(_: UISwitch) {
        rowDescriptor?.value = switchView.isOn as AnyObject
        update()
    }
}
