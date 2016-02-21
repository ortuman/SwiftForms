//
//  FormSectionDescriptor.swift
//  SwiftForms
//
//  Created by Miguel Angel Ortuno on 20/08/14.
//  Copyright (c) 2014 Miguel Angel Ortuño. All rights reserved.
//

import UIKit

public class FormSectionDescriptor {

    // MARK: Properties
    
    public let headerTitle: String?
    public let footerTitle: String?
    
    public var rows: [FormRowDescriptor] = []
    
    // MARK: Init
    
    public init(headerTitle: String?, footerTitle: String?) {
        self.headerTitle = headerTitle
        self.footerTitle = footerTitle
    }
    
    // MARK: Public interface
    
    public func addRow(row: FormRowDescriptor) {
        rows.append(row)
    }
    
    public func removeRowAtIndex(index: Int) throws {
        guard index >= 0 && index < rows.count - 1 else { throw FormErrorType.RowOutOfIndex }
        rows.removeAtIndex(index)
    }
}
