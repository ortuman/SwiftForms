//
//  FormTextFieldCell.swift
//  SwiftForms
//
//  Created by Miguel Ángel Ortuño Ortuño on 20/08/14.
//  Copyright (c) 2016 Miguel Angel Ortuño. All rights reserved.
//

import UIKit

class FormLabelCell: FormValueCell {
    
    /// MARK: FormBaseCell
    
    override func configure() {
        super.configure()
        
        accessoryType = .none
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
        valueLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
        
        valueLabel.textColor = UIColor.lightGray
        valueLabel.textAlignment = .right
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(valueLabel)
        
        titleLabel.setContentHuggingPriority(500, for: .horizontal)
        titleLabel.setContentCompressionResistancePriority(1000, for: .horizontal)
        
        // apply constant constraints
        contentView.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: contentView, attribute: .height, multiplier: 1.0, constant: 0.0))
        contentView.addConstraint(NSLayoutConstraint(item: valueLabel, attribute: .height, relatedBy: .equal, toItem: contentView, attribute: .height, multiplier: 1.0, constant: 0.0))
        contentView.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1.0, constant: 0.0))
        contentView.addConstraint(NSLayoutConstraint(item: valueLabel, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1.0, constant: 0.0))
    }
    
    override func update() {
        super.update()
        
        titleLabel.text = rowDescriptor?.title
        valueLabel.text = rowDescriptor?.configuration.cell.placeholder
    }
}
