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

typealias TitleFormatter = (NSObject) -> String!

class FormRowDescriptor: NSObject {

    /// MARK: Properties
    
    var title: String!
    var rowType: FormRowType = .Unknown
    var tag: String!

    var value: NSObject! {
        willSet {
            self.willUpdateValueBlock?(self)
        }
        didSet {
            self.didUpdateValueBlock?(self)
        }
    }
    
    var required = true
    
    var cellClass: AnyClass!
    var cellAccessoryView: UIView!
    var placeholder: String!
    
    var cellConfiguration: NSDictionary!
    
    var willUpdateValueBlock: ((FormRowDescriptor) -> Void)!
    var didUpdateValueBlock: ((FormRowDescriptor) -> Void)!
    
    var visualConstraintsBlock: ((FormBaseCell) -> NSArray)!
    
    var options: NSArray!
    var titleFormatter: TitleFormatter!
    var selectorControllerClass: AnyClass!
    var allowsMultipleSelection = false
    
    var showInputToolbar = false
    var dateFormatter: NSDateFormatter!
    
    var userInfo: NSDictionary!
    
    /// MARK: Init
    
    init(tag: String, rowType: FormRowType, title: String, placeholder: String! = nil) {
        self.tag = tag
        self.rowType = rowType
        self.title = title
        self.placeholder = placeholder
    }
    
    /// MARK: Public interface
    
    func titleForOptionAtIndex(index: Int) -> String! {
        return titleForOptionValue(options[index] as NSObject)
    }
    
    func titleForOptionValue(optionValue: NSObject) -> String! {
        if titleFormatter != nil {
            return titleFormatter(optionValue)
        }
        else if optionValue is String {
            return optionValue as String
        }
        return "\(optionValue)"
    }
}
