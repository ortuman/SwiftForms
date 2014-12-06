//
//  ExampleFormViewController.swift
//  SwiftForms
//
//  Created by Miguel Angel Ortuno on 20/08/14.
//  Copyright (c) 2014 Miguel Angel Ortuño. All rights reserved.
//

import UIKit

class ExampleFormViewController: FormViewController, FormViewControllerDelegate {
    
    struct Static {
        static let nameTag = "name"
        static let passwordTag = "password"
        static let lastNameTag = "lastName"
        static let jobTag = "job"
        static let emailTag = "email"
        static let URLTag = "url"
        static let phoneTag = "phone"
        static let enabled = "enabled"
        static let check = "check"
        static let segmented = "segmented"
        static let picker = "picker"
        static let birthday = "birthday"
        static let categories = "categories"
        static let button = "button"
        static let textView = "textview"
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadForm()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Submit", style: .Bordered, target: self, action: "submit:")
    }
    
    /// MARK: Actions
    
    func submit(_: UIBarButtonItem!) {
        
        let message = self.form.formValues().description
        
        let alert: UIAlertView = UIAlertView(title: "Form output", message: message, delegate: nil, cancelButtonTitle: "OK")
        
        alert.show()
    }
    
    /// MARK: Private interface
    
    private func loadForm() {
        
        let form = FormDescriptor()
        
        form.title = "Example Form"
        
        let section1 = FormSectionDescriptor()
        
        var row: FormRowDescriptor! = FormRowDescriptor(tag: Static.emailTag, rowType: .Email, title: "Email")
        row.cellConfiguration = ["textField.placeholder" : "john@gmail.com", "textField.textAlignment" : NSTextAlignment.Right.rawValue]
        section1.addRow(row)

        row = FormRowDescriptor(tag: Static.passwordTag, rowType: .Password, title: "Password")
        row.cellConfiguration = ["textField.placeholder" : "Enter password", "textField.textAlignment" : NSTextAlignment.Right.rawValue]
        section1.addRow(row)
        
        let section2 = FormSectionDescriptor()
        
        row = FormRowDescriptor(tag: Static.nameTag, rowType: .Name, title: "First Name")
        row.cellConfiguration = ["textField.placeholder" : "e.g. Miguel Ángel", "textField.textAlignment" : NSTextAlignment.Right.rawValue]
        section2.addRow(row)
        
        row = FormRowDescriptor(tag: Static.lastNameTag, rowType: .Name, title: "Last Name")
        row.cellConfiguration = ["textField.placeholder" : "e.g. Ortuño", "textField.textAlignment" : NSTextAlignment.Right.rawValue]
        section2.addRow(row)
        
        row = FormRowDescriptor(tag: Static.jobTag, rowType: .Text, title: "Job")
        row.cellConfiguration = ["textField.placeholder" : "e.g. Entrepreneur", "textField.textAlignment" : NSTextAlignment.Right.rawValue]
        section2.addRow(row)
        
        let section3 = FormSectionDescriptor()

        row = FormRowDescriptor(tag: Static.URLTag, rowType: .URL, title: "URL")
        row.cellConfiguration = ["textField.placeholder" : "e.g. gethooksapp.com", "textField.textAlignment" : NSTextAlignment.Right.rawValue]
        section3.addRow(row)
        
        row = FormRowDescriptor(tag: Static.phoneTag, rowType: .Phone, title: "Phone")
        row.cellConfiguration = ["textField.placeholder" : "e.g. 0034666777999", "textField.textAlignment" : NSTextAlignment.Right.rawValue]
        section3.addRow(row)
        
        let section4 = FormSectionDescriptor()
        
        row = FormRowDescriptor(tag: Static.enabled, rowType: .BooleanSwitch, title: "Enable")
        section4.addRow(row)
        
        row = FormRowDescriptor(tag: Static.check, rowType: .BooleanCheck, title: "Doable")
        section4.addRow(row)
        
        row = FormRowDescriptor(tag: Static.segmented, rowType: .SegmentedControl, title: "Priority")
        row.options = [0, 1, 2, 3]
        row.titleFormatter = { value in
            switch( value ) {
            case 0:
                return "None"
            case 1:
                return "!"
            case 2:
                return "!!"
            case 3:
                return "!!!"
            default:
                return nil
            }
        }
        row.cellConfiguration = ["titleLabel.font" : UIFont.boldSystemFontOfSize(30.0), "segmentedControl.tintColor" : UIColor.redColor()]
        section4.addRow(row)
        
        section4.headerTitle = "An example header title"
        section4.footerTitle = "An example footer title"
        
        let section5 = FormSectionDescriptor()
        
        row = FormRowDescriptor(tag: Static.picker, rowType: .Picker, title: "Gender")
        row.options = ["F", "M", "U"]
        row.titleFormatter = { value in
            switch( value ) {
            case "F":
                return "Female"
            case "M":
                return "Male"
            case "U":
                return "I'd rather not to say"
            default:
                return nil
            }
        }
        section5.addRow(row)

        row = FormRowDescriptor(tag: Static.birthday, rowType: .Date, title: "Birthday")
        section5.addRow(row)
        row = FormRowDescriptor(tag: Static.categories, rowType: .MultipleSelector, title: "Categories")
        row.options = [0, 1, 2, 3, 4]
        row.allowsMultipleSelection = true
        row.titleFormatter = { value in
            switch( value ) {
            case 0:
                return "Restaurant"
            case 1:
                return "Pub"
            case 2:
                return "Shop"
            case 3:
                return "Hotel"
            case 4:
                return "Camping"
            default:
                return nil
            }
        }
        section5.addRow(row)
        
        let section6 = FormSectionDescriptor()
        row = FormRowDescriptor(tag: Static.textView, rowType: .MultilineText, title: "Notes")
        section6.headerTitle = "Multiline TextView"
        section6.addRow(row)
        
        let section7 = FormSectionDescriptor()
        
        row = FormRowDescriptor(tag: Static.button, rowType: .Button, title: "Dismiss")
        section7.addRow(row)
        
        form.sections = [section1, section2, section3, section4, section5, section6, section7]
        
        self.form = form
    }
    
    /// MARK: FormViewControllerDelegate
    
    func formViewController(controller: FormViewController, didSelectRowDescriptor rowDescriptor: FormRowDescriptor) {
        if rowDescriptor.tag == Static.button {
            self.view.endEditing(true)
        }
    }
}
