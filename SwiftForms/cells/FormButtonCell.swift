//
//  FormButtonCell.swift
//  SwiftForms
//
//  Created by Miguel Angel Ortuno on 21/08/14.
//  Copyright (c) 2016 Miguel Angel Ortuño. All rights reserved.
//

import UIKit

open class FormButtonCell: FormTitleCell {
    
    // MARK: FormBaseCell
    
    open override func configure() {
        super.configure()
        titleLabel.textAlignment = .center
    }
    
    open override func update() {
        super.update()
        titleLabel.text = rowDescriptor?.title
    }
}
