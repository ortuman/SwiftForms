//
//  FormViewController.swift
//  SwiftForms
//
//  Created by Miguel Angel Ortuño on 20/08/14.
//  Copyright (c) 2014 Miguel Angel Ortuño. All rights reserved.
//

import UIKit

public class FormViewController : UITableViewController {
    
    // MARK: Class variables
    
    private static var onceDefaultCellClass: dispatch_once_t = 0
    private static var defaultCellClasses: [FormRowDescriptor.RowType : FormBaseCell.Type] = [:]
    
    // MARK: Properties
    
    public var form = FormDescriptor()
    
    // MARK: Init
    
    public convenience init() {
        self.init(style: .Grouped)
    }
    
    public convenience init(form: FormDescriptor) {
        self.init(style: .Grouped)
        self.form = form
    }
    
    public override init(style: UITableViewStyle) {
        super.init(style: style)
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // MARK: View life cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = form.title
    }
    
    // MARK: Public interface
    
    public func valueForTag(tag: String) -> AnyObject? {
        for section in form.sections {
            for row in section.rows {
                if row.tag == tag {
                    return row.value
                }
            }
        }
        return nil
    }
    
    public func setValue(value: AnyObject, forTag tag: String) {
        for (sectionIndex, section) in form.sections.enumerate() {
            for (rowIndex, row) in section.rows.enumerate() {
                if row.tag == tag {
                    form.sections[sectionIndex].rows[rowIndex].value = value
                    if let cell = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: rowIndex, inSection: sectionIndex)) as? FormBaseCell {
                        cell.update()
                    }
                    return
                }
            }
        }
    }
    
    // MARK: UITableViewDataSource
    
    public override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return form.sections.count
    }
    
    public override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return form.sections[section].rows.count
    }
    
    public override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let rowDescriptor = formRowDescriptorAtIndexPath(indexPath)
        
        let formBaseCellClass = formBaseCellClassFromRowDescriptor(rowDescriptor)
        
        let reuseIdentifier = NSStringFromClass(formBaseCellClass)
        
        var cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier) as? FormBaseCell
        if cell == nil {
            cell = formBaseCellClass.init(style: .Default, reuseIdentifier: reuseIdentifier)
            cell?.formViewController = self
            cell?.configure()
        }
        
        cell?.rowDescriptor = rowDescriptor
        
        // apply cell custom design
        for (keyPath, value) in rowDescriptor.configuration.cell.appearance {
            cell?.setValue(value, forKeyPath: keyPath)
        }
        return cell!
    }
    
    public override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return form.sections[section].headerTitle
    }
    
    public override func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return form.sections[section].footerTitle
    }
    
    public override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let headerView = form.sections[section].headerView else { return nil }
        return headerView
    }
    
    public override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let footerView = form.sections[section].footerView else { return nil }
        return footerView
    }
    
    public override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let headerView = form.sections[section].headerView where headerView.translatesAutoresizingMaskIntoConstraints else {
            return form.sections[section].headerViewHeight
        }
        return headerView.frame.size.height
    }
    
    public override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        guard let footerView = form.sections[section].footerView where footerView.translatesAutoresizingMaskIntoConstraints else {
            return form.sections[section].footerViewHeight
        }
        return footerView.frame.size.height
    }
    
    // MARK: UITableViewDelegate
    
    public override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let rowDescriptor = formRowDescriptorAtIndexPath(indexPath)
        
        if let formBaseCellClass = formBaseCellClassFromRowDescriptor(rowDescriptor) {
            return formBaseCellClass.formRowCellHeight()
        }
        return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
    }
    
    public override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let rowDescriptor = formRowDescriptorAtIndexPath(indexPath)
        
        if let selectedRow = tableView.cellForRowAtIndexPath(indexPath) as? FormBaseCell {
            if let formBaseCellClass = formBaseCellClassFromRowDescriptor(rowDescriptor) {
                formBaseCellClass.formViewController(self, didSelectRow: selectedRow)
            }
        }
        
        if let didSelectClosure = rowDescriptor.configuration.button.didSelectClosure {
            didSelectClosure(rowDescriptor)
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    private class func defaultCellClassForRowType(rowType: FormRowDescriptor.RowType) -> FormBaseCell.Type {
        dispatch_once(&FormViewController.onceDefaultCellClass) {
            FormViewController.defaultCellClasses[.Text] = FormTextFieldCell.self
            FormViewController.defaultCellClasses[.Label] = FormLabelCell.self
            FormViewController.defaultCellClasses[.Number] = FormTextFieldCell.self
            FormViewController.defaultCellClasses[.NumbersAndPunctuation] = FormTextFieldCell.self
            FormViewController.defaultCellClasses[.Decimal] = FormTextFieldCell.self
            FormViewController.defaultCellClasses[.Name] = FormTextFieldCell.self
            FormViewController.defaultCellClasses[.Phone] = FormTextFieldCell.self
            FormViewController.defaultCellClasses[.URL] = FormTextFieldCell.self
            FormViewController.defaultCellClasses[.Twitter] = FormTextFieldCell.self
            FormViewController.defaultCellClasses[.NamePhone] = FormTextFieldCell.self
            FormViewController.defaultCellClasses[.Email] = FormTextFieldCell.self
            FormViewController.defaultCellClasses[.ASCIICapable] = FormTextFieldCell.self
            FormViewController.defaultCellClasses[.Password] = FormTextFieldCell.self
            FormViewController.defaultCellClasses[.Button] = FormButtonCell.self
            FormViewController.defaultCellClasses[.BooleanSwitch] = FormSwitchCell.self
            FormViewController.defaultCellClasses[.BooleanCheck] = FormCheckCell.self
            FormViewController.defaultCellClasses[.SegmentedControl] = FormSegmentedControlCell.self
            FormViewController.defaultCellClasses[.Picker] = FormPickerCell.self
            FormViewController.defaultCellClasses[.Date] = FormDateCell.self
            FormViewController.defaultCellClasses[.Time] = FormDateCell.self
            FormViewController.defaultCellClasses[.DateAndTime] = FormDateCell.self
            FormViewController.defaultCellClasses[.Stepper] = FormStepperCell.self
            FormViewController.defaultCellClasses[.Slider] = FormSliderCell.self
            FormViewController.defaultCellClasses[.MultipleSelector] = FormSelectorCell.self
            FormViewController.defaultCellClasses[.MultilineText] = FormTextViewCell.self
        }
        return FormViewController.defaultCellClasses[rowType]!
    }
    
    private func formRowDescriptorAtIndexPath(indexPath: NSIndexPath) -> FormRowDescriptor {
    
        let section = form.sections[indexPath.section]
        let rowDescriptor = section.rows[indexPath.row]
        return rowDescriptor
    }
    
    private func formBaseCellClassFromRowDescriptor(rowDescriptor: FormRowDescriptor) -> FormBaseCell.Type! {
        
        var formBaseCellClass: FormBaseCell.Type
        
        if let cellClass = rowDescriptor.configuration.cell.cellClass as? FormBaseCell.Type {
            formBaseCellClass = cellClass
        } else {
            formBaseCellClass = FormViewController.defaultCellClassForRowType(rowDescriptor.type)
        }
        return formBaseCellClass
    }
}
