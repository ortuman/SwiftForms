//
//  FormDescriptor.swift
//  SwiftForms
//
//  Created by Miguel Angel Ortuno on 20/08/14.
//  Copyright (c) 2014 Miguel Angel Ortuño. All rights reserved.
//

import UIKit

public class FormDescriptor {

    // MARK: Properties
    
    public let title: String
    public var sections: [FormSectionDescriptor] = []
    
    // MARK: Init
    
    public init(title: String) {
        self.title = title
    }
    
    // MARK: Public
    
    public func addSection(section: FormSectionDescriptor) {
        sections.append(section)
    }
    
    public func removeSectionAtIndex(index: Int) throws {
        guard index >= 0 && index < sections.count - 1 else { throw FormErrorType.SectionOutOfIndex }
        sections.removeAtIndex(index)
    }
    
    public func formValues() -> [String : AnyObject] {
        
        var formValues: [String : AnyObject] = [:]

        for section in sections {
            for row in section.rows {
                if row.rowType != .Button {
                    if row.value != nil {
                        formValues[row.tag] = row.value!
                    }
                    else {
                        formValues[row.tag] = NSNull()
                    }
                }
            }
        }
        return formValues
    }
    
    public func validateForm() -> FormRowDescriptor? {
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
