//
//  FormTitleCell.swift
//  SwiftForms
//
//  Created by Miguel Ángel Ortuño Ortuño on 13/11/14.
//  Copyright (c) 2014 Miguel Angel Ortuño. All rights reserved.
//

import UIKit

open class FormTitleCell: FormBaseCell {
    
    // MARK: Cell views
    
    open let titleLabel = UILabel()
    
    // MARK: FormBaseCell
    
    open override func configure() {
        super.configure()
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
        
        // apply constant constraints
        contentView.addSubview(titleLabel)
        contentView.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: contentView, attribute: .height, multiplier: 1.0, constant: 0.0))
        contentView.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1.0, constant: 0.0))
    }
    
    open override func constraintsViews() -> [String : UIView] {
        return ["titleLabel" : titleLabel]
    }
    
    open override func defaultVisualConstraints() -> [String] {
        return ["H:|-16-[titleLabel]-16-|"]
    }
}
