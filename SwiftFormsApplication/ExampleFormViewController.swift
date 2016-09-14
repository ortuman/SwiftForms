//
//  ExampleFormViewController.swift
//  SwiftForms
//®
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
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Submit", style: .plain, target: self, action: #selector(ExampleFormViewController.submit(_:)))
    }
    
    // MARK: Actions
    
    func submit(_: UIBarButtonItem!) {
        
        let message = self.form.formValues().description
        
        let alertController = UIAlertController(title: "Form output", message: message, preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "OK", style: .cancel) { (action) in
        }
        
        alertController.addAction(cancel)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: Private interface
    
    fileprivate func loadForm() {
        
        let form = FormDescriptor(title: "Example Form")
        
        let section1 = FormSectionDescriptor(headerTitle: nil, footerTitle: nil)
        
        var row = FormRowDescriptor(tag: Static.emailTag, type: .email, title: "Email")
        row.configuration.cell.appearance = ["textField.placeholder" : "john@gmail.com" as AnyObject, "textField.textAlignment" : NSTextAlignment.right.rawValue as AnyObject]
        section1.rows.append(row)

        row = FormRowDescriptor(tag: Static.passwordTag, type: .password, title: "Password")
        row.configuration.cell.appearance = ["textField.placeholder" : "Enter password" as AnyObject, "textField.textAlignment" : NSTextAlignment.right.rawValue as AnyObject]
        section1.rows.append(row)
        
        let section2 = FormSectionDescriptor(headerTitle: nil, footerTitle: nil)
        
        row = FormRowDescriptor(tag: Static.nameTag, type: .name, title: "First Name")
        row.configuration.cell.appearance = ["textField.placeholder" : "e.g. Miguel Ángel" as AnyObject, "textField.textAlignment" : NSTextAlignment.right.rawValue as AnyObject]
        section2.rows.append(row)
        
        row = FormRowDescriptor(tag: Static.lastNameTag, type: .name, title: "Last Name")
        row.configuration.cell.appearance = ["textField.placeholder" : "e.g. Ortuño" as AnyObject, "textField.textAlignment" : NSTextAlignment.right.rawValue as AnyObject]
        section2.rows.append(row)
        
        row = FormRowDescriptor(tag: Static.jobTag, type: .text, title: "Job")
        row.configuration.cell.appearance = ["textField.placeholder" : "e.g. Entrepreneur" as AnyObject, "textField.textAlignment" : NSTextAlignment.right.rawValue as AnyObject]
        section2.rows.append(row)
        
        let section3 = FormSectionDescriptor(headerTitle: nil, footerTitle: nil)

        row = FormRowDescriptor(tag: Static.URLTag, type: .url, title: "URL")
        row.configuration.cell.appearance = ["textField.placeholder" : "e.g. gethooksapp.com" as AnyObject, "textField.textAlignment" : NSTextAlignment.right.rawValue as AnyObject]
        section3.rows.append(row)
        
        row = FormRowDescriptor(tag: Static.phoneTag, type: .phone, title: "Phone")
        row.configuration.cell.appearance = ["textField.placeholder" : "e.g. 0034666777999" as AnyObject, "textField.textAlignment" : NSTextAlignment.right.rawValue as AnyObject]
        section3.rows.append(row)
        
        let section4 = FormSectionDescriptor(headerTitle: "An example header title", footerTitle: "An example footer title")
        
        row = FormRowDescriptor(tag: Static.enabled, type: .booleanSwitch, title: "Enable")
        section4.rows.append(row)
        
        row = FormRowDescriptor(tag: Static.check, type: .booleanCheck, title: "Doable")
        section4.rows.append(row)
        
        row = FormRowDescriptor(tag: Static.segmented, type: .segmentedControl, title: "Priority")
        row.configuration.selection.options = ([0, 1, 2, 3] as [Int]) as [AnyObject]
        row.configuration.selection.optionTitleClosure = { value in
            guard let option = value as? Int else { return "" }
            switch option {
            case 0:
                return "None"
            case 1:
                return "!"
            case 2:
                return "!!"
            case 3:
                return "!!!"
            default:
                return ""
            }
        }
        
        row.configuration.cell.appearance = ["titleLabel.font" : UIFont.boldSystemFont(ofSize: 30.0), "segmentedControl.tintColor" : UIColor.red]
        
        section4.rows.append(row)
        
        let section5 = FormSectionDescriptor(headerTitle: nil, footerTitle: nil)
        
        row = FormRowDescriptor(tag: Static.picker, type: .picker, title: "Gender")
        row.configuration.cell.showsInputToolbar = true
        row.configuration.selection.options = (["F", "M", "U"] as [String]) as [AnyObject]
        row.configuration.selection.optionTitleClosure = { value in
            guard let option = value as? String else { return "" }
            switch option {
            case "F":
                return "Female"
            case "M":
                return "Male"
            case "U":
                return "I'd rather not to say"
            default:
                return ""
            }
        }
        
        row.value = "M" as AnyObject
        
        section5.rows.append(row)

        row = FormRowDescriptor(tag: Static.birthday, type: .date, title: "Birthday")
        row.configuration.cell.showsInputToolbar = true
        section5.rows.append(row)
        
        row = FormRowDescriptor(tag: Static.categories, type: .multipleSelector, title: "Categories")
        row.configuration.selection.options = ([0, 1, 2, 3, 4] as [Int]) as [AnyObject]
        row.configuration.selection.allowsMultipleSelection = true
        row.configuration.selection.optionTitleClosure = { value in
            guard let option = value as? Int else { return "" }
            switch option {
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
                return ""
            }
        }
        
        section5.rows.append(row)
        
        let section6 = FormSectionDescriptor(headerTitle: "Stepper & Slider", footerTitle: nil)
        
        row = FormRowDescriptor(tag: Static.stepper, type: .stepper, title: "Step count")
        row.configuration.stepper.maximumValue = 200.0
        row.configuration.stepper.minimumValue = 20.0
        row.configuration.stepper.steps = 2.0
        section6.rows.append(row)
        
        row = FormRowDescriptor(tag: Static.slider, type: .slider, title: "Slider")
        row.configuration.stepper.maximumValue = 200.0
        row.configuration.stepper.minimumValue = 20.0
        row.configuration.stepper.steps = 2.0
        row.value = 0.5 as AnyObject
        section6.rows.append(row)
        
        let section7 = FormSectionDescriptor(headerTitle: "Multiline TextView", footerTitle: nil)
        row = FormRowDescriptor(tag: Static.textView, type: .multilineText, title: "Notes")
        section7.rows.append(row)
        
        let section8 = FormSectionDescriptor(headerTitle: nil, footerTitle: nil)
        
        row = FormRowDescriptor(tag: Static.button, type: .button, title: "Dismiss")
        row.configuration.button.didSelectClosure = { _ in
            self.view.endEditing(true)
        }
        section8.rows.append(row)

        form.sections = [section1, section2, section3, section4, section5, section6, section7, section8]
        
        self.form = form
    }
}
