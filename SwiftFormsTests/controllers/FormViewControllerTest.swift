//
//  FormViewControllerTest.swift
//  SwiftForms
//
//  Created by Miguel Angel Ortuno on 29/08/14.
//  Copyright (c) 2014 Miguel Angel Ortuño. All rights reserved.
//

import UIKit
import XCTest

class FormViewControllerTest: XCTestCase {

    private var formViewController: FormViewController!
    
    private var form: FormDescriptor!
    private var section1: FormSectionDescriptor!
    private var section2: FormSectionDescriptor!
    
    private var textRow: FormRowDescriptor!
    private var dateRow: FormRowDescriptor!

    private var checkRow: FormRowDescriptor!
    
    override func setUp() {
        super.setUp()
        
        formViewController = FormViewController()
        
        form = FormDescriptor()
        form.title = "Form title"
            
        section1 = FormSectionDescriptor()
        section2 = FormSectionDescriptor()
        
        textRow = FormRowDescriptor(tag: "textTag", rowType: .Text, title: "textTitle")
        dateRow = FormRowDescriptor(tag: "dateTag", rowType: .Date, title: "dateTitle")
        section1.addRow(textRow)
        section1.addRow(dateRow)
        
        checkRow = FormRowDescriptor(tag: "checkTag", rowType: .BooleanSwitch, title: "dateTitle")
        section2.addRow(checkRow)
        
        form.addSection(section1)
        form.addSection(section2)
        
        formViewController.form = form
    }
    
    override func tearDown() {
        super.tearDown()
        formViewController = nil
        form = nil
        section1 = nil
        section2 = nil
        textRow = nil
        dateRow = nil
        checkRow = nil
    }

    func testFormTitleAssignment() {
        // load view
        form.title = "A form title"
        let view = formViewController.view
        XCTAssert(formViewController.navigationItem.title == "A form title", "Form title wasn't assigned.")
    }
}
