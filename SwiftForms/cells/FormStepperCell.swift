//
//  FormStepperCell.swift
//  SwiftFormsApplication
//
//  Created by Miguel Angel Ortuno Ortuno on 23/5/15.
//  Copyright (c) 2015 Miguel Angel Ortuno Ortuno. All rights reserved.
//

public class FormStepperCell: FormTitleCell {

    /// MARK: Cell views
    
    public let stepperView = UIStepper()
    public let countLabel = UILabel()
    
    /// MARK: FormBaseCell
    
    public override func configure() {
        super.configure()
        
        selectionStyle = .None
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        stepperView.translatesAutoresizingMaskIntoConstraints = false
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        countLabel.textAlignment = .Right
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(countLabel)
        contentView.addSubview(stepperView)
        
        titleLabel.setContentHuggingPriority(500, forAxis: .Horizontal)
        
        contentView.addConstraint(NSLayoutConstraint(item: stepperView, attribute: .CenterY, relatedBy: .Equal, toItem: contentView, attribute: .CenterY, multiplier: 1.0, constant: 0.0))
        
        stepperView.addTarget(self, action: "valueChanged:", forControlEvents: .ValueChanged)
    }
    
    public override func update() {
        super.update()
        
        if let maximumValue = rowDescriptor.configuration[FormRowDescriptor.Configuration.MaximumValue] as? Double {
            stepperView.maximumValue = maximumValue
        }
        
        if let minimumValue = rowDescriptor.configuration[FormRowDescriptor.Configuration.MinimumValue] as? Double {
            stepperView.minimumValue = minimumValue
        }
        
        if let steps = rowDescriptor.configuration[FormRowDescriptor.Configuration.Steps] as? Double {
            stepperView.stepValue = steps
        }
        
        titleLabel.text = rowDescriptor.title
        
        if rowDescriptor.value != nil {
            stepperView.value = rowDescriptor.value as! Double
        }
        else {
            stepperView.value = stepperView.minimumValue
            rowDescriptor.value = stepperView.minimumValue
        }
        
        countLabel.text = rowDescriptor.value.description
    }
    
    public override func constraintsViews() -> [String : UIView] {
        return ["titleLabel" : titleLabel, "countLabel" : countLabel, "stepperView" : stepperView]
    }
    
    public override func defaultVisualConstraints() -> [String] {
        var constraints: [String] = []
        
        constraints.append("V:|[titleLabel]|")
        constraints.append("V:|[countLabel]|")
        
        constraints.append("H:|-16-[titleLabel][countLabel]-[stepperView]-16-|")
        return constraints
    }
    
    /// MARK: Actions
    
    internal func valueChanged(_: UISwitch) {
        rowDescriptor.value = stepperView.value
        countLabel.text = rowDescriptor.value.description
    }
}
