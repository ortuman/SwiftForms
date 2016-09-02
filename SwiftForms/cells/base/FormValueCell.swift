//
//  FormValueCell.swift
//  SwiftForms
//
//  Created by Miguel Ángel Ortuño Ortuño on 13/11/14.
//  Copyright (c) 2014 Miguel Angel Ortuño. All rights reserved.
//

import UIKit

open class FormValueCell: FormBaseCell {
    
    // MARK: Cell views
    
    open let titleLabel = UILabel()
    open let valueLabel = UILabel()
    
    // MARK: Properties
    
    fileprivate var customConstraints: [AnyObject]!
    
    // MARK: FormBaseCell
    
    open override func configure() {
        super.configure()
        
        accessoryType = .disclosureIndicator
        
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
    
    open override func constraintsViews() -> [String : UIView] {
        return ["titleLabel" : titleLabel, "valueLabel" : valueLabel]
    }
    
    open override func defaultVisualConstraints() -> [String] {
        
        // apply default constraints
        var rightPadding = 0
        if accessoryType == .none {
            rightPadding = 16
        }
        
        if titleLabel.text != nil && (titleLabel.text!).characters.count > 0 {
            return ["H:|-16-[titleLabel]-[valueLabel]-\(rightPadding)-|"]
        }
        else {
            return ["H:|-16-[valueLabel]-\(rightPadding)-|"]
        }
    }
}
