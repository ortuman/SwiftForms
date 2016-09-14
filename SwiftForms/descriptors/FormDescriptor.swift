//
//  FormDescriptor.swift
//  SwiftForms
//
//  Created by Miguel Angel Ortuno on 20/08/14.
//  Copyright (c) 2016 Miguel Angel Ortuño. All rights reserved.
//

import UIKit

public final class FormDescriptor {
    
    // MARK: Properties
    
    public var title: String
    public var sections: [FormSectionDescriptor] = []
    
    // MARK: Init
    
    public init() {
        self.title = ""
    }
    
    public init(title: String) {
        self.title = title
    }
    
    // MARK: Public
    
    public func formValues() -> [String : AnyObject] {
        
        var formValues: [String : AnyObject] = [:]
        
        for section in sections {
            for row in section.rows {
                if row.type != .button {
                    if let value = row.value {
                        formValues[row.tag] = value
                    } else {
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
                if row.configuration.cell.required && row.value == nil {
                    return row
                }
            }
        }
        return nil
    }
}
