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
    
    /// MARK: Public interface
    
    func addSection(section: FormSectionDescriptor) {
        sections.append(section)
    }
    
    func removeSection(section: FormSectionDescriptor) {
        if let index = find(sections, section) {
            sections.removeAtIndex(index)
        }
    }
    
    func formValues() -> Dictionary<String, NSObject> {
        
        var formValues: Dictionary<String, NSObject> = [:]

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
        return formValues
    }
}
