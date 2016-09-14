//
//  FormTextViewCell.swift
//  SwiftForms
//
//  Created by Joey Padot on 12/6/14.
//  Copyright (c) 2014 Miguel Angel Ortuño. All rights reserved.
//

import UIKit

open class FormTextViewCell : FormBaseCell, UITextViewDelegate {
    
    // MARK: Cell views
    
    open let titleLabel = UILabel()
    open let textField  = UITextView()
    
    // MARK: Properties
    
    fileprivate var customConstraints: [AnyObject]!
    
    // MARK: Class Funcs
    
    open override class func formRowCellHeight() -> CGFloat {
        return 110.0
    }
    
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
        
        contentView.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: contentView, attribute: .height, multiplier: 1.0, constant: 0.0))
        contentView.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1.0, constant: 0.0))
        contentView.addConstraint(NSLayoutConstraint(item: textField, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1.0, constant: 0.0))
        contentView.addConstraint(NSLayoutConstraint(item: textField, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1.0, constant: 0.0))
        
        textField.delegate = self
    }
    
    open override func update() {
        
        titleLabel.text = rowDescriptor?.title
        textField.text = rowDescriptor?.value as? String
        
        textField.isSecureTextEntry = false
        textField.autocorrectionType = .default
        textField.autocapitalizationType = .sentences
        textField.keyboardType = .default
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
            if let text = titleLabel.text , text.characters.count > 0 {
                return ["H:[imageView]-[titleLabel]-[textField]-16-|"]
            } else {
                return ["H:[imageView]-[textField]-16-|"]
            }
        } else {
            if let text = titleLabel.text , text.characters.count > 0 {
                return ["H:|-16-[titleLabel]-[textField]-16-|"]
            } else {
                return ["H:|-16-[textField]-16-|"]
            }
        }
    }
    
    // MARK: UITextViewDelegate
    
    open func textViewDidChange(_ textView: UITextView) {
        guard let text = textView.text , text.characters.count > 0 else { rowDescriptor?.value = nil; update(); return }
        rowDescriptor?.value = text as AnyObject
        update()
    }
}
