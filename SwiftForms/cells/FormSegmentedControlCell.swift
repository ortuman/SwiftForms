//
//  FormSegmentedControlCell.swift
//  SwiftForms
//
//  Created by Miguel Angel Ortuno on 21/08/14.
//  Copyright (c) 2014 Miguel Angel Ortuño. All rights reserved.
//

import UIKit

public class FormSegmentedControlCell: FormBaseCell {
    
    /// MARK: Cell views
    
    public let titleLabel = UILabel()
    public let segmentedControl = UISegmentedControl()
    
    /// MARK: Properties
    
    private var customConstraints: [AnyObject]!
    
    /// MARK: FormBaseCell
    
    public override func configure() {
        super.configure()
        
        selectionStyle = .None
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.setContentCompressionResistancePriority(500, forAxis: .Horizontal)
        segmentedControl.setContentCompressionResistancePriority(500, forAxis: .Horizontal)
        
        titleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(segmentedControl)
        
        contentView.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .CenterY, relatedBy: .Equal, toItem: contentView, attribute: .CenterY, multiplier: 1.0, constant: 0.0))
        contentView.addConstraint(NSLayoutConstraint(item: segmentedControl, attribute: .CenterY, relatedBy: .Equal, toItem: contentView, attribute: .CenterY, multiplier: 1.0, constant: 0.0))
        
        segmentedControl.addTarget(self, action: "valueChanged:", forControlEvents: .ValueChanged)
    }
    
    public override func update() {
        super.update()
        
        titleLabel.text = rowDescriptor.title
        updateSegmentedControl()
        
        var idx = 0
        if rowDescriptor.value != nil {
            if let options = rowDescriptor.configuration[FormRowDescriptor.Configuration.Options] as? NSArray {
                for optionValue in options {
                    if optionValue as! NSObject == rowDescriptor.value {
                        segmentedControl.selectedSegmentIndex = idx
                        break
                    }
                    ++idx
                }
            }
        }
    }
    
    public override func constraintsViews() -> [String : UIView] {
        return ["titleLabel" : titleLabel, "segmentedControl" : segmentedControl]
    }
    
    public override func defaultVisualConstraints() -> [String] {
        
        if titleLabel.text != nil && (titleLabel.text!).characters.count > 0 {
            return ["H:|-16-[titleLabel]-16-[segmentedControl]-16-|"]
        }
        else {
            return ["H:|-16-[segmentedControl]-16-|"]
        }
    }
    
    /// MARK: Actions
    
    internal func valueChanged(sender: UISegmentedControl) {
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
                segmentedControl.insertSegmentWithTitle(rowDescriptor.titleForOptionValue(optionValue as! NSObject), atIndex: idx, animated: false)
                ++idx
            }
        }
    }
}
