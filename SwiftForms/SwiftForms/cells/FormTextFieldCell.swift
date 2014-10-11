//
//  FormTextFieldCell.swift
//  SwiftForms
//
//  Created by Miguel Ángel Ortuño Ortuño on 20/08/14.
//  Copyright (c) 2014 Miguel Angel Ortuño. All rights reserved.
//

import UIKit

class FormTextFieldCell: FormBaseCell {

    /// MARK: Properties
    
    let titleLabel = UILabel()
    let textField = UITextField()
    
    private var customConstraints: [AnyObject]!
    
    /// MARK: FormBaseCell
    
    override func configure() {
        super.configure()
        
        selectionStyle = .None
        
        titleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        textField.setTranslatesAutoresizingMaskIntoConstraints(false)

        titleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        textField.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(textField)
        
        contentView.addConstraints(layoutConstraints())
        
        textField.addTarget(self, action: "editingChanged:", forControlEvents: .EditingChanged)
    }
    
    override func update() {
        super.update()
        
        titleLabel.text = rowDescriptor.title
        textField.text = rowDescriptor.value as? String
    
        textField.secureTextEntry = false
        textField.clearButtonMode = .WhileEditing
        
        switch( rowDescriptor.rowType! ) {
        case .Text:
            textField.autocorrectionType = .Default
            textField.autocapitalizationType = .Sentences
            textField.keyboardType = .Default
        case .Name:
            textField.autocorrectionType = .No
            textField.autocapitalizationType = .Words
            textField.keyboardType = .Default
        case .Phone:
            textField.keyboardType = .PhonePad
        case .URL:
            textField.autocorrectionType = .No
            textField.autocapitalizationType = .None
            textField.keyboardType = .URL
        case .Email:
            textField.autocorrectionType = .No
            textField.autocapitalizationType = .None
            textField.keyboardType = .EmailAddress
        case .Password:
            textField.autocorrectionType = .No
            textField.autocapitalizationType = .None
            textField.keyboardType = .ASCIICapable
            textField.secureTextEntry = true
        default:
            break
        }
    }
    
    /// MARK: Constraints
    
    private func layoutConstraints() -> [AnyObject] {
        var result: [AnyObject] = []
        titleLabel.setContentHuggingPriority(500, forAxis: .Horizontal)
        result.append(NSLayoutConstraint(item: titleLabel, attribute: .Height, relatedBy: .Equal, toItem: contentView, attribute: .Height, multiplier: 1.0, constant: 0.0))
        result.append(NSLayoutConstraint(item: textField, attribute: .Height, relatedBy: .Equal, toItem: contentView, attribute: .Height, multiplier: 1.0, constant: 0.0))
        result.append(NSLayoutConstraint(item: titleLabel, attribute: .CenterY, relatedBy: .Equal, toItem: contentView, attribute: .CenterY, multiplier: 1.0, constant: 0.0))
        result.append(NSLayoutConstraint(item: textField, attribute: .CenterY, relatedBy: .Equal, toItem: contentView, attribute: .CenterY, multiplier: 1.0, constant: 0.0))
        return result
    }
    
    override func updateConstraints() {
        
        if customConstraints != nil {
            contentView.removeConstraints(customConstraints)
        }
        
        var views = ["titleLabel" : titleLabel, "textField" : textField]
        
        if self.imageView?.image != nil {
            
            views["imageView"] = imageView
            
            if titleLabel.text != nil && countElements(titleLabel.text!) > 0 {
                customConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:[imageView]-[titleLabel]-[textField]-4-|", options: NSLayoutFormatOptions(0), metrics: nil, views: views)
            }
            else {
                customConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:[imageView]-[textField]-4-|", options: NSLayoutFormatOptions(0), metrics: nil, views: views)
            }
        }
        else {
            if titleLabel.text != nil && countElements(titleLabel.text!) > 0 {
                customConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-16-[titleLabel]-[textField]-4-|", options: NSLayoutFormatOptions(0), metrics: nil, views: views)
            }
            else {
                customConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-16-[textField]-4-|", options: NSLayoutFormatOptions(0), metrics: nil, views: views)
            }
        }
        
        contentView.addConstraints(customConstraints)
        super.updateConstraints()
    }
    
    /// MARK: Actions
    
    func editingChanged(sender: UITextField) {
        rowDescriptor.value = sender.text
    }
}
