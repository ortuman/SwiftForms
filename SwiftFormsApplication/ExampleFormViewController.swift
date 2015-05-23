//
//  ExampleFormViewController.swift
//  SwiftForms
//
//  Created by Miguel Angel Ortuno on 20/08/14.
//  Copyright (c) 2014 Miguel Angel Ortuño. All rights reserved.
//

import UIKit
import SwiftForms

class ExampleFormViewController: FormViewController {
    
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
        static let stepper = "stepper"
        static let slider = "slider"
        static let textView = "textview"
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadForm()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Submit", style: .Plain, target: self, action: "submit:")
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
        row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.placeholder" : "john@gmail.com", "textField.textAlignment" : NSTextAlignment.Right.rawValue]
        section1.addRow(row)

        row = FormRowDescriptor(tag: Static.passwordTag, rowType: .Password, title: "Password")
        row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.placeholder" : "Enter password", "textField.textAlignment" : NSTextAlignment.Right.rawValue]
        section1.addRow(row)
        
        let section2 = FormSectionDescriptor()
        
        row = FormRowDescriptor(tag: Static.nameTag, rowType: .Name, title: "First Name")
        row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.placeholder" : "e.g. Miguel Ángel", "textField.textAlignment" : NSTextAlignment.Right.rawValue]
        section2.addRow(row)
        
        row = FormRowDescriptor(tag: Static.lastNameTag, rowType: .Name, title: "Last Name")
        row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.placeholder" : "e.g. Ortuño", "textField.textAlignment" : NSTextAlignment.Right.rawValue]
        section2.addRow(row)
        
        row = FormRowDescriptor(tag: Static.jobTag, rowType: .Text, title: "Job")
        row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.placeholder" : "e.g. Entrepreneur", "textField.textAlignment" : NSTextAlignment.Right.rawValue]
        section2.addRow(row)
        
        let section3 = FormSectionDescriptor()

        row = FormRowDescriptor(tag: Static.URLTag, rowType: .URL, title: "URL")
        row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.placeholder" : "e.g. gethooksapp.com", "textField.textAlignment" : NSTextAlignment.Right.rawValue]
        section3.addRow(row)
        
        row = FormRowDescriptor(tag: Static.phoneTag, rowType: .Phone, title: "Phone")
        row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.placeholder" : "e.g. 0034666777999", "textField.textAlignment" : NSTextAlignment.Right.rawValue]
        section3.addRow(row)
        
        let section4 = FormSectionDescriptor()
        
        row = FormRowDescriptor(tag: Static.enabled, rowType: .BooleanSwitch, title: "Enable")
        section4.addRow(row)
        
        row = FormRowDescriptor(tag: Static.check, rowType: .BooleanCheck, title: "Doable")
        section4.addRow(row)
        
        row = FormRowDescriptor(tag: Static.segmented, rowType: .SegmentedControl, title: "Priority")
        row.configuration[FormRowDescriptor.Configuration.Options] = [0, 1, 2, 3]
        row.configuration[FormRowDescriptor.Configuration.TitleFormatterClosure] = { value in
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
        } as TitleFormatterClosure
        
        row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["titleLabel.font" : UIFont.boldSystemFontOfSize(30.0), "segmentedControl.tintColor" : UIColor.redColor()]
        
        section4.addRow(row)
        
        section4.headerTitle = "An example header title"
        section4.footerTitle = "An example footer title"
        
        let section5 = FormSectionDescriptor()
        
        row = FormRowDescriptor(tag: Static.picker, rowType: .Picker, title: "Gender")
        row.configuration[FormRowDescriptor.Configuration.Options] = ["F", "M", "U"]
        row.configuration[FormRowDescriptor.Configuration.TitleFormatterClosure] = { value in
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
        } as TitleFormatterClosure
        
        row.value = "M"
        
        section5.addRow(row)

        row = FormRowDescriptor(tag: Static.birthday, rowType: .Date, title: "Birthday")
        section5.addRow(row)
        row = FormRowDescriptor(tag: Static.categories, rowType: .MultipleSelector, title: "Categories")
        row.configuration[FormRowDescriptor.Configuration.Options] = [0, 1, 2, 3, 4]
        row.configuration[FormRowDescriptor.Configuration.AllowsMultipleSelection] = true
        row.configuration[FormRowDescriptor.Configuration.TitleFormatterClosure] = { value in
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
        } as TitleFormatterClosure
        
        section5.addRow(row)
        
        let section6 = FormSectionDescriptor()
        section6.headerTitle = "Stepper & Slider"
        
        row = FormRowDescriptor(tag: Static.stepper, rowType: .Stepper, title: "Step count")
        row.configuration[FormRowDescriptor.Configuration.MaximumValue] = 200.0
        row.configuration[FormRowDescriptor.Configuration.MinimumValue] = 20.0
        row.configuration[FormRowDescriptor.Configuration.Steps] = 2.0
        section6.addRow(row)
        
        row = FormRowDescriptor(tag: Static.slider, rowType: .Slider, title: "Slider")
        row.value = 0.5
        section6.addRow(row)
        
        let section7 = FormSectionDescriptor()
        row = FormRowDescriptor(tag: Static.textView, rowType: .MultilineText, title: "Notes")
        section7.headerTitle = "Multiline TextView"
        section7.addRow(row)
        
        let section8 = FormSectionDescriptor()
        
        row = FormRowDescriptor(tag: Static.button, rowType: .Button, title: "Dismiss")
        row.configuration[FormRowDescriptor.Configuration.DidSelectClosure] = {
            self.view.endEditing(true)
        } as DidSelectClosure
        section8.addRow(row)
        
        form.sections = [section1, section2, section3, section4, section5, section6, section7, section8]
        
        self.form = form
    }
}
