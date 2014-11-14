//
//  FormTextFieldCell.swift
//  SwiftForms
//
//  Created by Miguel Ángel Ortuño Ortuño on 20/08/14.
//  Copyright (c) 2014 Miguel Angel Ortuño. All rights reserved.
//

import UIKit

class FormTextFieldCell: FormBaseCell {

    /// MARK: Cell views
    
    let titleLabel = UILabel()
    let textField = UITextField()
    
    /// MARK: Properties
    
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
        
        titleLabel.setContentHuggingPriority(500, forAxis: .Horizontal)
        
        contentView.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .Height, relatedBy: .Equal, toItem: contentView, attribute: .Height, multiplier: 1.0, constant: 0.0))
        contentView.addConstraint(NSLayoutConstraint(item: textField, attribute: .Height, relatedBy: .Equal, toItem: contentView, attribute: .Height, multiplier: 1.0, constant: 0.0))
        contentView.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .CenterY, relatedBy: .Equal, toItem: contentView, attribute: .CenterY, multiplier: 1.0, constant: 0.0))
        contentView.addConstraint(NSLayoutConstraint(item: textField, attribute: .CenterY, relatedBy: .Equal, toItem: contentView, attribute: .CenterY, multiplier: 1.0, constant: 0.0))
        
        textField.addTarget(self, action: "editingChanged:", forControlEvents: .EditingChanged)
    }
    
    override func update() {
        
        titleLabel.text = rowDescriptor.title
        textField.text = rowDescriptor.value as? String
        textField.placeholder = rowDescriptor.placeholder
    
        textField.secureTextEntry = false
        textField.clearButtonMode = .WhileEditing
        
        switch rowDescriptor.rowType {
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
    
    override func constraintsViews() -> [String : UIView] {
        var views = ["titleLabel" : titleLabel, "textField" : textField]
        if self.imageView.image != nil {
            views["imageView"] = imageView
        }
        return views
    }
    
    override func defaultVisualConstraints() -> [String] {
        
        if self.imageView.image != nil {
            
            if titleLabel.text != nil && countElements(titleLabel.text!) > 0 {
                return ["H:[imageView]-[titleLabel]-[textField]-16-|"]
            }
            else {
                return ["H:[imageView]-[textField]-16-|"]
            }
        }
        else {
            if titleLabel.text != nil && countElements(titleLabel.text!) > 0 {
                return ["H:|-16-[titleLabel]-[textField]-16-|"]
            }
            else {
                return ["H:|-16-[textField]-16-|"]
            }
        }
    }
    
    /// MARK: Actions
    
    func editingChanged(sender: UITextField) {
        rowDescriptor.value = sender.text
    }
}
