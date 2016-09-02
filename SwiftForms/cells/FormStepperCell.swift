//
//  FormStepperCell.swift
//  SwiftFormsApplication
//
//  Created by Miguel Angel Ortuno Ortuno on 23/5/15.
//  Copyright (c) 2015 Miguel Angel Ortuno Ortuno. All rights reserved.
//

import UIKit

open class FormStepperCell: FormTitleCell {
    
    // MARK: Cell views
    
    open let stepperView = UIStepper()
    open let countLabel = UILabel()
    
    // MARK: FormBaseCell
    
    open override func configure() {
        super.configure()
        
        selectionStyle = .none
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        stepperView.translatesAutoresizingMaskIntoConstraints = false
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
        countLabel.textAlignment = .right
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(countLabel)
        contentView.addSubview(stepperView)
        
        titleLabel.setContentHuggingPriority(500, for: .horizontal)
        
        contentView.addConstraint(NSLayoutConstraint(item: stepperView, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1.0, constant: 0.0))
        
        stepperView.addTarget(self, action: #selector(FormStepperCell.valueChanged(_:)), for: .valueChanged)
    }
    
    open override func update() {
        super.update()
        
        if let maximumValue = rowDescriptor?.configuration.stepper.maximumValue { stepperView.maximumValue = maximumValue }
        if let minimumValue = rowDescriptor?.configuration.stepper.minimumValue { stepperView.minimumValue = minimumValue }
        if let steps = rowDescriptor?.configuration.stepper.steps               { stepperView.stepValue = steps }
        
        titleLabel.text = rowDescriptor?.title
        
        if let value = rowDescriptor?.value as? Double {
            stepperView.value = value
            countLabel.text = String(value)
        } else {
            stepperView.value = stepperView.minimumValue
            rowDescriptor?.value = stepperView.minimumValue as AnyObject
            countLabel.text = String(stepperView.minimumValue)
        }
    }
    
    open override func constraintsViews() -> [String : UIView] {
        return ["titleLabel" : titleLabel, "countLabel" : countLabel, "stepperView" : stepperView]
    }
    
    open override func defaultVisualConstraints() -> [String] {
        var constraints: [String] = []
        
        constraints.append("V:|[titleLabel]|")
        constraints.append("V:|[countLabel]|")
        
        constraints.append("H:|-16-[titleLabel][countLabel]-[stepperView]-16-|")
        return constraints
    }
    
    // MARK: Actions
    
    internal func valueChanged(_: UISwitch) {
        rowDescriptor?.value = stepperView.value as AnyObject
        update()
    }
}
