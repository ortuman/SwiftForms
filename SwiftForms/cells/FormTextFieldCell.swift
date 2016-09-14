//
//  FormTextFieldCell.swift
//  SwiftForms
//
//  Created by Miguel Ángel Ortuño Ortuño on 20/08/14.
//  Copyright (c) 2014 Miguel Angel Ortuño. All rights reserved.
//

import UIKit

open class FormTextFieldCell: FormBaseCell {
    
    // MARK: Cell views
    
    open let titleLabel = UILabel()
    open let textField  = UITextField()
    
    // MARK: Properties
    
    fileprivate var customConstraints: [AnyObject] = []
    
    // MARK: FormBaseCell
    
    open override func configure() {
        super.configure()
        
        selectionStyle = .none
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
        textField.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(textField)
        
        titleLabel.setContentHuggingPriority(500, for: .horizontal)
        titleLabel.setContentCompressionResistancePriority(1000, for: .horizontal)
        
        contentView.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: contentView, attribute: .height, multiplier: 1.0, constant: 0.0))
        contentView.addConstraint(NSLayoutConstraint(item: textField, attribute: .height, relatedBy: .equal, toItem: contentView, attribute: .height, multiplier: 1.0, constant: 0.0))
        contentView.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1.0, constant: 0.0))
        contentView.addConstraint(NSLayoutConstraint(item: textField, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1.0, constant: 0.0))
        
        textField.addTarget(self, action: #selector(FormTextFieldCell.editingChanged(_:)), for: .editingChanged)
    }
    
    open override func update() {
        super.update()
        
        if let showsInputToolbar = rowDescriptor?.configuration.cell.showsInputToolbar , showsInputToolbar && textField.inputAccessoryView == nil {
            textField.inputAccessoryView = inputAccesoryView()
        }
        
        titleLabel.text = rowDescriptor?.title
        textField.text = rowDescriptor?.value as? String
        textField.placeholder = rowDescriptor?.configuration.cell.placeholder
        
        textField.isSecureTextEntry = false
        textField.clearButtonMode = .whileEditing
        
        if let type = rowDescriptor?.type {
            switch type {
            case .text:
                textField.autocorrectionType = .default
                textField.autocapitalizationType = .sentences
                textField.keyboardType = .default
            case .number:
                textField.keyboardType = .numberPad
            case .numbersAndPunctuation:
                textField.keyboardType = .numbersAndPunctuation
            case .decimal:
                textField.keyboardType = .decimalPad
            case .name:
                textField.autocorrectionType = .no
                textField.autocapitalizationType = .words
                textField.keyboardType = .default
            case .phone:
                textField.keyboardType = .phonePad
            case .namePhone:
                textField.autocorrectionType = .no
                textField.autocapitalizationType = .words
                textField.keyboardType = .namePhonePad
            case .url:
                textField.autocorrectionType = .no
                textField.autocapitalizationType = .none
                textField.keyboardType = .URL
            case .twitter:
                textField.autocorrectionType = .no
                textField.autocapitalizationType = .none
                textField.keyboardType = .twitter
            case .email:
                textField.autocorrectionType = .no
                textField.autocapitalizationType = .none
                textField.keyboardType = .emailAddress
            case .asciiCapable:
                textField.autocorrectionType = .no
                textField.autocapitalizationType = .none
                textField.keyboardType = .asciiCapable
            case .password:
                textField.isSecureTextEntry = true
                textField.clearsOnBeginEditing = false
            default:
                break
        }
        }
    }
    
    open override func constraintsViews() -> [String : UIView] {
        var views = ["titleLabel" : titleLabel, "textField" : textField]
        if self.imageView!.image != nil {
            views["imageView"] = imageView
        }
        return views
    }
    
    open override func defaultVisualConstraints() -> [String] {
        if self.imageView!.image != nil {
            if titleLabel.text != nil && (titleLabel.text!).characters.count > 0 {
                return ["H:[imageView]-[titleLabel]-[textField]-16-|"]
            } else {
                return ["H:[imageView]-[textField]-16-|"]
            }
        } else {
            if titleLabel.text != nil && (titleLabel.text!).characters.count > 0 {
                return ["H:|-16-[titleLabel]-[textField]-16-|"]
            } else {
                return ["H:|-16-[textField]-16-|"]
            }
        }
    }
    
    open override func firstResponderElement() -> UIResponder? {
        return textField
    }
    
    open override class func formRowCanBecomeFirstResponder() -> Bool {
        return true
    }
    
    // MARK: Actions
    
    internal func editingChanged(_ sender: UITextField) {
        guard let text = sender.text, text.characters.count > 0 else { rowDescriptor?.value = nil; update(); return }
        rowDescriptor?.value = text as AnyObject
    }
}
