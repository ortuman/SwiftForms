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
    case Name
    case Phone
    case URL
    case Email
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
}

typealias TitleFormatter = (NSObject) -> String!

class FormRowDescriptor: NSObject {

    /// MARK: Properties
    
    var title: String!
    var rowType: FormRowType = .Unknown
    var tag: String!
    var value: NSObject!
    
    var cellClass: AnyClass!
    var cellAccessoryView: UIView!
    var placeholder: String!
    
    var cellConfiguration: [String : AnyObject] = [:]
    var visualConstraintsBlock: ((FormBaseCell) -> [String])!
    
    var options: [NSObject]!
    var titleFormatter: TitleFormatter!
    var allowsMultipleSelection = false
    var selectorControllerClass: AnyClass!
    
    var dateFormatter: NSDateFormatter!
    
    var userInfo: [NSObject : AnyObject] = [:]
    
    /// MARK: Init
    
    init(tag: String, rowType: FormRowType, title: String, placeholder: String! = nil) {
        self.tag = tag
        self.rowType = rowType
        self.title = title
        self.placeholder = placeholder
    }
    
    /// MARK: Public interface
    
    func titleForOptionAtIndex(index: Int) -> String! {
        return titleForOptionValue(options[index])
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
