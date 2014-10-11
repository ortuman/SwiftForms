//
//  FormSegmentedControlCell.swift
//  SwiftForms
//
//  Created by Miguel Angel Ortuno on 21/08/14.
//  Copyright (c) 2014 Miguel Angel Ortuño. All rights reserved.
//

import UIKit

class FormSegmentedControlCell: FormBaseCell {

    /// MARK: Properties
    
    let titleLabel = UILabel()
    let segmentedControl = UISegmentedControl()
    
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
        contentView.addConstraints(layoutConstraints());
        segmentedControl.addTarget(self, action: "valueChanged:", forControlEvents: .ValueChanged)
    }
    
    override func update() {
        super.update()
        titleLabel.text = rowDescriptor.title
        updateSegmentedControl()
        
        var idx = 0
        if rowDescriptor.value != nil {
            for optionValue in rowDescriptor.options {
                if optionValue == rowDescriptor.value {
                    segmentedControl.selectedSegmentIndex = idx
                    break
                }
                ++idx
            }
        }
    }
    
    /// MARK: Constraints
    
    private func layoutConstraints() -> [AnyObject] {
        var result: [AnyObject] = []
        titleLabel.setContentHuggingPriority(500, forAxis: .Horizontal)
        result.append(NSLayoutConstraint(item: titleLabel, attribute: .CenterY, relatedBy: .Equal, toItem: contentView, attribute: .CenterY, multiplier: 1.0, constant: 0.0))
        result.append(NSLayoutConstraint(item: segmentedControl, attribute: .CenterY, relatedBy: .Equal, toItem: contentView, attribute: .CenterY, multiplier: 1.0, constant: 0.0))
        return result
    }
    
    override func updateConstraints() {
        
        if customConstraints != nil {
            contentView.removeConstraints(customConstraints)
        }
        
        let views = ["titleLabel" : titleLabel, "segmentedControl" : segmentedControl]
        
        if titleLabel.text != nil && countElements(titleLabel.text!) > 0 {
            customConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-16-[titleLabel]-16-[segmentedControl]-16-|", options: NSLayoutFormatOptions(0), metrics:nil, views: views)
        }
        else {
            customConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-16-[segmentedControl]-16-|", options: NSLayoutFormatOptions(0), metrics: nil, views: views)
        }
        
        contentView.addConstraints(customConstraints)
        super.updateConstraints()
    }
    
    /// MARK: Actions
    
    func valueChanged(sender: UISegmentedControl) {
        let optionValue = rowDescriptor.options[sender.selectedSegmentIndex]
        rowDescriptor.value = optionValue
    }
    
    /// MARK: Private
    
    private func updateSegmentedControl() {
        segmentedControl.removeAllSegments()
        var idx = 0
        for optionValue in rowDescriptor.options {
            segmentedControl.insertSegmentWithTitle(rowDescriptor.titleForOptionValue(optionValue), atIndex: idx, animated: false)
            ++idx
        }
    }
}
