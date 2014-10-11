//
//  FormRowDescriptor.swift
//  SwiftForms
//
//  Created by Miguel Angel Ortuno on 20/08/14.
//  Copyright (c) 2014 Miguel Angel Ortuño. All rights reserved.
//

import UIKit

enum FormRowType {
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
    var rowType: FormRowType!
    var tag: String!
    
    var value: NSObject!
    var options: [NSObject]!
    
    var titleFormatter: TitleFormatter!
    
    var cellStyle: UITableViewCellStyle = .Value1
    var cellClass: AnyClass!
    var cellConfiguration: Dictionary<String, NSObject> = [:]
    var cellAccessoryView: UIView!
    
    var dateFormatter: NSDateFormatter!
    
    var selectorControllerClass: AnyClass!
    
    /// MARK: Init
    
    init(tag: String, rowType: FormRowType, title: String) {
        self.tag = tag
        self.rowType = rowType
        self.title = title
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
