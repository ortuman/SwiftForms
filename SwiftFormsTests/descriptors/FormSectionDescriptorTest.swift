//
//  FormSectionDescriptorTest.swift
//  SwiftForms
//
//  Created by Miguel Angel Ortuno on 28/08/14.
//  Copyright (c) 2014 Miguel Angel Ortuño. All rights reserved.
//

import UIKit
import XCTest

class FormSectionDescriptorTest: XCTestCase {

    private var sectionDescriptor: FormSectionDescriptor!
    private var rowDescriptor: FormRowDescriptor!
    
    override func setUp() {
        super.setUp()
        sectionDescriptor = FormSectionDescriptor()
        rowDescriptor = FormRowDescriptor(tag: "tag", rowType: .Text, title: "title")
    }
    
    override func tearDown() {
        super.tearDown()
        sectionDescriptor = nil
        rowDescriptor = nil
    }

    
    func testCanAddRow() {
        sectionDescriptor.addRow(rowDescriptor)
        XCTAssert(sectionDescriptor.rows[0].title == "title", "Can't add a row to the section.")
    }
    
    func testCanRemoveRow() {
        sectionDescriptor.addRow(rowDescriptor)
        sectionDescriptor.removeRow(rowDescriptor)
        XCTAssert(sectionDescriptor.rows.isEmpty, "Can't remove a row from the section.")
    }
}
