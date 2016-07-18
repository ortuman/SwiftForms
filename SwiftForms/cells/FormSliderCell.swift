//
//  FormSliderCell.swift
//  SwiftFormsApplication
//
//  Created by Miguel Angel Ortuno Ortuno on 23/5/15.
//  Copyright (c) 2015 Miguel Angel Ortuno Ortuno. All rights reserved.
//

import UIKit

public class FormSliderCell: FormTitleCell {
    
    // MARK: Cell views
    
    public let sliderView = UISlider()
    
    // MARK: FormBaseCell
    
    public override func configure() {
        super.configure()
        
        selectionStyle = .None
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        sliderView.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(sliderView)
        
        titleLabel.setContentHuggingPriority(500, forAxis: .Horizontal)
        
        contentView.addConstraint(NSLayoutConstraint(item: sliderView, attribute: .CenterY, relatedBy: .Equal, toItem: contentView, attribute: .CenterY, multiplier: 1.0, constant: 0.0))
        
        sliderView.addTarget(self, action: #selector(FormSliderCell.valueChanged(_:)), forControlEvents: .ValueChanged)
    }
    
    public override func update() {
        super.update()
        
        if let maximumValue = rowDescriptor?.configuration.stepper.maximumValue { sliderView.maximumValue = Float(maximumValue) }
        if let minimumValue = rowDescriptor?.configuration.stepper.minimumValue { sliderView.minimumValue = Float(minimumValue) }
        if let continuous = rowDescriptor?.configuration.stepper.continuous     { sliderView.continuous = continuous }
        
        titleLabel.text = rowDescriptor?.title
        
        if let value = rowDescriptor?.value as? Float {
            sliderView.value = value
        } else {
            sliderView.value = sliderView.minimumValue
            rowDescriptor?.value = sliderView.minimumValue
        }
    }
    
    public override func constraintsViews() -> [String : UIView] {
        return ["titleLabel" : titleLabel, "sliderView" : sliderView]
    }
    
    public override func defaultVisualConstraints() -> [String] {
        var constraints: [String] = []
        
        constraints.append("V:|[titleLabel]|")
        constraints.append("H:|-16-[titleLabel]-16-[sliderView]-16-|")
        
        return constraints
    }
    
    // MARK: Actions
    
    internal func valueChanged(_: UISlider) {
        rowDescriptor?.value = sliderView.value
        update()
    }
}
