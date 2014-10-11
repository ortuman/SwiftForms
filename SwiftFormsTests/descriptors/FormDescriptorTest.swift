//
//  FormDescriptorTest.swift
//  SwiftForms
//
//  Created by Miguel Angel Ortuno on 28/08/14.
//  Copyright (c) 2014 Miguel Angel Ortuño. All rights reserved.
//

import UIKit
import XCTest

class FormDescriptorTest: XCTestCase {

    private var formDescriptor: FormDescriptor!
    private var sectionDescriptor: FormSectionDescriptor!
    private var textRowDescriptor: FormRowDescriptor!
    private var dateRowDescriptor: FormRowDescriptor!
    
    override func setUp() {
        super.setUp()
        formDescriptor = FormDescriptor()
        
        sectionDescriptor = FormSectionDescriptor()
        
        textRowDescriptor = FormRowDescriptor(tag: "textTag", rowType: .Text, title: "textTitle")
        dateRowDescriptor = FormRowDescriptor(tag: "dateTag", rowType: .Date, title: "dateTitle")
        
        sectionDescriptor.addRow(textRowDescriptor)
        sectionDescriptor.addRow(dateRowDescriptor)
    }
    
    override func tearDown() {
        super.tearDown()
        formDescriptor = nil
        sectionDescriptor = nil
        textRowDescriptor = nil
        dateRowDescriptor = nil
    }

    
    func testCanAddSection() {
        formDescriptor.addSection(sectionDescriptor)
        XCTAssert(formDescriptor.sections[0].rows[1].title == "dateTitle", "Can't add section.")
    }
    
    func testCanRemoveSection() {
        formDescriptor.addSection(sectionDescriptor)
        formDescriptor.removeSection(sectionDescriptor)
        XCTAssert(formDescriptor.sections.isEmpty, "Can't remove section.")
    }
    
    func testThatUnassignedRowValuesIsEqualsNull() {
        formDescriptor.addSection(sectionDescriptor)
        let formValues = formDescriptor.formValues()
        let value = formValues["dateTag"] as? NSNull
        XCTAssert(value != nil, "Unassigned tag must have null value.")
    }
    
    func testThatAssignedRowHasValues() {
        sectionDescriptor.rows[0].value = "A text value"
        formDescriptor.addSection(sectionDescriptor)
        let formValues = formDescriptor.formValues()
        let value = formValues["textTag"] as NSString
        XCTAssert(value == "A text value", "Assigned tag must have value.")
    }
}
