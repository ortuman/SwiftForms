//
//  FormDescriptor.swift
//  SwiftForms
//
//  Created by Miguel Angel Ortuno on 20/08/14.
//  Copyright (c) 2014 Miguel Angel Ortuño. All rights reserved.
//

import UIKit

public class FormDescriptor: NSObject {

    /// MARK: Properties
    
    public var title: String!
    
    public var sections: [FormSectionDescriptor] = []
    
    /// MARK: Public
    
    public func addSection(section: FormSectionDescriptor) {
        sections.append(section)
    }
    
    public func removeSection(section: FormSectionDescriptor) {
        if let index = sections.indexOf(section) {
            sections.removeAtIndex(index)
        }
    }
    
    public func formValues() -> NSDictionary {
        
        let formValues = NSMutableDictionary()

        for section in sections {
            for row in section.rows {
                if row.tag != nil && row.rowType != .Button {
                    if row.value != nil {
                        formValues[row.tag!] = row.value!
                    }
                    else {
                        formValues[row.tag!] = NSNull()
                    }
                }
            }
        }
        return formValues.copy() as! NSDictionary
    }
    
    public func validateForm() -> FormRowDescriptor! {
        for section in sections {
            for row in section.rows {
                if let required = row.configuration[FormRowDescriptor.Configuration.Required] as? Bool {
                    if required && row.value == nil {
                        return row
                    }
                }
            }
        }
        return nil
    }
}
