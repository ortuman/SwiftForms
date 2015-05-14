//
//  FormButtonCell.swift
//  SwiftForms
//
//  Created by Miguel Angel Ortuno on 21/08/14.
//  Copyright (c) 2014 Miguel Angel Ortuño. All rights reserved.
//

import UIKit

public class FormButtonCell: FormTitleCell {
    
    /// MARK: FormBaseCell
    
    public override func configure() {
        super.configure()
        titleLabel.textAlignment = .Center
    }
    
    public override func update() {
        super.update()
        titleLabel.text = rowDescriptor.title as String
    }
}
