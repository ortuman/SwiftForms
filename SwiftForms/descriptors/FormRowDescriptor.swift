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
    case Label
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
public typealias TitleFormatterClosure = (NSObject) -> String
public typealias VisualConstraintsClosure = (FormBaseCell) -> NSArray

public class FormRowDescriptor {

    // MARK: Types

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

    // MARK: Properties

    public let tag: String
    public let title: String?
    public let rowType: FormRowType

    public var value: NSObject? {
        willSet {
            guard let willUpdateBlock = self.configuration[Configuration.WillUpdateClosure] as? UpdateClosure else { return }
            willUpdateBlock(self)
        }
        didSet {
            guard let didUpdateBlock = self.configuration[Configuration.DidUpdateClosure] as? UpdateClosure else { return }
            didUpdateBlock(self)
        }
    }

    public var configuration: [String : Any] = [:]

    // MARK: Init

    public init(tag: String, rowType: FormRowType, title: String, placeholder: String? = nil) {
        self.tag = tag
        self.rowType = rowType
        self.title = title

        if placeholder != nil {
            configuration[FormRowDescriptor.Configuration.Placeholder] = placeholder!
        }

        configuration[Configuration.Required] = true
        configuration[Configuration.AllowsMultipleSelection] = false
        configuration[Configuration.ShowsInputToolbar] = false
    }

    // MARK: Public interface

    public func titleForOptionAtIndex(index: Int) -> String? {
        if let options = configuration[FormRowDescriptor.Configuration.Options] as? NSArray {
            return titleForOptionValue(options[index] as! NSObject)
        }
        return nil
    }

    public func titleForOptionValue(optionValue: NSObject) -> String {
        if let titleFormatter = configuration[FormRowDescriptor.Configuration.TitleFormatterClosure] as? TitleFormatterClosure {
            return titleFormatter(optionValue)
        }
        return "\(optionValue)"
    }
}
