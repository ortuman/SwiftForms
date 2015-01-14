//
//  FormDescriptor.swift
//  SwiftForms
//
//  Created by Miguel Angel Ortuno on 20/08/14.
//  Copyright (c) 2014 Miguel Angel Ortuño. All rights reserved.
//

import UIKit

class FormDescriptor: NSObject {

    /// MARK: Properties
    
    var title: String!
    
    var sections: [FormSectionDescriptor] = []
    
    /// MARK: Public
    
    func addSection(section: FormSectionDescriptor) {
        sections.append(section)
    }
    
    func removeSection(section: FormSectionDescriptor) {
        if let index = find(sections, section) {
            sections.removeAtIndex(index)
        }
    }
    
    func formValues() -> NSDictionary {
        
        var formValues = NSMutableDictionary()

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
        return formValues.copy() as NSDictionary
    }
    
    func validateForm() -> FormRowDescriptor! {
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
