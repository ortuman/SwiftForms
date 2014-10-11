//
//  FormRowDescriptorTest.swift
//  SwiftForms
//
//  Created by Miguel Angel Ortuno on 26/08/14.
//  Copyright (c) 2014 Miguel Angel Ortuño. All rights reserved.
//

import UIKit
import XCTest

let titleFormatter: TitleFormatter = { value in
    switch( value ) {
    case 1:
        return "First"
    case 2:
        return "Second"
    case 3:
        return "Third"
    default:
        return nil
    }
}

class FormRowDescriptorTest: XCTestCase {

    private var rowDescriptor: FormRowDescriptor!
    
    override func setUp() {
        super.setUp()
        rowDescriptor = FormRowDescriptor(tag: "tag", rowType: FormRowType.Text, title: "title")
    }
    
    override func tearDown() {
        super.tearDown()
        rowDescriptor = nil
    }

    
    func testTitleFormatter() {
        rowDescriptor.options = [1, 2, 3]
        rowDescriptor.titleFormatter = titleFormatter
        XCTAssert(rowDescriptor.titleFormatter(1) == "First", "Title formatter failed.")
    }
    
    func testGetTitleWithoutHavingTitleFormatter() {
        rowDescriptor.options = [1, 2, 3]
        XCTAssert(rowDescriptor.titleForOptionAtIndex(2) == "3", "Wrong returned title value.")
    }
    
    func testGetTitleHavingTitleFormatter() {
        rowDescriptor.options = [1, 2, 3]
        rowDescriptor.titleFormatter = titleFormatter
        XCTAssert(rowDescriptor.titleForOptionAtIndex(0) == "First", "Wrong returned title value.")
    }
    
    func testGetTitleFromOptionValueWithoutTitleFormatter() {
        XCTAssert(rowDescriptor.titleForOptionValue(2) == "2", "Wrong returned title value.")
    }
    
    func testGetTitleFromOptionValueWithTitleFormatter() {
        rowDescriptor.titleFormatter = titleFormatter
        XCTAssert(rowDescriptor.titleForOptionValue(3) == "Third", "Wrong returned title value.")
    }
}
