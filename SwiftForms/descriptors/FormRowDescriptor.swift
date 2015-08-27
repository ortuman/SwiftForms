//
//  FormRowDescriptor.swift
//  SwiftForms
//
//  Created by Miguel Angel Ortuno on 20/08/14.
//  Copyright (c) 2014 Miguel Angel Ortuño. All rights reserved.
//

import UIKit

public enum FormRowType {
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
    case Stepper
    case Slider
    case MultipleSelector
    case MultilineText
}

public typealias DidSelectClosure = (Void) -> Void
public typealias UpdateClosure = (FormRowDescriptor) -> Void
public typealias TitleFormatterClosure = (NSObject) -> String!
public typealias VisualConstraintsClosure = (FormBaseCell) -> NSArray

public class FormRowDescriptor: NSObject {

    /// MARK: Types
    
    public struct Configuration {
        public static let Required = "FormRowDescriptorConfigurationRequired"

        public static let CellClass = "FormRowDescriptorConfigurationCellClass"
        public static let CheckmarkAccessoryView = "FormRowDescriptorConfigurationCheckmarkAccessoryView"
        public static let CellConfiguration = "FormRowDescriptorConfigurationCellConfiguration"

        public static let Placeholder = "FormRowDescriptorConfigurationPlaceholder"
        
        public static let WillUpdateClosure = "FormRowDescriptorConfigurationWillUpdateClosure"
        public static let DidUpdateClosure = "FormRowDescriptorConfigurationDidUpdateClosure"
        
        public static let MaximumValue = "FormRowDescriptorConfigurationMaximumValue"
        public static let MinimumValue = "FormRowDescriptorConfigurationMinimumValue"
        public static let Steps = "FormRowDescriptorConfigurationSteps"
        
        public static let Continuous = "FormRowDescriptorConfigurationContinuous"
        
        public static let DidSelectClosure = "FormRowDescriptorConfigurationDidSelectClosure"
        
        public static let VisualConstraintsClosure = "FormRowDescriptorConfigurationVisualConstraintsClosure"
        
        public static let Options = "FormRowDescriptorConfigurationOptions"
        
        public static let TitleFormatterClosure = "FormRowDescriptorConfigurationTitleFormatterClosure"
        
        public static let SelectorControllerClass = "FormRowDescriptorConfigurationSelectorControllerClass"
        
        public static let AllowsMultipleSelection = "FormRowDescriptorConfigurationAllowsMultipleSelection"
        
        public static let ShowsInputToolbar = "FormRowDescriptorConfigurationShowsInputToolbar"
        
        public static let DateFormatter = "FormRowDescriptorConfigurationDateFormatter"
    }
    
    /// MARK: Properties
    
    public var title: String!
    public var rowType: FormRowType = .Unknown
    public var tag: String!

    public var value: NSObject! {
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
    
    public var configuration: [NSObject : Any] = [:]
    
    /// MARK: Init
    
    public override init() {
        super.init()
        configuration[Configuration.Required] = true
        configuration[Configuration.AllowsMultipleSelection] = false
        configuration[Configuration.ShowsInputToolbar] = false
    }
    
    public convenience init(tag: String, rowType: FormRowType, title: String, placeholder: String! = nil) {
        self.init()
        self.tag = tag
        self.rowType = rowType
        self.title = title
        
        if placeholder != nil {
            configuration[FormRowDescriptor.Configuration.Placeholder] = placeholder
        }
    }
    
    /// MARK: Public interface
    
    public func titleForOptionAtIndex(index: Int) -> String! {
        if let options = configuration[FormRowDescriptor.Configuration.Options] as? NSArray {
            return titleForOptionValue(options[index] as! NSObject)
        }
        return nil
    }
    
    public func titleForOptionValue(optionValue: NSObject) -> String! {
        if let titleFormatter = configuration[FormRowDescriptor.Configuration.TitleFormatterClosure] as? TitleFormatterClosure {
            return titleFormatter(optionValue)
        }
        else if optionValue is String {
            return optionValue as! String
        }
        return "\(optionValue)"
    }
}
