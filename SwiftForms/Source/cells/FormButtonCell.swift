//
//  FormButtonCell.swift
//  SwiftForms
//
//  Created by Miguel Angel Ortuno on 21/08/14.
//  Copyright (c) 2014 Miguel Angel Ortuño. All rights reserved.
//

import UIKit

class FormButtonCell: FormBaseCell {

    /// MARK: Properties
    
    let titleLabel = UILabel()
    
    /// MARK: FormBaseCell
    
    override func configure() {
        super.configure()
        titleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        titleLabel.textAlignment = .Center
        titleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        contentView.addSubview(titleLabel)
        contentView.addConstraints(layoutConstraints())        
    }
    
    override func update() {
        super.update()
        titleLabel.text = rowDescriptor.title as String
    }
    
    /// MARK: Constraints
    
    private func layoutConstraints() -> [AnyObject] {
        var result: [AnyObject] = []
        titleLabel.setContentHuggingPriority(500, forAxis: .Horizontal)
        result.append(NSLayoutConstraint(item: titleLabel, attribute: .Height, relatedBy: .Equal, toItem: contentView, attribute: .Height, multiplier: 1.0, constant: 0.0))
        result.append(NSLayoutConstraint(item: titleLabel, attribute: .Width, relatedBy: .Equal, toItem: contentView, attribute: .Width, multiplier: 1.0, constant: 0.0))
        result.append(NSLayoutConstraint(item: titleLabel, attribute: .CenterY, relatedBy: .Equal, toItem: contentView, attribute: .CenterY, multiplier: 1.0, constant: 0.0))
        result.append(NSLayoutConstraint(item: titleLabel, attribute: .CenterX, relatedBy: .Equal, toItem: contentView, attribute: .CenterX, multiplier: 1.0, constant: 0.0))
        return result
    }
}
