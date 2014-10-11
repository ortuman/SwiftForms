//
//  FormSwitchCell.swift
//  SwiftForms
//
//  Created by Miguel Angel Ortuno on 21/08/14.
//  Copyright (c) 2014 Miguel Angel Ortuño. All rights reserved.
//

import UIKit

class FormSwitchCell: FormBaseCell {

    /// MARK: Properties
    
    let switchView = UISwitch()
    
    /// MARK: FormBaseCell
    
    override func configure() {
        super.configure()
        selectionStyle = .None
        accessoryView = switchView
        switchView.addTarget(self, action: "valueChanged:", forControlEvents: .ValueChanged)
    }
    
    override func update() {
        super.update()
        textLabel?.text = rowDescriptor.title
        
        if rowDescriptor.value != nil {
            switchView.on = rowDescriptor.value as Bool
        }
        else {
            switchView.on = false
        }
    }
    
    /// MARK: Actions
    
    func valueChanged(_: UISwitch) {
        rowDescriptor.value = switchView.on as Bool
    }
}
