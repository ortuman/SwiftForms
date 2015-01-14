//
//  FormSegmentedControlCell.swift
//  SwiftForms
//
//  Created by Miguel Angel Ortuno on 21/08/14.
//  Copyright (c) 2014 Miguel Angel Ortuño. All rights reserved.
//

import UIKit

class FormSegmentedControlCell: FormBaseCell {
    
    /// MARK: Cell views
    
    let titleLabel = UILabel()
    let segmentedControl = UISegmentedControl()
    
    /// MARK: Properties
    
    private var customConstraints: [AnyObject]!
    
    /// MARK: FormBaseCell
    
    override func configure() {
        super.configure()
        
        selectionStyle = .None
        
        titleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        segmentedControl.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        titleLabel.setContentCompressionResistancePriority(500, forAxis: .Horizontal)
        segmentedControl.setContentCompressionResistancePriority(500, forAxis: .Horizontal)
        
        titleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(segmentedControl)
        
        contentView.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .CenterY, relatedBy: .Equal, toItem: contentView, attribute: .CenterY, multiplier: 1.0, constant: 0.0))
        contentView.addConstraint(NSLayoutConstraint(item: segmentedControl, attribute: .CenterY, relatedBy: .Equal, toItem: contentView, attribute: .CenterY, multiplier: 1.0, constant: 0.0))
        
        segmentedControl.addTarget(self, action: "valueChanged:", forControlEvents: .ValueChanged)
    }
    
    override func update() {
        super.update()
        
        titleLabel.text = rowDescriptor.title
        updateSegmentedControl()
        
        var idx = 0
        if rowDescriptor.value != nil {
            if let options = rowDescriptor.configuration[FormRowDescriptor.Configuration.Options] as? NSArray {
                for optionValue in options {
                    if optionValue as NSObject == rowDescriptor.value {
                        segmentedControl.selectedSegmentIndex = idx
                        break
                    }
                    ++idx
                }
            }
        }
    }
    
    override func constraintsViews() -> [String : UIView] {
        return ["titleLabel" : titleLabel, "segmentedControl" : segmentedControl]
    }
    
    override func defaultVisualConstraints() -> [String] {
        
        if titleLabel.text != nil && countElements(titleLabel.text!) > 0 {
            return ["H:|-16-[titleLabel]-16-[segmentedControl]-16-|"]
        }
        else {
            return ["H:|-16-[segmentedControl]-16-|"]
        }
    }
    
    /// MARK: Actions
    
    func valueChanged(sender: UISegmentedControl) {
        let options = rowDescriptor.configuration[FormRowDescriptor.Configuration.Options] as? NSArray
        let optionValue = options?[sender.selectedSegmentIndex] as? NSObject
        rowDescriptor.value = optionValue
    }
    
    /// MARK: Private
    
    private func updateSegmentedControl() {
        segmentedControl.removeAllSegments()
        var idx = 0
        if let options = rowDescriptor.configuration[FormRowDescriptor.Configuration.Options] as? NSArray {
            for optionValue in options {
                segmentedControl.insertSegmentWithTitle(rowDescriptor.titleForOptionValue(optionValue as NSObject), atIndex: idx, animated: false)
                ++idx
            }
        }
    }
}
