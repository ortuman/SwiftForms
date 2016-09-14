//
//  FormSliderCell.swift
//  SwiftFormsApplication
//
//  Created by Miguel Angel Ortuno Ortuno on 23/5/15.
//  Copyright (c) 2015 Miguel Angel Ortuno Ortuno. All rights reserved.
//

import UIKit

open class FormSliderCell: FormTitleCell {
    
    // MARK: Cell views
    
    open let sliderView = UISlider()
    
    // MARK: FormBaseCell
    
    open override func configure() {
        super.configure()
        
        selectionStyle = .none
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        sliderView.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(sliderView)
        
        titleLabel.setContentHuggingPriority(500, for: .horizontal)
        
        contentView.addConstraint(NSLayoutConstraint(item: sliderView, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1.0, constant: 0.0))
        
        sliderView.addTarget(self, action: #selector(FormSliderCell.valueChanged(_:)), for: .valueChanged)
    }
    
    open override func update() {
        super.update()
        
        if let maximumValue = rowDescriptor?.configuration.stepper.maximumValue { sliderView.maximumValue = Float(maximumValue) }
        if let minimumValue = rowDescriptor?.configuration.stepper.minimumValue { sliderView.minimumValue = Float(minimumValue) }
        if let continuous = rowDescriptor?.configuration.stepper.continuous     { sliderView.isContinuous = continuous }
        
        titleLabel.text = rowDescriptor?.title
        
        if let value = rowDescriptor?.value as? Float {
            sliderView.value = value
        } else {
            sliderView.value = sliderView.minimumValue
            rowDescriptor?.value = sliderView.minimumValue as AnyObject
        }
    }
    
    open override func constraintsViews() -> [String : UIView] {
        return ["titleLabel" : titleLabel, "sliderView" : sliderView]
    }
    
    open override func defaultVisualConstraints() -> [String] {
        var constraints: [String] = []
        
        constraints.append("V:|[titleLabel]|")
        constraints.append("H:|-16-[titleLabel]-16-[sliderView]-16-|")
        
        return constraints
    }
    
    // MARK: Actions
    
    internal func valueChanged(_: UISlider) {
        rowDescriptor?.value = sliderView.value as AnyObject
        update()
    }
}
