//
//  FormRowDescriptor.swift
//  SwiftForms
//
//  Created by Miguel Angel Ortuno on 20/08/14.
//  Copyright (c) 2014 Miguel Angel Ortuño. All rights reserved.
//

import UIKit

enum FormRowType {
    case Unknown
    case Text
    case URL
    case Number
    case NumbersAndPunctuation
    case Decimal
    case Name
    case Phone
    case NamePhone
    case Email
    case Twitter
    case ASCIICapable
    case Password
    case Button
    case BooleanSwitch
    case BooleanCheck
    case SegmentedControl
    case Picker
    case Date
    case Time
    case DateAndTime
    case MultipleSelector
    case MultilineText
}

typealias UpdateClosure = (FormRowDescriptor) -> Void
typealias TitleFormatterClosure = (NSObject) -> String!
typealias VisualConstraintsClosure = (FormBaseCell) -> NSArray

class FormRowDescriptor: NSObject {

    /// MARK: Types
    
    struct Configuration {
        static let Required = "FormRowDescriptorConfigurationRequired"

        static let CellClass = "FormRowDescriptorConfigurationCellClass"
        static let CheckmarkAccessoryView = "FormRowDescriptorConfigurationCheckmarkAccessoryView"
        static let CellConfiguration = "FormRowDescriptorConfigurationCellConfiguration"

        static let Placeholder = "FormRowDescriptorConfigurationPlaceholder"
        
        static let WillUpdateClosure = "FormRowDescriptorConfigurationWillUpdateClosure"
        static let DidUpdateClosure = "FormRowDescriptorConfigurationDidUpdateClosure"
        
        static let VisualConstraintsClosure = "FormRowDescriptorConfigurationVisualConstraintsClosure"
        
        static let Options = "FormRowDescriptorConfigurationOptions"
        
        static let TitleFormatterClosure = "FormRowDescriptorConfigurationTitleFormatterClosure"
        
        static let SelectorControllerClass = "FormRowDescriptorConfigurationSelectorControllerClass"
        
        static let AllowsMultipleSelection = "FormRowDescriptorConfigurationSelectorControllerClass"
        
        static let ShowsInputToolbar = "FormRowDescriptorConfigurationShowsInputToolbar"
        
        static let DateFormatter = "FormRowDescriptorConfigurationDateFormatter"
    }
    
    /// MARK: Properties
    
    var title: String!
    var rowType: FormRowType = .Unknown
    var tag: String!

    var value: NSObject! {
        willSet {
            if let willUpdateBlock = self.configuration[Configuration.WillUpdateClosure] as? UpdateClosure {
                willUpdateBlock(self)
            }
        }
        didSet {
            if let didUpdateBlock = self.configuration[Configuration.DidUpdateClosure] as? UpdateClosure {
                didUpdateBlock(self)
            }
        }
    }
    
    var configuration: [NSObject : Any] = [:]
    
    /// MARK: Init
    
    override init() {
        super.init()
        configuration[Configuration.Required] = true
        configuration[Configuration.AllowsMultipleSelection] = false
        configuration[Configuration.ShowsInputToolbar] = false
    }
    
    convenience init(tag: String, rowType: FormRowType, title: String, placeholder: String! = nil) {
        self.init()
        self.tag = tag
        self.rowType = rowType
        self.title = title
        
        if placeholder != nil {
            configuration[FormRowDescriptor.Configuration.Placeholder] = placeholder
        }
    }
    
    /// MARK: Public interface
    
    func titleForOptionAtIndex(index: Int) -> String! {
        if let options = configuration[FormRowDescriptor.Configuration.Options] as? NSArray {
            return titleForOptionValue(options[index] as NSObject)
        }
        return nil
    }
    
    func titleForOptionValue(optionValue: NSObject) -> String! {
        if let titleFormatter = configuration[FormRowDescriptor.Configuration.TitleFormatterClosure] as? TitleFormatterClosure {
            return titleFormatter(optionValue)
        }
        else if optionValue is String {
            return optionValue as String
        }
        return "\(optionValue)"
    }
}
